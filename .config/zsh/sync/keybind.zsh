# =============================================================================
# File        : keybind.zsh
# Author      : yukimemi
# Last Change : 2023/12/30 20:31:53.
# =============================================================================

bindkey -v

function my_lazy_keybindings() {
  bindkey -M viins '^q' show-buffer-stack

  # histry-substring-search.
  bindkey -M viins '^p' history-substring-search-up
  bindkey -M viins '^n' history-substring-search-down

  # autosuggestions.
  bindkey -M viins '^e' autosuggest-accept
  bindkey -M viins '^f' vi-forward-word

  bindkey -M vicmd 'gh' beginning-of-line
  bindkey -M vicmd 'gl' end-of-line

  # zeno
  if [[ -n $ZENO_LOADED ]]; then
    bindkey -M viins ' ' zeno-auto-snippet
    bindkey -M viins '^m' zeno-auto-snippet-and-accept-line
    bindkey -M viins '^i' zeno-completion
    bindkey -M viins '^s' zeno-insert-snippet
  fi

  # atuin
  bindkey -M viins '^r' _atuin_search_widget

  # move at hjkl on menu select.
  zmodload zsh/complist
  bindkey -M menuselect 'h' vi-backward-char
  bindkey -M menuselect 'j' vi-down-line-or-history
  bindkey -M menuselect 'k' vi-up-line-or-history
  bindkey -M menuselect 'l' vi-forward-char

  # reassign tab for zsh-autocomplete.
  bindkey '\t' menu-select "$terminfo[kcbt]" menu-select
  bindkey -M menuselect '\t' menu-complete "$terminfo[kcbt]" reverse-menu-complete
}
zvm_after_init_commands+=(my_lazy_keybindings)

