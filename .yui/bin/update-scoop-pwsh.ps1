<#
.SYNOPSIS
Updates Scoop's user-installed pwsh without closing existing PowerShell sessions.
.DESCRIPTION
Run: update-scoop-pwsh (the adjacent .cmd launcher is on PATH).
Alternatively: & "$HOME\.local\bin\update-scoop-pwsh.ps1"
The script runs in Windows PowerShell 5.1, refreshes Scoop's buckets, temporarily
ignores running processes, and renames both the old executable and its shim.
The previous ignore_running_processes setting is restored in finally.
Existing sessions keep running the old version; reopen terminals to use the new one.
Locked shim backups are retained with a warning. Delete them after closing the old
sessions. No processes are killed and old version directories are not cleaned up.
This script manages the per-user installation only, not a global installation.
Do not run other Scoop commands concurrently or forcibly terminate this updater:
the temporary setting is shared and forced termination prevents finally cleanup.
#>
[CmdletBinding()]
param()

$windowsPowerShell = Join-Path $env:SystemRoot 'System32\WindowsPowerShell\v1.0\powershell.exe'
if ($PSVersionTable.PSEdition -ne 'Desktop') {
    & $windowsPowerShell -NoProfile -ExecutionPolicy Bypass -File $PSCommandPath
    exit $LASTEXITCODE
}

$ErrorActionPreference = 'Stop'
# A pwsh parent can put incompatible PowerShell 7 modules ahead of Windows modules.
$env:PSModulePath = "$PSHOME\Modules;" + $env:PSModulePath
Import-Module "$PSHOME\Modules\Microsoft.PowerShell.Utility\Microsoft.PowerShell.Utility.psd1"

$scoopShim = (Get-Command scoop.ps1 -CommandType ExternalScript -ErrorAction Stop).Source
$scoopRoot = Split-Path (Split-Path $scoopShim -Parent) -Parent
$scoopHome = Join-Path $scoopRoot 'apps\scoop\current'
$scoopCommand = Join-Path $scoopHome 'bin\scoop.ps1'
if (!(Test-Path -LiteralPath $scoopCommand)) {
    throw "Cannot find Scoop's command script: $scoopCommand"
}

function Invoke-Scoop {
    param([string[]]$Arguments)
    # Isolate Scoop's exit/abort so that it cannot bypass this script's finally.
    $quoted = @($scoopCommand) + $Arguments | ForEach-Object {
        "'" + $_.Replace("'", "''") + "'"
    }
    $command = '$ErrorActionPreference = ''Stop''; & ' + ($quoted -join ' ') + '; if (!$?) { exit 1 }'
    & $windowsPowerShell -NoProfile -ExecutionPolicy Bypass -OutputFormat Text -Command $command
    if ($LASTEXITCODE -ne 0) {
        throw "scoop $($Arguments -join ' ') failed (exit $LASTEXITCODE)."
    }
}

Invoke-Scoop -Arguments @('update')
# Read config after Scoop's self-update, using Scoop's own config location rules.
. (Join-Path $scoopHome 'lib\core.ps1')
$previousSetting = get_config IGNORE_RUNNING_PROCESSES
$hadSetting = $null -ne $scoopConfig.PSObject.Properties['ignore_running_processes']

$current = Join-Path $scoopdir 'apps\pwsh\current'
$currentItem = Get-Item -LiteralPath $current -ErrorAction Stop
$target = @($currentItem.Target)[0]
if (!$target) {
    throw "Expected a Scoop current junction at $current."
}
if (![IO.Path]::IsPathRooted($target)) {
    $target = Join-Path (Split-Path $current -Parent) $target
}
$oldDirectory = [IO.Path]::GetFullPath($target)
$oldExe = Join-Path $oldDirectory 'pwsh.exe'
$shim = Join-Path $scoopdir 'shims\pwsh.exe'
if (!(Test-Path -LiteralPath $oldExe) -or !(Test-Path -LiteralPath $shim)) {
    throw 'The installed pwsh executable or shim is missing. Repair with scoop reset pwsh first.'
}

$id = [Guid]::NewGuid().ToString('N')
$exeBackup = Join-Path $oldDirectory "pwsh-update-backup-$id.exe"
$shimBackup = Join-Path (Split-Path $shim -Parent) "pwsh-update-backup-$id.exe"
$settingChanged = $false
$updateError = $null
$cleanupErrors = @()

try {
    $settingChanged = $true
    Invoke-Scoop -Arguments @('config', 'ignore_running_processes', 'true')
    Rename-Item -LiteralPath $oldExe -NewName ([IO.Path]::GetFileName($exeBackup))
    Rename-Item -LiteralPath $shim -NewName ([IO.Path]::GetFileName($shimBackup))
    Invoke-Scoop -Arguments @('update', 'pwsh')
} catch {
    $updateError = $_
} finally {
    # Always use the original version directory: current may now point elsewhere.
    try {
        if (Test-Path -LiteralPath $exeBackup) {
            Rename-Item -LiteralPath $exeBackup -NewName 'pwsh.exe'
        }
    } catch {
        $cleanupErrors += "Cannot restore $oldExe from ${exeBackup}: $($_.Exception.Message)"
    }
    try {
        if (Test-Path -LiteralPath $shimBackup) {
            if (!(Test-Path -LiteralPath $shim)) {
                Rename-Item -LiteralPath $shimBackup -NewName 'pwsh.exe'
            } else {
                try {
                    Remove-Item -LiteralPath $shimBackup -ErrorAction Stop
                } catch {
                    Write-Warning "Locked backup retained: $shimBackup. Delete it after closing the old pwsh sessions."
                }
            }
        }
    } catch {
        $cleanupErrors += "Cannot restore the shim from ${shimBackup}: $($_.Exception.Message)"
    }
    try {
        if ($settingChanged) {
            if ($hadSetting -and $null -ne $previousSetting) {
                Invoke-Scoop -Arguments @('config', 'ignore_running_processes', [string]$previousSetting)
            } elseif ($hadSetting) {
                # Preserve an explicit JSON null rather than changing it to absent.
                $scoopConfig = load_cfg $configFile
                set_config IGNORE_RUNNING_PROCESSES $null
            } else {
                Invoke-Scoop -Arguments @('config', 'rm', 'ignore_running_processes')
            }
        }
    } catch {
        $cleanupErrors += "Cannot restore ignore_running_processes: $($_.Exception.Message)"
    }
}

if ($cleanupErrors.Count -gt 0) {
    if ($updateError) { Write-Warning $updateError.Exception.Message }
    throw ($cleanupErrors -join [Environment]::NewLine)
}
if ($updateError) {
    # Scoop may have removed the shim sidecar before failing. Rebuild it if possible.
    if ((Test-Path -LiteralPath (Join-Path $current 'pwsh.exe')) -and
        !(Test-Path -LiteralPath (Join-Path $scoopdir 'shims\pwsh.shim'))) {
        try { Invoke-Scoop -Arguments @('reset', 'pwsh') }
        catch { Write-Warning "Shim repair failed: $($_.Exception.Message)" }
    }
    throw $updateError
}

$version = & $shim -NoProfile -Command '[Console]::WriteLine([string]$PSVersionTable.PSVersion)'
if ($LASTEXITCODE -ne 0) {
    throw "Updated pwsh could not start (exit $LASTEXITCODE)."
}
Write-Host "pwsh is ready: $version. Reopen terminals to use this version."
