# {{_name_}}
param($hoge = $(Read-Host "{{_cursor_}}"))

$ErrorActionPreference = "stop"

$commandPath = Split-Path -parent $myInvocation.MyCommand.path
$commandName = Split-Path -leaf $myInvocation.MyCommand.path
$commandBaseName = (gci $myInvocation.MyCommand.path).BaseName

Set-Location $commandPath

function main() {#{{{

  trap { Write-Host "[main]: Error $($_)"; break }


}#}}}

# call main
Measure-Command { main }

