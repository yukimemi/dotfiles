vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup({ function(use)
  use 'wbthomason/packer.nvim'

  -- colorscheme.
  use { 'adrian5/oceanic-next-vim', opt = true }
  use { 'sainnhe/edge', opt = true }
  use { 'RRethy/nvim-base16', opt = true }
  use { 'rhysd/vim-color-spring-night', opt = true }
  use { 'Matsuuu/pinkmare', opt = true, setup = vim.cmd [[source $VIM_PATH/rc/pinkmare.vim]] }
  use { 'rafi/awesome-vim-colorschemes', opt = true }

  -- visual.
  use { 'lambdalisue/seethrough.vim', cond = not vim.fn.has('gui') }

  use {
    'lukas-reineke/indent-blankline.nvim',
    config = 'vim.cmd [[source $VIM_PATH/rc/indent-blankline.nvim]]',
    disable = not vim.g.plugin_use_indent_blankline,
    event = { 'CursorHold', 'FocusLost' },
    requires = 'nvim-treesitter/nvim-treesitter',
  }

  -- statusline.
  use {
    'vim-airline/vim-airline',
    requires = { 'vim-airline/vim-airline-themes' },
    setup = vim.cmd [[source $VIM_PATH/rc/vim-airline.vim]],
    disable = not vim.g.plugin_use_airline,
  }
  use {
    'itchyny/lightline.vim',
    setup = vim.cmd [[source $VIM_PATH/rc/lightline.vim]],
    disable = not vim.g.plugin_use_lightline,
  }
  use {
    'b0o/incline.nvim',
    config = 'vim.cmd [[source $VIM_PATH/rc/incline.nvim]]',
    disable = not vim.g.plugin_use_incline,
    event = { 'CursorHold', 'FocusLost' },
    requires = {
      'nvim-tree/nvim-web-devicons',
      'nvim-treesitter/nvim-treesitter',
    },
  }
  use {
    'nvim-lualine/lualine.nvim',
    config = 'vim.cmd [[source $VIM_PATH/rc/lualine.nvim]]',
    disable = not vim.g.plugin_use_lualine,
    event = { 'CursorHold', 'FocusLost' },
  }

  -- bufferline.
  use {
    'akinsho/bufferline.nvim',
    config = 'vim.cmd [[source $VIM_PATH/rc/bufferline.nvim]]',
    event = { 'CursorHold', 'FocusLost' },
    require = {
      'tiagovla/scope.nvim',
      config = 'vim.cmd [[source $VIM_PATH/rc/scope.nvim]]',
      event = { 'CursorHold', 'FocusLost' },
    },
  }

  -- completion.
  use {
    'neoclide/coc.nvim',
    branch = 'release',
    run = 'cargo install mocword',
    setup = vim.cmd [[source $VIM_PATH/rc/coc.nvim]],
    disable = not vim.g.plugin_use_coc,
  }

  -- comment.
  use {
    'tyru/caw.vim',
    setup = vim.cmd [[source $VIM_PATH/rc/caw.vim]],
    disable = not vim.g.plugin_use_caw,
  }

  -- motion.
  use {
    'haya14busa/vim-edgemotion',
    setup = vim.cmd [[source $VIM_PATH/rc/vim-edgemotion.vim]],
    disable = not vim.g.plugin_use_edgemotion,
  }


  -- utility.
  use {
    'thinca/vim-ambicmd',
    setup = vim.cmd [[source $VIM_PATH/rc/vim-ambicmd.vim]],
  }
  use {
    'gelguy/wilder.nvim',
    setup = vim.cmd [[source $VIM_PATH/rc/wilder.nvim]],
    disable = not vim.g.plugin_use_coc,
  }
  use { 'andymass/vim-matchup', event = 'BufRead *' }
  use {
    'lambdalisue/vim-findent',
    setup = vim.cmd [[source $VIM_PATH/rc/vim-findent.vim]],
    cmd = 'Findent',
  }
  use {
    'Bakudankun/BackAndForward.vim',
    setup = vim.cmd [[source $VIM_PATH/rc/BackAndForward.vim]],
    event = { 'CursorHold', 'FocusLost' },
  }
  use {
    'ntpeters/vim-better-whitespace',
    setup = vim.cmd [[source $VIM_PATH/rc/vim-better-whitespace.vim]],
    event = { 'CursorHold', 'FocusLost' },
  }
  use {
    'monaqa/dial.nvim',
    setup = vim.cmd [[source $VIM_PATH/rc/dial.nvim]],
    event = { 'CursorHold', 'FocusLost' },
  }
  use {
    'ahmedkhalf/project.nvim',
    config = 'vim.cmd [[source $VIM_PATH/rc/project.nvim]]',
    event = { 'CursorHold', 'FocusLost' },
  }
  use {
    'tweekmonster/startuptime.vim',
    cmd = 'StartupTime',
  }

  -- git.
  use {
    'lewis6991/gitsigns.nvim',
    config = 'vim.cmd [[source $VIM_PATH/rc/gitsigns.nvim]]',
    disable = not vim.g.plugin_use_gitsigns,
    event = { 'CursorHold', 'FocusLost' },
  }

  -- textobj.
  use { 'kana/vim-textobj-user' }
  use {
    'gilligan/textobj-lastpaste',
    requires = 'kana/vim-textobj-user',
    event = { 'BufRead', 'CursorHold', 'FocusLost' },
  }
  use {
    'kana/vim-textobj-entire',
    requires = 'kana/vim-textobj-user',
    event = { 'BufRead', 'CursorHold', 'FocusLost' },
  }
  use {
    'kana/vim-textobj-line',
    requires = 'kana/vim-textobj-user',
    event = { 'BufRead', 'CursorHold', 'FocusLost' },
  }
  use {
    'rbtnn/vim-textobj-string',
    requires = 'kana/vim-textobj-user',
    event = { 'BufRead', 'CursorHold', 'FocusLost' },
  }

  -- operator.
  use { 'kana/vim-operator-user' }
  use {
    'yuki-yano/vim-operator-replace',
    requires = 'kana/vim-operator-user',
    setup = vim.cmd [[source $VIM_PATH/rc/vim-operator-replace.vim]],
    event = { 'BufRead', 'CursorHold', 'FocusLost' },
  }

  -- denops.
  use {
    'vim-denops/denops.vim',
    setup = vim.cmd [[source $VIM_PATH/rc/denops.vim]],
    event = { 'CursorHold', 'FocusLost' },
  }
  use {
    'vim-denops/denops-shared-server.vim',
    fn = 'denops_shared_server#install',
    requires = 'vim-denops/denops.vim',
  }
  use {
    'yukimemi/dps-hitori',
    setup = vim.cmd [[source $VIM_PATH/rc/dps-hitori.vim]],
    requires = 'vim-denops/denops.vim',
  }
  use {
    'yukimemi/dps-autocursor',
    setup = vim.cmd [[source $VIM_PATH/rc/dps-autocursor.vim]],
    event = { 'CursorHold', 'FocusLost' },
    requires = 'vim-denops/denops.vim',
  }
  use {
    'yukimemi/dps-randomcolorscheme',
    setup = vim.cmd [[source $VIM_PATH/rc/dps-randomcolorscheme.vim]],
    event = { 'CursorHold', 'FocusLost' },
    requires = 'vim-denops/denops.vim',
  }
  use {
    'yukimemi/dps-autobackup',
    setup = vim.cmd [[source $VIM_PATH/rc/dps-autobackup.vim]],
    event = { 'CursorHold', 'FocusLost', 'BufWritePre' },
    requires = 'vim-denops/denops.vim',
  }
  use {
    'yukimemi/dps-autodate',
    setup = vim.cmd [[source $VIM_PATH/rc/dps-autodate.vim]],
    event = { 'CursorHold', 'FocusLost', 'BufWritePre' },
    requires = 'vim-denops/denops.vim',
  }
  use {
    'yukimemi/dps-asyngrep',
    setup = vim.cmd [[source $VIM_PATH/rc/dps-asyngrep.vim]],
    requires = 'vim-denops/denops.vim',
  }
  use {
    'yukimemi/dps-walk',
    setup = vim.cmd [[source $VIM_PATH/rc/dps-walk.vim]],
    requires = 'vim-denops/denops.vim',
  }
  use {
    'yuki-yano/dps-zero.vim',
    requires = 'vim-denops/denops.vim',
  }
  use {
    'yuki-yano/fuzzy-motion.vim',
    setup = vim.cmd [[source $VIM_PATH/rc/fuzzy-motion.vim]],
    requires = 'vim-denops/denops.vim',
  }
  use {
    'skanehira/denops-translate.vim',
    setup = vim.cmd [[source $VIM_PATH/rc/denops-translate.vim]],
    requires = 'vim-denops/denops.vim',
  }
  use {
    'lambdalisue/gin.vim',
    setup = vim.cmd [[source $VIM_PATH/rc/gin.vim]],
    requires = {
      'vim-denops/denops.vim',
      { 'lambdalisue/askpass.vim', opt = true },
      { 'lambdalisue/guise.vim', opt = true },
    },
  }

  -- treesitter.
  use {
    'nvim-treesitter/nvim-treesitter',
    config = 'vim.cmd [[source $VIM_PATH/rc/nvim-treesitter.vim]]',
    requires = {
      { 'p00f/nvim-ts-rainbow', opt = true },
      { 'windwp/nvim-ts-autotag', opt = true },
    },
    event = { 'CursorHold', 'FocusLost' },
    run = ':TSUpdate',
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end,
  config = {
    display = {
      open_fn = function()
        return require('packer.util').float({ border = 'single' })
      end
    }
  } })
