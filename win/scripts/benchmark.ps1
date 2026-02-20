# =============================================================================
# File        : benchmark.ps1
# Description : Benchmark PowerShell profile loading time
# Last Change : 2026/01/04 00:33:26.
# =============================================================================

$ErrorActionPreference = "Stop"
$ProfilePath = pwsh -NoProfile -Command 'Write-Host $PROFILE'

if (-not (Test-Path $ProfilePath)) {
    Write-Warning "Profile not found at: $ProfilePath"
    exit 1
}

Write-Host "Starting Benchmark for PowerShell Profile..." -ForegroundColor Cyan
Write-Host "Profile: $ProfilePath" -ForegroundColor DarkGray
Write-Host "--------------------------------------------------" -ForegroundColor DarkGray

# 1. Measure Core Startup (No Profile)
Write-Host "Measuring Core Startup (pwsh -NoProfile)... " -NoNewline
$sw = [System.Diagnostics.Stopwatch]::StartNew()
pwsh -NoProfile -Command "exit"
$sw.Stop()
$CoreTime = $sw.ElapsedMilliseconds
Write-Host "$CoreTime ms" -ForegroundColor Green

# 2. Measure Full Startup
Write-Host "Measuring Full Startup (pwsh)...            " -NoNewline
$sw.Restart()
pwsh -Command "exit"
$sw.Stop()
$FullTime = $sw.ElapsedMilliseconds
Write-Host "$FullTime ms" -ForegroundColor Yellow

# 3. Measure Profile Load Only (Internal)
Write-Host "Measuring Profile Load Only (Internal)...   " -NoNewline
$cmd = {
    param($p)
    $sw = [System.Diagnostics.Stopwatch]::StartNew()
    try {
        . $p
    } catch {
        # Ignore non-critical load errors during benchmark
    }
    $sw.Stop()
    return $sw.ElapsedMilliseconds
}

# Run in a separate process to simulate fresh start
$Job = Start-Job -ScriptBlock $cmd -ArgumentList $ProfilePath
$LoadTime = $Job | Receive-Job -Wait -AutoRemoveJob
Write-Host "$LoadTime ms" -ForegroundColor Magenta

Write-Host "--------------------------------------------------" -ForegroundColor DarkGray
Write-Host "Summary:" -ForegroundColor Cyan
Write-Host "  Core Overhead:   $CoreTime ms"
Write-Host "  Profile Load:    $LoadTime ms"
Write-Host "  Total (approx):  $FullTime ms"

if ($LoadTime -gt 1000) {
    Write-Host "`n[WARN] Profile loading is slow (>1s)!" -ForegroundColor Red
} elseif ($LoadTime -gt 500) {
    Write-Host "`n[INFO] Profile loading is moderate (500ms - 1s)." -ForegroundColor Yellow
} else {
    Write-Host "`n[OK] Profile loading is fast (<500ms)." -ForegroundColor Green
}
