# omp-agent.ps1 - drive `omp` (oh-my-pi) as a magi `kind = "command"` seat.
#
# Why this file exists at all:
#
#   magi's `Command` seat is plain text in, plain text out. `omp --mode=json`
#   is neither: the session id magi would need for multi-turn continuity is on
#   the *first stdout line* as JSON, and the answer is inside a later
#   `agent_end` event. magi reads that stdout as the answer verbatim, so the
#   protocol has to be collapsed to text here, outside magi.
#
#   `omp` has no "resume by stored id" flag that magi itself could use: magi's
#   `{session}` placeholder only carries an id magi extracted, and its
#   `extract()` has no `command` branch that could. So this script owns the
#   conversation: one session id per (magi run, seat), remembered on disk.
#
# Contract (what magi's `Command` seat guarantees):
#   stdin   the prompt to answer; one turn per invocation
#   stdout  ONLY the final assistant message, plain text
#   stderr  free-form; magi stores it in artifacts and never parses it
#   exit    non-zero fails the seat
#
# Environment magi sets (see src/agent.rs::invoke):
#   MAGI_SEAT         this seat's key, e.g. `review-1`; the session is keyed on it
#   MAGI_RUN          run id; a *different* run gets a fresh session, so an
#                     earlier experiment cannot leak into a later one
#   MAGI_ALLOW_WRITE  1 for implement/fix seats, 0 for judges and reviewers
#   MAGI_PROMPT_FILE  the prompt's path inside the run's artifacts/ dir
#
# Configurable through magi's `[[agents]] env = { ... }`:
#   MAGI_OMP_MODEL    default `deepseek-v4-flash`
#   MAGI_OMP_HOME     session bookkeeping root; default `<data_local>\magi\omp`
#
# Not a read-only seat, and that is deliberate. `--auto-approve` is required -
# an unattended seat that stops to ask blocks until its node timeout kills it,
# exactly like opencode without `--auto` - and omp gates reads and writes
# together behind it. Read-only-ness therefore rests on the prompt plus magi's
# own worktree handling: judge worktrees are deleted after the tally, and
# reviewer worktrees are `reset --hard` to the commit under review every round.
# It does not rest on the CLI, and that is worth knowing when a reviewer's
# transcript is read.

$ErrorActionPreference = 'Stop'

$Model = if ($env:MAGI_OMP_MODEL) { $env:MAGI_OMP_MODEL } else { 'deepseek-v4-flash' }
$Root = if ($env:MAGI_OMP_HOME) {
    $env:MAGI_OMP_HOME
} else {
    Join-Path $env:LOCALAPPDATA 'magi\omp'
}

$Seat = if ($env:MAGI_SEAT) { $env:MAGI_SEAT } else { 'default' }
$Run = if ($env:MAGI_RUN) { $env:MAGI_RUN } else { 'norun' }

# omp prints `Working...` and other status lines to stdout unless the log level
# is quiet; magi would read them as part of the answer.
$env:PI_LOG_LEVEL = 'error'

New-Item -ItemType Directory -Force -Path $Root | Out-Null

# The state file is keyed on (workspace, seat), not seat alone: `review-1`
# exists in every repository, and a session id from another checkout would
# resume a conversation about a different tree. The run id is checked below as
# well; this only keeps the files from colliding in the first place.
$fingerprint = [System.Security.Cryptography.SHA256]::Create()
$bytes = [System.Text.Encoding]::UTF8.GetBytes((Get-Location).Path.ToLowerInvariant())
$tag = ([System.BitConverter]::ToString($fingerprint.ComputeHash($bytes)) -replace '-', '').Substring(0, 12).ToLowerInvariant()
$fingerprint.Dispose()
$statePath = Join-Path $Root ("{0}-{1}.json" -f $tag, $Seat)

# A stored session is only reused when it belongs to this same run. This is the
# one place a stale conversation could sneak back in, so it is an equality
# check on the run id and not a timestamp or a "looks recent" heuristic.
$sessionId = $null
if (Test-Path $statePath) {
    try {
        $state = Get-Content $statePath -Raw | ConvertFrom-Json
        if ($state.run -eq $Run -and $state.session) { $sessionId = $state.session }
    } catch {
        # An unreadable state file is treated as no state: start clean rather
        # than fail the seat over bookkeeping.
        $sessionId = $null
    }
}

$prompt = [Console]::In.ReadToEnd()
if ([string]::IsNullOrWhiteSpace($prompt)) {
    [Console]::Error.WriteLine('omp-agent: empty prompt on stdin')
    exit 2
}

