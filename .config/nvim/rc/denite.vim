" Use plefix s
nnoremap sdc :<C-u>Denite colorscheme -auto-preview<CR>
nnoremap sdb :<C-u>Denite buffer<CR>
nnoremap sdf :<C-u>Denite file<CR>
nnoremap sdF :<C-u>Denite file_rec<CR>
" nnoremap sdu :<C-u>Denite buffer file_old<CR>
nnoremap sdd :<C-u>Denite buffer file_mru file_rec<CR>
nnoremap sdo :<C-u>Denite outline -no-quit -mode=normal<CR>
nnoremap sdh :<C-u>Denite help<CR>
nnoremap sdr :<C-u>Denite register<CR>
nnoremap sdg :<C-u>Denite -no-empty grep<CR>
nnoremap sd/ :<C-u>Denite line -no-quit<CR>
nnoremap sdR :<C-u>Denite <CR>

noremap sdl :<C-u>Denite command_history<CR>

" Incremental search in cmdline history.
inoremap <C-l> <ESC>:<C-u>Denite command<CR>

" Load after settings.
if has('python3')
  au MyAutoCmd VimEnter * call <SID>denite_aft()
endif
function! s:denite_aft() abort
  " Default options.
  call denite#custom#option('default', {
        \ 'prompt': '»',
        \ 'cursor_wrap': v:true,
        \ 'auto_resize': v:true,
        \ 'highlight_mode_insert': 'WildMenu'
        \ })

  if executable('jvgrep')
    " jvgrep command on grep source
    call denite#custom#var('grep', 'command', ['jvgrep'])
    call denite#custom#var('grep', 'default_opts', [])
    call denite#custom#var('grep', 'recursive_opts', ['-R'])
    call denite#custom#var('grep', 'pattern_opt', [])
    call denite#custom#var('grep', 'separator', [])
    call denite#custom#var('grep', 'final_opts', [])

  elseif executable('rg')
    " Ripgrep command on grep source
    call denite#custom#var('grep', 'command', ['rg'])
    call denite#custom#var('grep', 'default_opts',
          \ ['--vimgrep', '--no-heading'])
    call denite#custom#var('grep', 'recursive_opts', [])
    call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
    call denite#custom#var('grep', 'separator', ['--'])
    call denite#custom#var('grep', 'final_opts', [])

  elseif executable('pt')
    " Pt command on grep source
    call denite#custom#var('grep', 'command', ['pt'])
    call denite#custom#var('grep', 'default_opts',
          \ ['--nogroup', '--nocolor', '--smart-case'])
    call denite#custom#var('grep', 'recursive_opts', [])
    call denite#custom#var('grep', 'pattern_opt', [])
    call denite#custom#var('grep', 'separator', ['--'])
    call denite#custom#var('grep', 'final_opts', [])
  endif
  " custom mappings.
  call denite#custom#map('insert', '<C-n>', '<denite:move_to_next_line>', 'noremap')
  call denite#custom#map('insert', '<C-p>', '<denite:move_to_previous_line>', 'noremap')
  call denite#custom#map('insert', '<C-[>', '<denite:enter_mode:normal>', 'noremap')
  call denite#custom#map('normal', '<C-[>', '<denite:quit>', 'noremap')
endfunction

