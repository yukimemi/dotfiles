<#
  .SYNOPSIS
    Close-ExplorerWindows.ps1
  .DESCRIPTION
    Close all explorer windows
  .INPUTS
    - None
  .OUTPUTS
    - 0: SUCCESS / 1: ERROR
  .Last Change : 2026/01/11 23:41:31.
#>

for ($i = 0; $i -lt 10; $i++) {
    $shell = New-Object -ComObject Shell.Application
    $windows = $shell.Windows()
    $targets = @()
    foreach ($win in $windows) {
        if ($win.FullName -match "explorer.exe") {
            $targets += $win
        }
    }
    if ($targets.Count -eq 0) {
        break
    }
    Write-Host "Closing $($targets.Count) windows..."
    foreach ($t in $targets) {
        try {
            $t.Quit()
        } catch {
        }
    }
    Start-Sleep -m 500
}
Write-Host "Done."