$argv = @('-p', '--mode=json', '--auto-approve', '--model', $Model)
if ($sessionId) { $argv += @('--resume', $sessionId) }

# stderr is left attached, so omp's reasoning stream lands in the seat's
# artifact files next to the prompt magi wrote.
#
# stdout is redirected to a *file* and read back as UTF-8 on purpose. Piping a
# native command's output through a PowerShell pipeline - into a variable, or
# through Out-File - decodes its bytes with the console encoding and re-encodes
# them on the way out, which damages every non-ASCII character the agent writes.
# magi's seats here answer in Japanese, so a review arrived as mangled text
# inside otherwise valid JSON and magi dropped it as "no JSON object"; the
# answer was thrown away twice before this. Plain redirection is handled by the
# shell, not by PowerShell's string machinery, so the bytes reach the file
# exactly as omp wrote them.
$streamPath = Join-Path $Root ("{0}-stream.jsonl" -f $tag)
$prompt | & omp @argv > $streamPath
$code = $LASTEXITCODE

$isJson = { param($l) $l -is [string] -and $l.StartsWith('{') }
$fail = { param($msg) [Console]::Error.WriteLine("omp-agent: $msg"); exit 1 }

# ReadAllLines with an explicit encoding, not Get-Content: the latter guesses
# the encoding per host and would undo the point of the redirect.
$lines = @()
if (Test-Path $streamPath) {
    $lines = [System.IO.File]::ReadAllLines($streamPath, [System.Text.Encoding]::UTF8)
}

if ($code -ne 0) {
    $lines | Select-Object -Last 20 | ForEach-Object { [Console]::Error.WriteLine($_) }
    & $fail "omp exited $code"
}

$sessionLine = $lines | Where-Object { & $isJson $_ } |
    Where-Object { $_ -match '"type"\s*:\s*"session"' } | Select-Object -First 1
if (-not $sessionLine) {
    $lines | Select-Object -Last 20 | ForEach-Object { [Console]::Error.WriteLine($_) }
    & $fail 'no session line on stdout; cannot continue this seat'
}

$id = ([regex]'"id"\s*:\s*"([^"]+)"').Match($sessionLine).Groups[1].Value
if (-not $id) { & $fail 'session line carried no id' }

# Persist before printing the answer: a crash between the two must not lose the
# conversation, or the next turn silently restarts with no memory.
$state = @{ run = $Run; seat = $Seat; session = $id; model = $Model } | ConvertTo-Json -Compress
Set-Content -Path $statePath -Value $state -Encoding utf8

# The answer is the last non-empty assistant text block anywhere in the stream.
#
# Do not key on `agent_end`: omp only emits it for a run that quiesces on a
# *message* turn, while the review seats here routinely end on a tool call
# (`stopReason: toolUse`), where the run quiesces with no `agent_end` line at
# all - the first version of this script lost three complete reviews to that.
# Earlier assistant text narrates the tool loop ("."), so only the last
# non-empty block counts as the answer.
#
# Three carriers are walked because the turn shape decides which one appears:
#   agent_end     -> `messages`, the whole thread (message-ending turns)
#   turn_end      -> `message`, the last assistant message
#   message_end   -> `message`, any message, assistant ones included
$answer = $null
foreach ($line in $lines) {
    if (-not (& $isJson $line)) { continue }
    try { $event = $line | ConvertFrom-Json } catch { continue }

    $messages = @()
    if ($event.type -eq 'agent_end' -and $event.messages) {
        $messages = $event.messages
    } elseif ($event.message) {
        $messages = @($event.message)
    } else {
        continue
    }

    foreach ($message in $messages) {
        if ($message.role -ne 'assistant') { continue }
        foreach ($part in $message.content) {
            if ($part.type -eq 'text' -and -not [string]::IsNullOrWhiteSpace($part.text)) {
                $answer = $part.text
            }
        }
    }
}

if ([string]::IsNullOrWhiteSpace($answer)) {
    $lines | Select-Object -Last 20 | ForEach-Object { [Console]::Error.WriteLine($_) }
    & $fail "no assistant text in the stream (session $id)"
}

# The stream is kept only long enough to be read. The reasoning deltas are not
# lost by deleting it: stderr stayed attached through the run, so magi already
# captured them into the seat's `.err` artifact beside the prompt.
Remove-Item -Path $streamPath -Force -ErrorAction SilentlyContinue

Write-Output $answer
exit 0
