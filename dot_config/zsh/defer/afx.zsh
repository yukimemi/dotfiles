# =============================================================================
# File        : afx.zsh
# Author      : yukimemi
# Last Change : 2023/09/15 23:53:52.
# =============================================================================

(( $+commands[afx] )) || tea +go.dev -- go install github.com/b4b4r07/afx@latest
source <(afx init)
source <(afx completion zsh)

