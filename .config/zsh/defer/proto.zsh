# =============================================================================
# File        : proto.zsh
# Author      : yukimemi
# Last Change : 2024/04/28 20:33:39.
# =============================================================================

(( $+commands[proto] )) || curl -fsSL https://moonrepo.dev/install/proto.sh | bash -s -- --no-profile --yes

# proto
export PROTO_HOME="$HOME/.proto"
export PATH="$PROTO_HOME/shims:$PROTO_HOME/bin:$PATH"
