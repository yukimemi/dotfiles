if !IsInstalled("autoload/operator/flashy.vim")
  finish
endif

map y <Plug>(operator-flashy)
nmap Y <Plug>(operator-flashy)$

