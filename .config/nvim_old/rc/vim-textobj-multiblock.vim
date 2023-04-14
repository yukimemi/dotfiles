let g:textobj_multiblock_blocks = [
      \	['\_^\s*\<function\>.*', '\_^\s*endfunction\_$'],
      \	['\_^\s*\<if\>.*', '\_^\s*\<endif\>\s*\_$'],
      \]
let g:textobj_multiblock_search_limit = 200

Keymap xo ab <Plug>(textobj-multiblock-a)
Keymap xo ib <Plug>(textobj-multiblock-i)

