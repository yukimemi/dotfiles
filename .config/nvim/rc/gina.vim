if !IsInstalled("autoload/gina.vim")
  finish
endif

nnoremap <space>gs :<c-u>Gina status<cr>
nnoremap <space>gb :<c-u>Gina branch<cr>
nnoremap <space>gg :<c-u>Gina grep<cr>
nnoremap <space>gd :<c-u>Gina diff<cr>
nnoremap <space>gl :<c-u>Gina ls-files<cr>
nnoremap <space>gp :<c-u>Gina push<cr>

au MyAutoCmd VimEnter * call <SID>my_gina_settings()

function! s:my_gina_settings() abort
  call gina#custom#command#alias('branch', 'br')
  call gina#custom#command#option('br', '-v', 'v')
  call gina#custom#command#option(
        \ '/\%(log\|reflog\)',
        \ '--opener', 'vsplit'
        \ )
  call gina#custom#command#option(
        \ 'log', '--group', 'log-viewer'
        \ )
  call gina#custom#command#option(
        \ 'reflog', '--group', 'reflog-viewer'
        \ )
  call gina#custom#command#option(
        \ 'commit', '-v|--verbose'
        \ )
  call gina#custom#command#option(
        \ '/\%(status\|commit\)',
        \ '-u|--untracked-files'
        \ )
  call gina#custom#command#option(
        \ '/\%(status\|changes\)',
        \ '--ignore-submodules'
        \ )

  call gina#custom#action#alias(
        \ 'branch', 'track',
        \ 'checkout:track'
        \ )
  call gina#custom#action#alias(
        \ 'branch', 'merge',
        \ 'commit:merge'
        \ )
  call gina#custom#action#alias(
        \ 'branch', 'rebase',
        \ 'commit:rebase'
        \ )

  call gina#custom#mapping#nmap(
        \ 'branch', 'g<CR>',
        \ '<Plug>(gina-commit-checkout-track)'
        \ )
  call gina#custom#mapping#nmap(
        \ 'status', '<C-^>',
        \ ':<C-u>Gina commit<CR>',
        \ {'noremap': 1, 'silent': 1}
        \ )
  call gina#custom#mapping#nmap(
        \ 'commit', '<C-^>',
        \ ':<C-u>Gina status<CR>',
        \ {'noremap': 1, 'silent': 1}
        \ )

  call gina#custom#execute(
        \ '/\%(status\|branch\|ls\|grep\|changes\|tag\)',
        \ 'setlocal winfixheight',
        \ )
endfunction
