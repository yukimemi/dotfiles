if !g:plugin_use_ddc
  finish
endif

let s:sources = ['vsnip', 'around', 'file']
if g:plugin_use_vimlsp
  call extend(['vim-lsp'], s:sources)
endif
if g:plugin_use_nvimlsp
  call extend(['nvim-lsp'], s:sources)
endif
if !g:is_windows
  call extend(['tmux', 'rg'], s:sources)
endif

call ddc#custom#patch_global('sources', s:sources )
call ddc#custom#patch_global('cmdlineSources', {
      \   ':': ['cmdline-history', 'cmdline', 'around'],
      \   '@': ['cmdline-history', 'input', 'file', 'around'],
      \   '>': ['cmdline-history', 'input', 'file', 'around'],
      \   '/': ['around', 'line'],
      \   '?': ['around', 'line'],
      \   '-': ['around', 'line'],
      \   '=': ['input'],
      \ })

call ddc#custom#patch_global('sourceOptions', #{
      \   _: #{
      \     ignoreCase: v:true,
      \     matchers: ['matcher_fuzzy'],
      \     sorters: ['sorter_fuzzy'],
      \     converters: [
      \       'converter_remove_overlap',
      \       'converter_truncate',
      \       'converter_fuzzy',
      \     ],
      \   },
      \   around: #{
      \     mark: 'A',
      \   },
      \   buffer: #{
      \     mark: 'B',
      \   },
      \   necovim: #{
      \    mark: 'vim'
      \   },
      \   cmdline: #{
      \     mark: 'cmdline',
      \     forceCompletionPattern: '\S/\S*|\.\w*',
      \     dup: 'force',
      \   },
      \   input: #{
      \     mark: 'input',
      \     forceCompletionPattern: '\S/\S*',
      \     isVolatile: v:true,
      \     dup: 'force',
      \   },
      \   line: #{
      \     mark: 'line',
      \   },
      \   mocword: #{
      \     mark: 'mocword',
      \     minAutoCompleteLength: 3,
      \     isVolatile: v:true,
      \   },
      \   nvim-lsp: #{
      \     mark: 'lsp',
      \     forceCompletionPattern: '\.\w*|:\w*|->\w*',
      \     dup: 'force',
      \   },
      \   rtags: #{
      \     mark: 'R',
      \     forceCompletionPattern: '\.\w*|:\w*|->\w*',
      \   },
      \   file: #{
      \     mark: 'F',
      \     isVolatile: v:true,
      \     minAutoCompleteLength: 3,
      \     forceCompletionPattern: '[\w@:~._-]/[\w@:~._-]*',
      \   },
      \   cmdline-history: #{
      \     mark: 'history',
      \     sorters: [],
      \   },
      \   shell-history: #{
      \     mark: 'shell'
      \   },
      \   zsh: #{
      \     mark: 'zsh',
      \     isVolatile: v:true,
      \     forceCompletionPattern: '\S/\S*',
      \   },
      \   rg: #{
      \     mark: 'rg',
      \     minAutoCompleteLength: 5,
      \     enabledIf: "finddir('.git', ';') != ''",
      \   },
      \   vsnip: #{
      \     mark: 'snip',
      \     dup: 'force',
      \   },
      \ })

call ddc#custom#patch_global('sourceParams', #{
      \   buffer: #{
      \     requireSameFiletype: v:false,
      \     limitBytes: 50000,
      \     fromAltBuf: v:true,
      \     forceCollect: v:true,
      \   },
      \   file: #{
      \     filenameChars: '[:keyword:].',
      \   },
      \ })

call ddc#custom#patch_filetype(
      \ ['help', 'markdown', 'gitcommit'], 'sources',
      \ ['around', 'rg', 'mocword']
      \ )
call ddc#custom#patch_filetype(['ddu-ff-filter'], #{
      \   keywordPattern: '[0-9a-zA-Z_:#-]*',
      \   sources: ['line', 'buffer'],
      \   specialBufferCompletion: v:true,
      \ })

call ddc#custom#patch_filetype(['FineCmdlinePrompt'], #{
      \   keywordPattern: '[0-9a-zA-Z_:#-]*',
      \   sources: ['cmdline-history', 'around'],
      \   specialBufferCompletion: v:true,
      \ })

" Use pum.vim
call ddc#custom#patch_global('autoCompleteEvents', [
      \ 'InsertEnter', 'TextChangedI', 'TextChangedP',
      \ 'CmdlineEnter', 'CmdlineChanged', 'TextChangedT',
      \ ])
call ddc#custom#patch_global('ui', 'pum')


" For insert mode completion
inoremap <expr> <TAB>
      \ pum#visible() ? '<Cmd>call pum#map#insert_relative(+1)<CR>' :
      \ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
      \ '<TAB>' : ddc#map#manual_complete()
inoremap <S-Tab> <Cmd>call pum#map#insert_relative(-1)<CR>
inoremap <C-n>   <Cmd>call pum#map#select_relative(+1)<CR>
inoremap <C-p>   <Cmd>call pum#map#select_relative(-1)<CR>
inoremap <C-o>   <Cmd>call pum#map#confirm()<CR>
" inoremap <expr> <C-l>   ddc#map#extend(pum#map#confirm())
inoremap <expr> <C-x><C-f> ddc#map#manual_complete('path')
inoremap <expr> l
      \ pum#entered() ?
      \ '<Cmd>call pum#map#insert_relative(+1)<CR>' : 'l'
inoremap <expr> h
      \ pum#entered() ?
      \ '<Cmd>call pum#map#insert_relative(-1)<CR>' : 'h'
inoremap <expr> <C-e>
      \ ddc#map#insert_item(0, '<Cmd>call pum#map#cancel()<CR>')
inoremap <C-y>   <Cmd>call pum#map#confirm()<CR>

" For command line mode completion
cnoremap <expr> <Tab>
      \ pum#visible() ? '<Cmd>call pum#map#insert_relative(+1)<CR>' :
      \ exists('b:ddc_cmdline_completion') ?
      \ ddc#map#manual_complete() : nr2char(&wildcharm)
cnoremap <S-Tab> <Cmd>call pum#map#insert_relative(-1)<CR>
cnoremap <C-o>   <Cmd>call pum#map#confirm()<CR>
cnoremap <expr> <C-e>
      \ ddc#map#insert_item(0, '<Cmd>call pum#map#cancel()<CR>')

call ddc#enable()

