let g:textobj_multiblock_blocks = [
      \	['\_^\s*\<function\>.*', '\_^\s*endfunction\_$'],
      \	['\_^\s*\<if\>.*', '\_^\s*\<endif\>\s*\_$'],
      \]
let g:textobj_multiblock_search_limit = 200

omap ab <Plug>(textobj-multiblock-a)
omap ib <Plug>(textobj-multiblock-i)
xmap ab <Plug>(textobj-multiblock-a)
xmap ib <Plug>(textobj-multiblock-i)

