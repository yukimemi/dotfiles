# =============================================================================
# File        : mise.zsh
# Author      : yukimemi
# Last Change : 2024/01/03 22:42:39.
# =============================================================================

(( $+commands[mise] )) || curl https://mise.jdx.dev/install.sh | sh
eval "$(~/.local/share/mise/bin/mise activate zsh)"

# mise hits the GitHub API unauthenticated (60/h) and `mise up` fails with
# HTTP 403. Reuse gh's login, scoped to mise only. Deferred, so no startup cost.
if [[ -z $MISE_GITHUB_TOKEN ]] && (( $+commands[gh] )); then
  export MISE_GITHUB_TOKEN="$(gh auth token 2>/dev/null)"
fi

