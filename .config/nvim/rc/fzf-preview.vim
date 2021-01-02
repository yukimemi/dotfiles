nmap <leader>f [fzf-p]
xmap <leader>f [fzf-p]

nnoremap <silent> [fzf-p]p     :<c-u>FzfPreviewFromResourcesRpc project_mru git<cr>
nnoremap <silent> [fzf-p]gs    :<c-u>FzfPreviewGitStatusRpc<cr>
nnoremap <silent> [fzf-p]ga    :<c-u>FzfPreviewGitActionsRpc<cr>
nnoremap <silent> [fzf-p]b     :<c-u>FzfPreviewBuffersRpc<cr>
nnoremap <silent> [fzf-p]B     :<c-u>FzfPreviewAllBuffersRpc<cr>
nnoremap <silent> [fzf-p]o     :<c-u>FzfPreviewFromResourcesRpc buffer project_mru<cr>
nnoremap <silent> [fzf-p]<c-o> :<c-u>FzfPreviewJumpsRpc<cr>
nnoremap <silent> [fzf-p]g;    :<c-u>FzfPreviewChangesRpc<cr>
nnoremap <silent> [fzf-p]/     :<c-u>FzfPreviewLinesRpc --add-fzf-arg=--no-sort --add-fzf-arg=--query="'"<cr>
nnoremap <silent> [fzf-p]*     :<c-u>FzfPreviewLinesRpc --add-fzf-arg=--no-sort --add-fzf-arg=--query="'<c-r>=expand('<cword>')<cr>"<cr>
nnoremap          [fzf-p]gr    :<c-u>FzfPreviewProjectGrepRpc<Space>
xnoremap          [fzf-p]gr    "sy:FzfPreviewProjectGrepRpc<Space>-F<Space>"<c-r>=substitute(substitute(@s, '\n', '', 'g'), '/', '\\/', 'g')<cr>"
nnoremap <silent> [fzf-p]t     :<c-u>FzfPreviewBufferTagsRpc<cr>
nnoremap <silent> [fzf-p]q     :<c-u>FzfPreviewQuickFixRpc<cr>
nnoremap <silent> [fzf-p]l     :<c-u>FzfPreviewLocationListRpc<cr>
