-- =============================================================================
-- File        : nvim-deck.lua
-- Author      : yukimemi
-- Last Change : 2025/06/01 20:51:23.
-- =============================================================================

local deck = require('deck')
vim.ui.select = deck.ui_select

-- Apply pre-defined easy settings.
-- For manual configuration, refer to the code in `deck/easy.lua`.
require('deck.easy').setup()

-- Set up buffer-specific key mappings for nvim-deck.
vim.api.nvim_create_autocmd('User', {
  pattern = 'DeckStart',
  callback = function(e)
    local ctx = e.data.ctx --[[@as deck.Context]]

    -- normal-mode mapping.
    ctx.keymap('n', '<Esc>', function()
      vim.cmd('quit')
    end)
    ctx.keymap('n', '<Tab>', deck.action_mapping('choose_action'))
    ctx.keymap('n', '<C-l>', deck.action_mapping('refresh'))
    ctx.keymap('n', 'i', deck.action_mapping('prompt'))
    ctx.keymap('n', 'a', deck.action_mapping('prompt'))
    ctx.keymap('n', '@', deck.action_mapping('toggle_select'))
    ctx.keymap('n', '*', deck.action_mapping('toggle_select_all'))
    ctx.keymap('n', 'p', deck.action_mapping('toggle_preview_mode'))
    ctx.keymap('n', 'd', deck.action_mapping('delete'))
    ctx.keymap('n', '<CR>', deck.action_mapping('default'))
    ctx.keymap('n', 'o', deck.action_mapping('open'))
    ctx.keymap('n', 'O', deck.action_mapping('open_keep'))
    ctx.keymap('n', 's', deck.action_mapping('open_split'))
    ctx.keymap('n', 'v', deck.action_mapping('open_vsplit'))
    ctx.keymap('n', 'c', deck.action_mapping('create'))
    ctx.keymap('n', 'w', deck.action_mapping('write'))
    ctx.keymap('n', '<C-u>', deck.action_mapping('scroll_preview_up'))
    ctx.keymap('n', '<C-d>', deck.action_mapping('scroll_preview_down'))

    -- cmdline-mode mapping.
    ctx.keymap('c', '<CR>', function()
      vim.api.nvim_feedkeys(vim.keycode('<Esc>'), 'n', true)
      vim.schedule(function()
        ctx.do_action('default')
      end)
    end)
    ctx.keymap('c', '<C-j>', function()
      ctx.set_cursor(ctx.get_cursor() + 1)
    end)
    ctx.keymap('c', '<C-k>', function()
      ctx.set_cursor(ctx.get_cursor() - 1)
    end)

    ctx.set_preview_mode(true)
    ctx.prompt()

    vim.opt.cursorline = true
  end
})

--key-mapping for explorer source (requires `require('deck.easy').setup()`).
vim.api.nvim_create_autocmd('User', {
  pattern = 'DeckStart:explorer',
  callback = function(e)
    local ctx = e.data.ctx --[[@as deck.Context]]
    ctx.keymap('n', 'h', deck.action_mapping('explorer.collapse'))
    ctx.keymap('n', 'l', deck.action_mapping('explorer.expand'))
    ctx.keymap('n', '.', deck.action_mapping('explorer.toggle_dotfiles'))
    ctx.keymap('n', 'c', deck.action_mapping('explorer.clipboard.save_copy'))
    ctx.keymap('n', 'm', deck.action_mapping('explorer.clipboard.save_move'))
    ctx.keymap('n', 'p', deck.action_mapping('explorer.clipboard.paste'))
    ctx.keymap('n', 'x', deck.action_mapping('explorer.clipboard.paste'))
    ctx.keymap('n', '<Leader>ff', deck.action_mapping('explorer.dirs'))
    ctx.keymap('n', 'P', deck.action_mapping('toggle_preview_mode'))
    ctx.keymap('n', '~', function()
      ctx.do_action('explorer.get_api').set_cwd(vim.fs.normalize('~'))
    end)
    ctx.keymap('n', '\\', function()
      ctx.do_action('explorer.get_api').set_cwd(vim.fs.normalize('/'))
    end)
  end
})

