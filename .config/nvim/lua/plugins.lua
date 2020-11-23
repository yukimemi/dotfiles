local packer_dir = ''
if vim.g.is_windows then
  packer_dir = vim.env.HOME .. '/AppData/Local/nvim-data/site/pack/packer/opt/packer.nvim'
else
  packer_dir = '~/.local/share/nvim/site/pack/packer/opt/packer.nvim'
end

if vim.fn.isdirectory(packer_dir) == 0 then
  os.execute("git clone https://github.com/wbthomason/packer.nvim " .. packer_dir)
end

-- Only required if you have packer in your `opt` pack
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  -- Packer can manage itself as an optional plugin.
  use {'wbthomason/packer.nvim', opt = true}

  -- colorscheme.
  use {'adrian5/oceanic-next-vim', opt = true}

  -- visual.
  use {'lambdalisue/seethrough.vim', cond = not vim.fn.has('gui')}

  -- statusline.
  use {
    'vim-airline/vim-airline',
    requires = {'vim-airline/vim-airline-themes'},
    setup = vim.cmd [[source $VIM_PATH/rc/vim-airline.vim]],
    disable = not vim.g.plugin_use_airline,
  }
  use {
    'itchyny/lightline.vim',
    setup = vim.cmd [[source $VIM_PATH/rc/lightline.vim]],
    disable = not vim.g.plugin_use_lightline,
  }

  -- completion.
  use {
    'neoclide/coc.nvim',
    branch = 'release',
    run = 'go get -u github.com/high-moctane/nextword',
    setup = vim.cmd [[source $VIM_PATH/rc/coc.nvim]],
    disable = not vim.g.plugin_use_coc,
  }

  -- utility.
  use {
    'gelguy/wilder.nvim',
    setup = vim.cmd [[source $VIM_PATH/rc/wilder.nvim]],
  }

  use {'andymass/vim-matchup', event = 'VimEnter *'}

  -- markdown.
  use {'iamcco/markdown-preview.nvim', run = 'cd app && yarn install', cmd = 'MarkdownPreview'}

  -- all filetype
  use {'nvim-treesitter/nvim-treesitter', opt = true}

end)
