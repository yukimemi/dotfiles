nnoremap <F8> :<C-u>TagbarToggle<CR>
let g:tagbar_type_rust = {
      \ 'ctagstype' : 'rust',
      \   'kinds' : [
      \     'T:types,type definitions',
      \     'f:functions,function definitions',
      \     'g:enum,enumeration names',
      \     's:structure names',
      \     'm:modules,module names',
      \     'c:consts,static constants',
      \     't:traits',
      \     'i:impls,trait implementations',
      \   ]
      \ }

let g:tagbar_type_markdown = {
      \ 'ctagstype' : 'markdown',
      \   'kinds' : [
      \     'h:Heading_L1',
      \     'i:Heading_L2',
      \     'k:Heading_L3'
      \   ]
      \ }


