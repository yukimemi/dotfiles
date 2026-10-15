#!/bin/bash
set -euo pipefail

case "$(uname -r)" in
  *[Mm]icrosoft*|*[Ww][Ss][Ll]*) ;;
  *)
    printf 'setup-wsl: not WSL; skipping.\n'
    exit 0
    ;;
esac

# Generate /etc/wsl.conf inline (was etc/wsl.conf in chezmoi).
sudo tee /etc/wsl.conf > /dev/null <<'WSLCONF'
[boot]
systemd=true

[interop]
appendWindowsPath = false
WSLCONF
