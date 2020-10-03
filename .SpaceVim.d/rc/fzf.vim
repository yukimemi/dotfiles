if !IsInstalled('autoload/fzf/vim.vim') || exists('g:loaded_fzf_cfg')
  finish
endif
let g:loaded_fzf_cfg = 1

tnoremap <expr> <Esc> (&filetype == "fzf") ? "<Esc>" : "<c-\><c-n>"

command! -bang FilesBufferDir call fzf#vim#files(fnamemodify(expand('%'), ':p:h'), <bang>0)
command! -bang FilesMemolist call fzf#vim#files(expand(g:memolist_path), <bang>0)
command! -bang FilesGhq call fzf#vim#files(expand('~/.ghq/src'), <bang>0)


nnoremap <silent> scp :<c-u>Files<cr>
" nnoremap <silent> scb :<c-u>Buffers<cr>
" nnoremap <silent> scd :<c-u>FilesBufferDir<cr>
" nnoremap <silent> scu :<c-u>History<cr>
" nnoremap <silent> scm :<c-u>Marks<cr>
nnoremap <silent> scF :<c-u>Filetypes<cr>
nnoremap <silent> sch :<c-u>History:<cr>
nnoremap <silent> scl :<c-u>FilesMemolist<cr>
nnoremap <silent> scg :<c-u>FilesGhq<cr>

" An action can be a reference to a function that processes selected lines
function! s:build_quickfix_list(lines) abort
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
      \ 'ctrl-q': function('s:build_quickfix_list'),
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-x': 'split',
      \ 'ctrl-v': 'vsplit',
      \ }

" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'down': '~40%' }

" Customize fzf colors to match your color scheme
" - fzf#wrap translates this to a set of `--color` options
let g:fzf_colors = {
      \ 'fg':      ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Normal'],
      \ 'hl':      ['fg', 'Comment'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'border':  ['fg', 'Ignore'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment'],
      \ }

" Enable per-command history
" - History files will be stored in the specified directory
" - When set, CTRL-N and CTRL-P will be bound to 'next-history' and
"   'previous-history' instead of 'down' and 'up'.
let g:fzf_history_dir = '~/.local/share/fzf-history'
