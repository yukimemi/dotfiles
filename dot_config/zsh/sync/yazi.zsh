# =============================================================================
# File        : yazi.zsh
# Author      : yukimemi
# Last Change : 2025/01/01 14:44:28.
# =============================================================================

(( $+commands[yazi] )) || cargo install yazi-cli yazi-fm

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

