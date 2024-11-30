-- =============================================================================
-- File        : nvim-deck.lua
-- Author      : yukimemi
-- Last Change : 2024/11/26 22:19:58.
-- =============================================================================

local deck = require('deck')

-- Add recent files.
vim.api.nvim_create_autocmd('BufEnter', {
  callback = function(e)
    local bufname = vim.api.nvim_buf_get_name(0)
    if vim.fn.filereadable(bufname) == 1 then
      require('deck.builtin.source.recent_files').add(vim.fs.normalize(bufname))
    end
  end
})

-- Add recent dirs.
vim.api.nvim_create_autocmd('DirChanged', {
  callback = function(e)
    require('deck.builtin.source.recent_dirs').add(e.cwd)
  end
})

-- Example `open` action for file-kind.
deck.register_action({
  name = 'open',
  resolve = function(ctx)
    local item = ctx.get_cursor_item()
    return item and item.filename
  end,
  execute = function(item)
    vim.cmd('edit ' .. item.filename)
  end,
})

-- Register built-ins.
for _, action in pairs(require('deck.builtin.action')) do
  deck.register_action(action)
end
for _, previewer in pairs(require('deck.builtin.previewer')) do
  deck.register_previewer(previewer)
end
for _, decorator in pairs(require('deck.builtin.decorator')) do
  deck.register_decorator(decorator)
end

-- Example setup keymaps.
require('deck').setup({
  default_start_config = {
    mapping = {
      ['<Tab>'] = 'choose_action',
      ['<C-l>'] = 'refresh',
      ['i'] = 'prompt',
      ['a'] = 'prompt',
      ['<space>'] = 'toggle_select',
      ['*'] = 'toggle_select_all',
      ['p'] = 'toggle_preview_mode',
      ['<C-k>'] = 'scroll_preview_up',
      ['<C-j>'] = 'scroll_preview_down',
      ['<CR>'] = { 'default', 'open' },
    }
  }
})

-- Example keymap for listing files recursively.
vim.keymap.set('n', '<space>df', function()
  deck.start({
    -- require('deck.builtin.source.recent_files')(),
    require('deck.builtin.source.buffers')(),
    require('deck.builtin.source.files')({
      root_dir = vim.fn.getcwd(),
    })
  })
end)

-- Open recent deck window.
vim.keymap.set('n', '<space>;', function()
  local context = deck.get_history()[1]
  if context then
    context.show()
  end
end)

-- Do default action on next item of recent deck context.
vim.keymap.set('n', '<C-n>', function()
  local context = deck.get_history()[1]
  if context then
    context.set_cursor(context.get_cursor() + 1)
    context.do_action('default')
  end
end)

-- Do default action on prev item of recent deck context.
vim.keymap.set('n', '<C-p>', function()
  local context = deck.get_history()[1]
  if context then
    context.set_cursor(context.get_cursor() - 1)
    context.do_action('default')
  end
end)
