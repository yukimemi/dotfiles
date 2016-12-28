@set scriptPath=%~f0&@powershell -NoProfile -ExecutionPolicy ByPass "$s=[scriptblock]::create((gc \"%~f0\"|?{$_.readcount -gt 2})-join\"`n\");&$s" %*
@exit /b %errorlevel%
function Get-UserModulePath {

  $Path = $env:PSModulePath -split ";" -match $env:USERNAME

  if (-not (Test-Path -Path $Path))
  {
    New-Item -Path $Path -ItemType Container | Out-Null
  }
  $Path
}

$pesterDir = Read-Host "Enter Pester dir"
Copy-Item -Force -Recurse $pesterDir (Get-UserModulePath)
Invoke-Item (Get-UserModulePath)
