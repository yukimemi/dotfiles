return {
  "Shougo/ddc.vim",

  enabled = vim.g.plugin_use_ddc,

  lazy = false,

  dependencies = {
    "vim-denops/denops.vim",

    -- matcher, sorter, converter
    "tani/ddc-fuzzy",

    -- ui
    {
      "Shougo/pum.vim",
      config = function()
        vim.fn["pum#set_option"]("use_complete", false)
        -- vim.fn["pum#set_option"]("max_width", 100)
        vim.fn["pum#set_option"]("max_height", 30)
        -- vim.fn["pum#set_option"]("border", "single")
        vim.fn["pum#set_option"]("padding", false)
      end,
    },
    "Shougo/ddc-ui-pum",
    "Shougo/ddc-ui-inline",

    -- snippet
    "hrsh7th/vim-vsnip",

    -- sources
    "LumaKernel/ddc-file",
    "LumaKernel/ddc-run",
    "Shougo/ddc-source-around",
    "matsui54/ddc-buffer",
    "Shougo/ddc-source-omni",
    "Shougo/ddc-source-cmdline",
    "Shougo/ddc-source-input",
    "Shougo/ddc-source-cmdline-history",
    "Shougo/ddc-source-line",
    {
      "Milly/windows-clipboard-history.vim",
      enabled = jit.os:find("Windows"),
    },
    {
      "Shougo/ddc-source-mocword",
      build = "cargo install mocword",
    },
    {
      "Shougo/ddc-source-rg",
      enabled = vim.fn.executable("rg") > 0,
    },
    {
      "Shougo/ddc-source-nvim-lsp",
      dependencies = {
        "neovim/nvim-lspconfig",
      },
    },
    {
      "delphinus/ddc-treesitter",
      dependencies = {
        "nvim-treesitter/nvim-treesitter",
      },
    },
    {
      "hokorobi/ddc-source-plantuml",
      init = function()
        vim.g.ddc_source_plantuml_cmd = vim.fn.expand("~/.local/bin/plantuml.jar")
      end,
    },

    -- popup, signature
    {
      "matsui54/denops-popup-preview.vim",
      init = function()
        vim.g.popup_preview_config = {
          delay = 50,
          border = true,
          supportVsnip = true,
        }
      end,
      config = function()
        vim.fn["popup_preview#enable"]()
      end,
    },
    {
      "matsui54/denops-signature_help",
      enabled = false,
      config = function()
        vim.fn["signature_help#enable"]()
      end,
    },
  },

  init = function()
    vim.cmd([[
      function! CommandlinePre(mode) abort
        " NOTE: It disables default command line completion!
        set wildchar=<C-t>
        set wildcharm=<C-t>

        cnoremap <expr><buffer> <Tab>
          \ pum#visible() ?
          \  '<Cmd>call pum#map#insert_relative(+1)<CR>' :
          \ exists('b:ddc_cmdline_completion') ?
          \   ddc#map#manual_complete() : "\<C-t>"

        " Overwrite sources
        if !exists('b:prev_buffer_config')
          let b:prev_buffer_config = ddc#custom#get_buffer()
        endif
        if a:mode ==# ':'
          call ddc#custom#patch_buffer('keywordPattern', '[0-9a-zA-Z_:#-]*')
        endif

        autocmd MyAutoCmd User DDCCmdlineLeave ++once call CommandlinePost()
        autocmd MyAutoCmd InsertEnter <buffer> ++once call CommandlinePost()

        call ddc#enable_cmdline_completion()
      endfunction

      function! CommandlinePost() abort
        silent! cunmap <buffer> <Tab>

        " Restore sources
        if exists('b:prev_buffer_config')
          call ddc#custom#set_buffer(b:prev_buffer_config)
          unlet b:prev_buffer_config
        else
          call ddc#custom#set_buffer({})
        endif

        set wildcharm=<Tab>
      endfunction
    ]])
    vim.keymap.set("n", ":", "<Cmd>call CommandlinePre(':')<CR>:")
    vim.keymap.set("n", "/", "<Cmd>call CommandlinePre('/')<CR>/")
    vim.keymap.set("n", "?", "<Cmd>call CommandlinePre('/')<CR>?")

    vim.api.nvim_create_autocmd("User", {
      group = "MyAutoCmd",
      pattern = "DenopsPluginPost:ddc",
      callback = function()
        vim.notify("ddc loaded !")
      end,
    })
  end,

  config = function()
    vim.cmd([[
      if has('win32')
        call ddc#custom#patch_global('sources',
            \ ['nvim-lsp', 'around', 'vsnip', 'file', 'rg', 'mocword', 'windows-clipboard-history'],
            \ )
      else
        call ddc#custom#patch_global('sources',
            \ ['nvim-lsp', 'around', 'vsnip', 'file', 'rg', 'mocword'],
            \ )
      endif
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
          \     sorters: ['matcher_fuzzy'],
          \     converters: ['matcher_fuzzy'],
          \   },
          \   around: #{ mark: 'around' },
          \   buffer: #{ mark: 'buf' },
          \   plantuml: #{ mark: 'uml' },
          \   cmdline: #{
          \     mark: 'cmd',
          \     forceCompletionPattern: '\S/\S*|\.\w*',
          \     dup: 'force',
          \   },
          \   input: #{
          \     mark: 'input',
          \     forceCompletionPattern: '\S/\S*',
          \     isVolatile: v:true,
          \     dup: 'force',
          \   },
          \   line: #{ mark: 'line' },
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
          \   file: #{
          \     mark: 'file',
          \     isVolatile: v:true,
          \     minAutoCompleteLength: 3,
          \     forceCompletionPattern: '\S/\S*',
          \   },
          \   cmdline-history: #{
          \     mark: 'history',
          \     sorters: [],
          \   },
          \   rg: #{
          \     mark: 'rg',
          \     minAutoCompleteLength: 3,
          \     enabledIf: "finddir('.git', ';') != ''",
          \   },
          \   windows-clipboard-history: #{
          \     mark: 'clip',
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
          \   windows-clipboard-history: #{
          \     maxAbbrWidth: 100,
          \   },
          \ })

      call ddc#custom#patch_filetype(['plantuml'], #{
          \   sources: ['plantuml', 'nvim-lsp', 'around', 'vsnip', 'file', 'rg', 'mocword'],
          \ })

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
      " inoremap <expr> <TAB>
      "       \ pum#visible() ? '<Cmd>call pum#map#insert_relative(+1)<CR>' :
      "       \ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
      "       \ '<TAB>' : ddc#map#manual_complete()
      " inoremap <S-Tab> <Cmd>call pum#map#insert_relative(-1)<CR>
      inoremap <C-n>   <Cmd>call pum#map#insert_relative(+1)<CR>
      inoremap <C-p>   <Cmd>call pum#map#insert_relative(-1)<CR>
      inoremap <C-o>   <Cmd>call pum#map#confirm()<CR>
      inoremap <expr> <C-k>   ddc#map#extend(pum#map#confirm())
      inoremap <C-x><C-f> <Cmd>call ddc#map#manual_complete(#{ sources: ['file'] })<CR>
      inoremap <expr> l
            \ pum#entered() ?
            \ '<Cmd>call pum#map#insert_relative(+1)<CR>' : 'l'
      inoremap <expr> h
            \ pum#entered() ?
            \ '<Cmd>call pum#map#insert_relative(-1)<CR>' : 'h'
      inoremap <expr> <C-c>
            \ ddc#map#insert_item(0, '<Cmd>call pum#map#cancel()<CR>')

      " For command line mode completion
      cnoremap <expr> <Tab>
      \ pum#visible() ? '<Cmd>call pum#map#insert_relative(+1)<CR>' :
      \ exists('b:ddc_cmdline_completion') ?
      \ ddc#map#manual_complete() : nr2char(&wildcharm)
      cnoremap <S-Tab> <Cmd>call pum#map#insert_relative(-1)<CR>
      cnoremap <C-o>   <Cmd>call pum#map#confirm()<CR>
      cnoremap <expr> <C-c>
            \ ddc#map#insert_item(0, '<Cmd>call pum#map#cancel()<CR>')

      call ddc#enable()
    ]])
  end,
}
