if !IsInstalled('autoload/fzf/vim.vim') || exists('g:loaded_fzf_cfg')
  finish
endif
let g:loaded_fzf_cfg = 1

tnoremap <expr> <Esc> (&filetype == "fzf") ? "<Esc>" : "<c-\><c-n>"

command! -bang FilesBufferDir call fzf#vim#files(fnamemodify(expand('%'), ':p:h'), <bang>0)
command! -bang FilesMemolist call fzf#vim#files(expand(g:memolist_path), <bang>0)
command! -bang FilesGhq call fzf#vim#files(expand('~/.ghq/src'), <bang>0)

nnoremap <silent> scp :<C-u>Files<CR>
nnoremap <silent> scb :<C-u>Buffers<CR>
nnoremap <silent> scd :<C-u>FilesBufferDir<CR>
nnoremap <silent> scu :<C-u>History<CR>
nnoremap <silent> scm :<C-u>Marks<CR>
nnoremap <silent> scf :<C-u>Filetypes<CR>
nnoremap <silent> sch :<C-u>History:<CR>
nnoremap <silent> scl :<C-u>FilesMemolist<CR>
nnoremap <silent> scg :<C-u>FilesGhq<CR>

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