deck.register_start_preset('git_files', function()
  local result = vim.system({ 'git', 'rev-parse', '--show-toplevel' }, { cwd = vim.fn.getcwd(), text = true }):wait()
  deck.start(require('deck.builtin.source.files')({
    root_dir = string.gsub(result.stdout, "%s+$", "") or vim.fn.getcwd(),
    ignore_globs = { '**/node_modules/', '**/.git/' },
  }))
end)

-- Example key bindings for launching nvim-deck sources. (These mapping required `deck.easy` calls.)
vim.keymap.set('n', '<space>ff', '<Cmd>Deck files<CR>', { desc = 'Show recent files, buffers, and more' })
vim.keymap.set('n', '<space>gr', '<Cmd>Deck grep<CR>', { desc = 'Start grep search' })
vim.keymap.set('n', '<space>gi', '<Cmd>Deck git<CR>', { desc = 'Open git launcher' })
vim.keymap.set('n', '<space>he', '<Cmd>Deck helpgrep<CR>', { desc = 'Live grep all help tags' })
vim.keymap.set('n', '<space>,', '<Cmd>Deck buffers<CR>', { desc = 'Deck buffers' })
vim.keymap.set('n', 'ge', '<Cmd>Deck explorer<CR>', { desc = 'Deck explorer' })

vim.keymap.set('n', 'mg', '<Cmd>Deck git_files<CR>', { desc = 'Git files' })

vim.keymap.set("n", "mb", function()
  local bufname = vim.fn.bufname()
  local bufdir = vim.fn.fnamemodify(bufname, ":p:h")
  deck.start(require('deck.builtin.source.files')({
    root_dir = bufdir,
    ignore_globs = { '**/node_modules/', '**/.git/' },
  }))
end, { desc = "files on buffer dir" })

vim.keymap.set("n", "gE", function()
  local bufname = vim.fn.bufname()
  local bufdir = vim.fn.fnamemodify(bufname, ":p:h")
  deck.start(require('deck.builtin.source.explorer')({
    cwd = bufdir,
    mode = "drawer",
  }))
end, { desc = "Explorer on buffer dir" })

vim.keymap.set('n', 'md', function()
  deck.start(require('deck.builtin.source.files')({
    root_dir = vim.fn.expand('~/.dotfiles'),
    ignore_globs = { '**/node_modules/', '**/.git/' },
  }))
end, { desc = 'dotfiles' })
vim.keymap.set('n', 'ms', function()
  deck.start(require('deck.builtin.source.files')({
    root_dir = vim.fn.expand('~/src'),
    ignore_globs = { '**/node_modules/', '**/.git/' },
    matcher = require("deck.builtin.matcher").fuzzy,
  }))
end, { desc = 'src files' })
vim.keymap.set('n', 'mC', function()
  deck.start(require('deck.builtin.source.files')({
    root_dir = vim.fn.expand('~/.cache'),
    ignore_globs = { '**/node_modules/', '**/.git/' },
    matcher = require("deck.builtin.matcher").fuzzy,
  }))
end, { desc = 'cache files' })
vim.keymap.set('n', 'mM', function()
  deck.start(require('deck.builtin.source.files')({
    root_dir = vim.fn.expand('~/.memolist'),
    ignore_globs = { '**/node_modules/', '**/.git/' },
  }))
end, { desc = 'memolit files' })

-- Show the latest deck context.
vim.keymap.set('n', '<space>;', function()
  local ctx = require('deck').get_history()[1]
  if ctx then
    ctx.show()
  end
end)

-- Do default action on next item.
vim.keymap.set('n', '<space>n', function()
  local ctx = require('deck').get_history()[1]
  if ctx then
    ctx.set_cursor(ctx.get_cursor() + 1)
    ctx.do_action('default')
  end
end)
