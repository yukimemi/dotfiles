"---------------------------------------------------------------------------
" For Windows:
"

" In Windows, can't find exe, when $PATH isn't contained $VIM.
if $PATH !~? $'\(^\|;\){$VIM->escape('\\')}\(;\|$\)'
  let $PATH = $'{$VIM};{$PATH}'
endif

" Change colorscheme.
" Don't override colorscheme.
if !has('gui_running') && !has('nvim')
  set t_Co=256
endif
