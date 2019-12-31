nnoremap scc :<C-u>Clap<CR>
nnoremap scb :<C-u>Clap buffers<CR>
nnoremap scm :<C-u>Clap marks<CR>
nnoremap scl :<C-u>Clap blines<CR>
nnoremap scf :<C-u>Clap files --hidden<CR>
nnoremap scG :<C-u>Clap files --hidden ~/.ghq/src<CR>
nnoremap scF :<C-u>Clap filetypes<CR>
nnoremap sch :<C-u>Clap command_history<CR>
nnoremap scu :<C-u>Clap history<CR>
nnoremap scC :<C-u>Clap commits<CR>
nnoremap scj :<C-u>Clap jumps<CR>
nnoremap scw :<C-u>Clap windows<CR>
nnoremap scg :<C-u>Clap grep<CR>
nnoremap scM :<C-u>execute printf("Clap files --hidden %s", g:memolist_path)<CR>
