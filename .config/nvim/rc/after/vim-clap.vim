" =============================================================================
" File        : vim-clap.vim
" Author      : yukimemi
" Last Change : 2024/03/23 16:32:33.
" =============================================================================

let g:clap_layout = { 'relative': 'editor', 'row': '20%', 'col': '20%' }
let g:clap_popup_border = 'nil'
let g:clap_theme = 'material_design_dark'

nnoremap scc <cmd>Clap<cr>
nnoremap scb <cmd>Clap buffers<cr>
nnoremap scm <cmd>Clap marks<cr>
nnoremap scl <cmd>Clap blines<cr>
nnoremap scf <cmd>Clap files --hidden<cr>
nnoremap scr <cmd>Clap files --hidden ~/src<cr>
nnoremap scd <cmd>execute printf("Clap files --hidden %s", expand("~/.dotfiles"))<cr>
nnoremap scF <cmd>Clap filetypes<cr>
nnoremap sch <cmd>Clap command_history<cr>
nnoremap scH <cmd>Clap help_tags<cr>
nnoremap scu <cmd>Clap history<cr>
nnoremap scC <cmd>Clap commits<cr>
nnoremap scj <cmd>Clap jumps<cr>
nnoremap scw <cmd>Clap windows<cr>
nnoremap scg <cmd>Clap grep<cr>
nnoremap scM <cmd>execute printf("Clap files --hidden %s", g:memolist_path)<cr>
