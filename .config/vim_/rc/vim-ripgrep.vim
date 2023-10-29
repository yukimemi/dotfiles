command! -nargs=* -complete=file Rg :call ripgrep#search(<q-args>)

