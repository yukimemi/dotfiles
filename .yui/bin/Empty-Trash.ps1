<#
  .SYNOPSIS
    Empty-Trash.ps1
  .DESCRIPTION
    Empty the recycle bin.
  .INPUTS
    - None
  .OUTPUTS
    - None
  .Last Change : 2026/06/04 23:48:00.
#>

try {
  Clear-RecycleBin -Force -ErrorAction SilentlyContinue
  Write-Host "Recycle bin emptied successfully."
} catch {
  Write-Error "Failed to empty recycle bin: $_"
}
