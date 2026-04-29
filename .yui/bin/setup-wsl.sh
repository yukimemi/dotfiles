#!/bin/bash
# Generate /etc/wsl.conf inline (was etc/wsl.conf in chezmoi).
sudo tee /etc/wsl.conf > /dev/null <<'WSLCONF'
[boot]
systemd=true

[interop]
appendWindowsPath = false
WSLCONF
