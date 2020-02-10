nnoremap scc :<c-u>Clap<cr>
nnoremap scb :<c-u>Clap buffers<cr>
nnoremap scm :<c-u>Clap marks<cr>
nnoremap scl :<c-u>Clap blines<cr>
nnoremap scf :<c-u>Clap files --hidden<cr>
nnoremap scG :<c-u>Clap files --hidden ~/.ghq/src<cr>
nnoremap scF :<c-u>Clap filetypes<cr>
nnoremap sch :<c-u>Clap command_history<cr>
nnoremap scu :<c-u>Clap history<cr>
nnoremap scC :<c-u>Clap commits<cr>
nnoremap scj :<c-u>Clap jumps<cr>
nnoremap scw :<c-u>Clap windows<cr>
nnoremap scg :<c-u>Clap grep<cr>
nnoremap scM :<c-u>execute printf("Clap files --hidden %s", g:memolist_path)<cr>
