" =============================================================================
" File        : junkfile.vim
" Author      : yukimemi
" Last Change : 2023/12/09 00:45:40.
" =============================================================================

command! -range -nargs=? JunkfileOpen <line1>,<line2>call junkfile#open(strftime('%Y-%m-%d-%H%M%S.'), <q-args>)

