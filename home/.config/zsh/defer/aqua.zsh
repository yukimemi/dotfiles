# =============================================================================
# File        : aqua.zsh
# Author      : yukimemi
# Last Change : 2023/09/16 20:38:51.
# =============================================================================

# (( $+commands[aqua] )) || curl -sSfL https://raw.githubusercontent.com/aquaproj/aqua-installer/main/aqua-installer | bash
(( $+commands[aqua] )) || go install github.com/aquaproj/aqua/v2/cmd/aqua@latest
