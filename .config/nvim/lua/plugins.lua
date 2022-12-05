return require('packer').startup({ function(use)

  -- Packer can manage itself
  use { 'wbthomason/packer.nvim', opt = true }

  -- colorscheme.
  use { 'adrian5/oceanic-next-vim', opt = true }
  use { 'sainnhe/edge', opt = true }
  use { 'RRethy/nvim-base16', opt = true }
  use { 'rhysd/vim-color-spring-night', opt = true }
  use { 'rafi/awesome-vim-colorschemes', opt = true }
  use {
    'Matsuuu/pinkmare',
    opt = true,
    setup = function() vim.cmd([[source $VIM_PATH/rc/pinkmare.vim]]) end,
  }

  -- visual.
  use {
    'lambdalisue/seethrough.vim',
    cond = not vim.fn.has('gui'),
  }

  use {
    'lukas-reineke/indent-blankline.nvim',
    config = function() vim.cmd([[source $VIM_PATH/rc/indent-blankline.nvim]]) end,
    disable = not vim.g.plugin_use_indent_blankline,
    event = { 'CursorHold', 'FocusLost' },
    wants = { 'nvim-treesitter' },
  }

  -- statusline.
  use {
    'vim-airline/vim-airline',
    setup = function() vim.cmd([[source $VIM_PATH/rc/vim-airline.vim]]) end,
    disable = not vim.g.plugin_use_airline,
    requires = { 'vim-airline/vim-airline-themes', opt = true },
    wants = { 'vim-airline-themes' },
  }
  use {
    'itchyny/lightline.vim',
    setup = function() vim.cmd([[source $VIM_PATH/rc/lightline.vim]]) end,
    disable = not vim.g.plugin_use_lightline,
  }
  use {
    'b0o/incline.nvim',
    config = function() vim.cmd([[source $VIM_PATH/rc/incline.nvim]]) end,
    disable = not vim.g.plugin_use_incline,
    event = { 'CursorHold', 'FocusLost' },
    requires = {
      { 'nvim-tree/nvim-web-devicons', opt = true },
      { 'nvim-treesitter/nvim-treesitter', opt = true },
    },
    wants = { 'nvim-web-devicons', 'nvim-treesitter' },
  }
  use {
    'nvim-lualine/lualine.nvim',
    config = function() vim.cmd([[source $VIM_PATH/rc/lualine.nvim]]) end,
    disable = not vim.g.plugin_use_lualine,
    event = { 'CursorHold', 'FocusLost' },
  }

  -- bufferline.
  use {
    'akinsho/bufferline.nvim',
    config = function() vim.cmd([[source $VIM_PATH/rc/bufferline.nvim]]) end,
    event = { 'CursorHold', 'FocusLost' },
    requires = {
      {
        'tiagovla/scope.nvim',
        config = function() vim.cmd([[source $VIM_PATH/rc/scope.nvim]]) end,
      }
    },
    wants = { 'scope.nvim' },
  }

  -- completion.
  use {
    'neoclide/coc.nvim',
    branch = 'release',
    run = 'cargo install mocword',
    setup = function() vim.cmd([[source $VIM_PATH/rc/coc.nvim]]) end,
    disable = not vim.g.plugin_use_coc,
    event = { 'BufRead', 'CursorHold', 'FocusLost' },
    cmd = { 'CocList', 'CocCommand', 'CocAction', 'CocActionAsync' },
  }
  use {
    'hrsh7th/nvim-cmp',
    config = function() vim.cmd([[source $VIM_PATH/rc/nvim-cmp.vim]]) end,
    disable = not vim.g.plugin_use_cmp,
    module = { 'cmp' },
    requires = {
      {
        'hrsh7th/cmp-nvim-lsp',
        module = { 'cmp_nvim_lsp' },
        event = { 'InsertEnter', 'CmdlineEnter', 'CmdWinEnter' },
        wants = 'nvim-lspconfig',
      },
      { 'hrsh7th/cmp-buffer', event = { 'InsertEnter', 'CmdlineEnter', 'CmdWinEnter' } },
      { 'hrsh7th/cmp-path', event = { 'InsertEnter', 'CmdlineEnter', 'CmdWinEnter' } },
      { 'hrsh7th/cmp-cmdline', event = { 'InsertEnter', 'CmdlineEnter', 'CmdWinEnter' } },
      { 'hrsh7th/cmp-vsnip', event = { 'InsertEnter', 'CmdlineEnter', 'CmdWinEnter' } },
      { 'hrsh7th/cmp-nvim-lsp-signature-help', event = { 'InsertEnter', 'CmdlineEnter', 'CmdWinEnter' } },
      { 'hrsh7th/cmp-nvim-lsp-document-symbol', event = { 'InsertEnter', 'CmdlineEnter', 'CmdWinEnter' } },
      { 'dmitmel/cmp-cmdline-history', event = { 'InsertEnter', 'CmdlineEnter', 'CmdWinEnter' } },
    },
  }

  -- lsp
  use {
    'neovim/nvim-lspconfig',
    disable = not vim.g.plugin_use_nvimlsp,
    event = { 'BufRead', 'BufNew' },
    config = function() vim.cmd([[source $VIM_PATH/rc/nvim-lspconfig.vim]]) end,
    requires = {
      {
        'lukas-reineke/lsp-format.nvim',
        module = { 'lsp-format' },
      },
      {
        'williamboman/mason.nvim',
        config = function() vim.cmd [[source $VIM_PATH/rc/mason.nvim]] end,
      },
      {
        'williamboman/mason-lspconfig.nvim',
        config = function() vim.cmd [[source $VIM_PATH/rc/mason-lspconfig.nvim]] end,
        wants = { 'mason.nvim' },
      },
    },
  }

  -- pair.
  use {
    'windwp/nvim-autopairs',
    disable = not vim.g.plugin_use_autopairs,
    event = { 'InsertEnter' },
    config = function() vim.cmd([[source $VIM_PATH/rc/nvim-autopairs.vim]]) end,
  }

  -- comment.
  use {
    'tyru/caw.vim',
    setup = function() vim.cmd([[source $VIM_PATH/rc/caw.vim]]) end,
    disable = not vim.g.plugin_use_caw,
    event = { 'BufRead', 'CursorHold', 'FocusLost' },
  }
  use {
    'uga-rosa/contextment.vim',
    setup = function() vim.cmd([[source $VIM_PATH/rc/contextment.vim]]) end,
    disable = not vim.g.plugin_use_contextment,
    event = { 'BufRead', 'CursorHold', 'FocusLost' },
    requires = { { 'Shougo/context_filetype.vim', opt = true } },
    wants = { 'context_filetype.vim' },
  }

  -- motion.
  use {
    'haya14busa/vim-edgemotion',
    setup = function() vim.cmd([[source $VIM_PATH/rc/vim-edgemotion.vim]]) end,
    disable = not vim.g.plugin_use_edgemotion,
  }


  -- utility.
  use {
    'tpope/vim-repeat',
    event = { 'BufRead', 'CursorHold', 'FocusLost' },
  }
  use {
    'thinca/vim-ambicmd',
    setup = function() vim.cmd([[source $VIM_PATH/rc/vim-ambicmd.vim]]) end,
    fn = { 'ambicmd#expand' },
  }
  use {
    'gelguy/wilder.nvim',
    config = function() vim.cmd([[source $VIM_PATH/rc/wilder.nvim]]) end,
    disable = not vim.g.plugin_use_coc,
    event = { 'CursorHold', 'FocusLost', 'CmdlineEnter', 'CmdWinEnter' },
  }
  use {
    'andymass/vim-matchup',
    event = { 'BufRead', 'BufNew' },
  }
  use {
    'lambdalisue/vim-findent',
    setup = function() vim.cmd([[source $VIM_PATH/rc/vim-findent.vim]]) end,
    cmd = 'Findent',
  }
  use {
    'Bakudankun/BackAndForward.vim',
    setup = function() vim.cmd([[source $VIM_PATH/rc/BackAndForward.vim]]) end,
    keys = { '<Plug>(backandforward-back)', '<Plug>(backandforward-forward)' },
  }
  use {
    'ntpeters/vim-better-whitespace',
    setup = function() vim.cmd([[source $VIM_PATH/rc/vim-better-whitespace.vim]]) end,
    event = { 'CursorHold', 'FocusLost' },
  }
  use {
    'monaqa/dial.nvim',
    setup = function() vim.cmd([[source $VIM_PATH/rc/dial.nvim]]) end,
    event = { 'CursorHold', 'FocusLost' },
  }
  use {
    'ahmedkhalf/project.nvim',
    config = function() vim.cmd([[source $VIM_PATH/rc/project.nvim]]) end,
    event = { 'CursorHold', 'FocusLost' },
    cond = false,
  }
  use {
    'mattn/vim-findroot',
    config = function() vim.cmd([[source $VIM_PATH/rc/vim-findroot.vim]]) end,
    event = { 'CursorHold', 'FocusLost' },
    cond = true,
  }
  use {
    'dstein64/vim-startuptime',
    cmd = 'StartupTime',
  }

  -- run.
  use {
    'thinca/vim-quickrun',
    setup = function() vim.cmd([[source $VIM_PATH/rc/vim-quickrun.vim]]) end,
    disable = not vim.g.plugin_use_quickrun,
    cmd = 'QuickRun',
    requires = {
      {
        'lambdalisue/vim-quickrun-neovim-job',
        opt = true,
      },
      {
        'statiolake/vim-quickrun-runner-nvimterm',
        config = function() vim.cmd([[source $VIM_PATH/rc/vim-quickrun-runner-nvimterm.vim]]) end,
        opt = true,
      },
    },
    wants = {
      'vim-quickrun-neovim-job',
      'vim-quickrun-runner-nvimterm',
    },
  }

  -- git.
  use {
    'lewis6991/gitsigns.nvim',
    config = function() vim.cmd([[source $VIM_PATH/rc/gitsigns.nvim]]) end,
    disable = not vim.g.plugin_use_gitsigns,
    event = { 'CursorHold', 'FocusLost' },
  }

  -- textobj.
  use { 'kana/vim-textobj-user' }
  use {
    'gilligan/textobj-lastpaste',
    event = { 'BufRead', 'CursorHold', 'FocusLost' },
    wants = { 'vim-textobj-user' },
  }
  use {
    'kana/vim-textobj-entire',
    event = { 'BufRead', 'CursorHold', 'FocusLost' },
    wants = { 'vim-textobj-user' },
  }
  use {
    'kana/vim-textobj-line',
    event = { 'BufRead', 'CursorHold', 'FocusLost' },
    wants = { 'vim-textobj-user' },
  }
  use {
    'rbtnn/vim-textobj-string',
    event = { 'BufRead', 'CursorHold', 'FocusLost' },
    wants = { 'vim-textobj-user' },
  }

  -- operator.
  use { 'kana/vim-operator-user' }
  use {
    'yuki-yano/vim-operator-replace',
    setup = function() vim.cmd([[source $VIM_PATH/rc/vim-operator-replace.vim]]) end,
    event = { 'BufRead', 'CursorHold', 'FocusLost' },
    wants = { 'vim-operator-user' },
  }
  use {
    'osyo-manga/vim-operator-stay-cursor',
    event = { 'BufRead', 'CursorHold', 'FocusLost' },
    wants = { 'vim-operator-user' },
  }
  use {
    'machakann/vim-sandwich',
    config = function() vim.cmd([[source $VIM_PATH/rc/vim-sandwich.vim]]) end,
    event = { 'BufRead', 'CursorHold', 'FocusLost' },
    wants = { 'vim-operator-user' },
  }

  -- denops.
  use {
    'vim-denops/denops.vim',
    setup = function() vim.cmd([[source $VIM_PATH/rc/denops.vim]]) end,
    event = { 'CursorHold', 'FocusLost' },
    fn = { 'denops#plugin#*' },
  }
  use {
    'vim-denops/denops-shared-server.vim',
    fn = 'denops_shared_server#install',
    wants = { 'denops.vim' },
  }
  use {
    'yukimemi/dps-hitori',
    setup = function() vim.cmd([[source $VIM_PATH/rc/dps-hitori.vim]]) end,
    wants = { 'denops.vim' },
  }
  use {
    'yukimemi/dps-autocursor',
    setup = function() vim.cmd([[source $VIM_PATH/rc/dps-autocursor.vim]]) end,
    event = { 'CursorHold', 'FocusLost' },
    wants = { 'denops.vim' },
  }
  use {
    'yukimemi/dps-randomcolorscheme',
    setup = function() vim.cmd([[source $VIM_PATH/rc/dps-randomcolorscheme.vim]]) end,
    event = { 'CursorHold', 'FocusLost' },
    wants = { 'denops.vim' },
  }
  use {
    'yukimemi/dps-autobackup',
    setup = function() vim.cmd([[source $VIM_PATH/rc/dps-autobackup.vim]]) end,
    event = { 'CursorHold', 'FocusLost', 'BufWritePre' },
    wants = { 'denops.vim' },
  }
  use {
    'yukimemi/dps-autodate',
    setup = function() vim.cmd([[source $VIM_PATH/rc/dps-autodate.vim]]) end,
    event = { 'CursorHold', 'FocusLost', 'BufWritePre' },
    wants = { 'denops.vim' },
  }
  use {
    'yukimemi/dps-asyngrep',
    setup = function() vim.cmd([[source $VIM_PATH/rc/dps-asyngrep.vim]]) end,
    wants = { 'denops.vim' },
  }
  use {
    'yukimemi/dps-walk',
    setup = function() vim.cmd([[source $VIM_PATH/rc/dps-walk.vim]]) end,
    wants = { 'denops.vim' },
  }
  use {
    'yuki-yano/dps-zero.vim',
    wants = { 'denops.vim' },
  }
  use {
    'yuki-yano/fuzzy-motion.vim',
    setup = function() vim.cmd([[source $VIM_PATH/rc/fuzzy-motion.vim]]) end,
    wants = { 'denops.vim' },
  }
  use {
    'skanehira/denops-translate.vim',
    setup = function() vim.cmd([[source $VIM_PATH/rc/denops-translate.vim]]) end,
    wants = { 'denops.vim' },
  }
  use {
    'lambdalisue/gin.vim',
    setup = function() vim.cmd([[source $VIM_PATH/rc/gin.vim]]) end,
    requires = {
      'vim-denops/denops.vim',
      { 'lambdalisue/askpass.vim', opt = true },
      { 'lambdalisue/guise.vim', opt = true },
    },
    wants = { 'denops.vim', 'askpass.vim', 'guise.vim' },
  }
  use {
    'uga-rosa/scorpeon.vim',
    disable = not vim.g.plugin_use_scorpeon,
    setup = function() vim.cmd([[source $VIM_PATH/rc/scorpeon.vim]]) end,
    requires = {
      'vim-denops/denops.vim',
      { 'microsoft/vscode', opt = true },
      { 'oovm/vscode-toml', opt = true },
      { 'emilast/vscode-logfile-highlighter', opt = true },
    },
    wants = { 'denops.vim' },
  }
  use {
    'Shougo/ddu-commands.vim',
    disable = not vim.g.plugin_use_ddu,
    setup = function() vim.cmd([[source $VIM_PATH/rc/ddu-commands.vim]]) end,
    cmd = 'Ddu',
    wants = {'ddu.vim', 'denops.vim'},
  }
  use {
    'Shougo/ddu.vim',
    disable = not vim.g.plugin_use_ddu,
    config = function() vim.cmd([[source $VIM_PATH/rc/ddu.vim]]) end,
    opt = true,
    requires = {
      'vim-denops/denops.vim',
      { '4513ECHO/ddu-source-colorscheme', opt = true},
      { '4513ECHO/ddu-source-source', opt = true},
      { '4513ECHO/vim-readme-viewer', opt = true},
      { 'Shougo/ddu-column-filename', opt = true},
      { 'Shougo/ddu-filter-matcher_hidden', opt = true},
      { 'Shougo/ddu-filter-matcher_relative', opt = true},
      { 'Shougo/ddu-filter-matcher_substring', opt = true},
      { 'Shougo/ddu-kind-file', opt = true},
      { 'Shougo/ddu-kind-word', opt = true},
      { 'Shougo/ddu-source-action', opt = true},
      { 'Shougo/ddu-source-file', opt = true},
      { 'Shougo/ddu-source-file_old', opt = true},
      { 'Shougo/ddu-source-file_point', opt = true},
      { 'Shougo/ddu-source-file_rec', opt = true},
      { 'Shougo/ddu-source-line', opt = true},
      { 'Shougo/ddu-source-register', opt = true},
      { 'Shougo/ddu-ui-ff', opt = true},
      { 'kuuote/ddu-source-mr', opt = true},
      { 'liquidz/ddu-source-custom-list', opt = true},
      { 'matsui54/ddu-source-command_history', opt = true},
      { 'matsui54/ddu-source-file_external', opt = true},
      { 'matsui54/ddu-source-help', opt = true},
      { 'shun/ddu-source-buffer', opt = true},
      { 'shun/ddu-source-rg', opt = true},
      { 'yuki-yano/ddu-filter-fzf', opt = true},
      {
        'Shougo/ddu-ui-filer',
        config = function() vim.cmd([[source $VIM_PATH/rc/ddu-ui-filer.vim]]) end,
        opt = true
      },
    },
    wants = {
      'denops.vim',
      'ddu-source-colorscheme',
      'ddu-source-source',
      'vim-readme-viewer',
      'ddu-column-filename',
      'ddu-filter-matcher_hidden',
      'ddu-filter-matcher_relative',
      'ddu-filter-matcher_substring',
      'ddu-kind-file',
      'ddu-kind-word',
      'ddu-source-action',
      'ddu-source-file',
      'ddu-source-file_old',
      'ddu-source-file_point',
      'ddu-source-file_rec',
      'ddu-source-line',
      'ddu-source-register',
      'ddu-ui-ff',
      'ddu-source-mr',
      'ddu-source-custom-list',
      'ddu-source-command_history',
      'ddu-source-file_external',
      'ddu-source-help',
      'ddu-source-buffer',
      'ddu-source-rg',
      'ddu-filter-fzf',
    },
  }

  -- treesitter.
  use {
    'nvim-treesitter/nvim-treesitter',
    config = function() vim.cmd([[source $VIM_PATH/rc/nvim-treesitter.vim]]) end,
    module = { 'nvim-treesitter' },
    event = { 'CursorHold', 'FocusLost' },
    requires = {
      { 'p00f/nvim-ts-rainbow', opt = true },
      { 'windwp/nvim-ts-autotag', opt = true },
    },
    run = ':TSUpdate',
  }

end,
  config = {
    display = {
      open_fn = function()
        return require('packer.util').float({ border = 'single' })
      end
    }
  } })
