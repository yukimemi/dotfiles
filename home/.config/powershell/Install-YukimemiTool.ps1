function Install-YukimemiTool {
  param([Parameter(Mandatory)][string]$Name)

  $arch = [System.Runtime.InteropServices.RuntimeInformation]::OSArchitecture.ToString()
  $target = if ($IsWindows -and $arch -eq "X64") {
    @{ Triple = "x86_64-pc-windows-msvc"; Ext = "zip"; Exe = "$Name.exe" }
  } elseif ($IsLinux -and $arch -eq "X64") {
    @{ Triple = "x86_64-unknown-linux-musl"; Ext = "tar.gz"; Exe = $Name }
  } elseif ($IsMacOS -and $arch -eq "Arm64") {
    @{ Triple = "aarch64-apple-darwin"; Ext = "tar.gz"; Exe = $Name }
  } else {
    Write-Warning "No pre-built $Name release for this platform ($arch). Try: cargo install $Name"
    return $null
  }

  $binDir = Join-Path $HOME ".local/bin"
  $tmp = Join-Path ([IO.Path]::GetTempPath()) "yukimemi-$Name-$([guid]::NewGuid().ToString('N'))"
  $dest = Join-Path $binDir $target.Exe
  $oldProgress = $ProgressPreference
  $ProgressPreference = "SilentlyContinue"
  try {
    New-Item -ItemType Directory -Force -Path $tmp, $binDir | Out-Null
    $archive = Join-Path $tmp "$Name.$($target.Ext)"
    $url = "https://github.com/yukimemi/$Name/releases/latest/download/$Name-$($target.Triple).$($target.Ext)"
    Write-Host "Downloading $url" -ForegroundColor Cyan
    Invoke-WebRequest -Uri $url -OutFile $archive -UseBasicParsing -ErrorAction Stop
    if ($target.Ext -eq "zip") {
      Expand-Archive -Path $archive -DestinationPath $tmp -Force -ErrorAction Stop
    } else {
      tar -xzf $archive -C $tmp
      if ($LASTEXITCODE -ne 0) { throw "tar exited with $LASTEXITCODE" }
    }
    Copy-Item -LiteralPath (Join-Path $tmp $target.Exe) -Destination $dest -Force -ErrorAction Stop
    if (-not $IsWindows) {
      chmod +x $dest
    }
  } catch {
    Write-Warning "Failed to install ${Name}: $_"
    return $null
  } finally {
    $ProgressPreference = $oldProgress
    Remove-Item -LiteralPath $tmp -Recurse -Force -ErrorAction SilentlyContinue
  }

  if (($env:PATH -split [IO.Path]::PathSeparator) -notcontains $binDir) {
    $env:PATH = "$binDir$([IO.Path]::PathSeparator)$env:PATH"
  }
  Write-Host "Installed $dest" -ForegroundColor Green
  return $dest
}
