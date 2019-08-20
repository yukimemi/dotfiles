<#
  .SYNOPSYS
    {{_name_}}
  .DESCRIPTION
    {{_cursor_}}
  .INPUTS

  .Last Change : 2017/08/29 08:31:50.
#>

$cmdFile = & {
  if ($env:scriptPath) {
    return [System.IO.Path]::GetFullPath($env:scriptPath)
  } else {
    return [System.IO.Path]::GetFullPath($script:MyInvocation.MyCommand.Path)
  }
}
$cmdDir = [System.IO.Path]::GetDirectoryName($cmdFile)
$cmdName = [System.IO.Path]::GetFileNameWithoutExtension($cmdFile)
$cmdFileName = [System.IO.Path]::GetFileName($cmdFile)

