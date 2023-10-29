if !g:plugin_use_gina
  finish
endif

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
