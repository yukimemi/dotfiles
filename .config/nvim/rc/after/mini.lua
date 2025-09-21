-- =============================================================================
-- File        : mini.lua
-- Author      : yukimemi
-- Last Change : 2025/09/21 15:09:49.
-- =============================================================================

require("mini.align").setup()
require("mini.animate").setup()
require("mini.cursorword").setup()
require("mini.hipatterns").setup()
require("mini.icons").setup()
require("mini.map").setup()
require("mini.notify").setup()
require("mini.tabline").setup()
require("mini.trailspace").setup()
require("mini.visits").setup()

-- mini.basic
require('mini.basics').setup({
  options = {
    basic = true,
    extra_ui = true,
    win_borders = 'single',
  },
  mappings = {
    basic = true,
    option_toggle_prefix = [[\]],
    windows = true,
    move_with_alt = true,
  },
  autocommands = {
    basic = true,
    relnum_in_visual_mode = true,
    silent = false,
  },
})

-- mini.comment
require("mini.comment").setup({
  options = {
    ignore_blank_line = false
  },
  mappings = {
    comment_visual = "gcc"
  }
})

-- mini.files
require("mini.files").setup()
vim.keymap.set("n", "ge", MiniFiles.open, { desc = "MiniFiles" })
vim.keymap.set("n", "gE", function()
  MiniFiles.open(vim.api.nvim_buf_get_name(0))
end, { desc = "MiniFiles current buffer dir" })

-- mini.pick
require("mini.pick").setup()
vim.keymap.set("n", "<space>pp", "<cmd>Pick files<cr>", { desc = "MiniPick files" })
vim.keymap.set("n", "<space>,", "<cmd>Pick buffers<cr>", { desc = "MiniPick buffers" })
vim.keymap.set("n", "mg", function()
  MiniPick.builtin.files({
    tool = "git",
  })
end, { desc = "MiniPick git" })
-- dotfiles
vim.keymap.set("n", "md", function()
  MiniPick.builtin.files({
    tool = "git",
  }, {
    source = {
      cwd = "~/.dotfiles"
    }
  })
end, { desc = "MiniPick dotfiles" })
-- src
vim.keymap.set("n", "ms", function()
  MiniPick.builtin.files({}, {
    source = {
      cwd = "~/src"
    }
  })
end)
-- memolist
vim.keymap.set("n", "mM", function()
  MiniPick.builtin.files({}, {
    source = {
      cwd = "~/.memolist"
    }
  })
end)
-- cache
vim.keymap.set("n", "mC", function()
  MiniPick.builtin.files({}, {
    source = {
      cwd = "~/.cache"
    }
  })
end)
-- chronicle
vim.keymap.set("n", "mr", function()
  MiniPick.start({
    source = {
      items = vim.fn.readfile(vim.g.chronicle_read_path)
    }
  })
end)
vim.keymap.set("n", "mw", function()
  MiniPick.start({
    source = {
      items = vim.fn.readfile(vim.g.chronicle_write_path)
    }
  })
end)

-- help
vim.keymap.set("n", "<space>ph", function()
  MiniPick.builtin.help()
end, { desc = "MiniPick help" })

-- mini.extra
require("mini.extra").setup()

-- vim.keymap.set("n", "ge", function()
--   MiniExtra.pickers.explorer()
-- end, { desc = "MiniExtra explorer" })

-- mini.diff
-- require("mini.diff").setup({
--   mappings = {
--     apply = 'Gh',
--     reset = 'GH',
--   }
-- })

-- mini.indentscope
require("mini.indentscope").setup()

-- mini.misc
require("mini.misc").setup({
  make_global = {
    "setup_auto_root",
    "setup_restore_cursor",
  }
})

-- mini.snippets
local gen_loader = require('mini.snippets').gen_loader
require('mini.snippets').setup({
  snippets = {
    -- Load custom file with global snippets first (order matters)
    gen_loader.from_file('~/.config/nvim/snippets/global.json'),

    -- Or add them here explicitly
    { prefix = 'cdate', body = '$CURRENT_YEAR-$CURRENT_MONTH-$CURRENT_DATE' },

    -- Load snippets based on current language by reading files from
    -- "snippets/" subdirectories from 'runtimepath' directories.
    gen_loader.from_lang(),

    -- Load project-local snippets with `gen_loader.from_file()`
    -- and relative path (file doesn't have to be present)
    gen_loader.from_file('.vscode/project.code-snippets'),

    -- Custom loader for language-specific project-local snippets
    function(context)
      local rel_path = '.vscode/' .. context.lang .. '.code-snippets'
      if vim.fn.filereadable(rel_path) == 0 then return end
      return MiniSnippets.read_file(rel_path)
    end,
  },
})

-- mini.splitjoin
require("mini.splitjoin").setup()

-- mini.starter
-- require("mini.starter").setup({})

-- mini.surround
require("mini.surround").setup({
  mappings = {
    highlight = nil,
  }
})

-- mini.keymap
local map_multistep = require('mini.keymap').map_multistep
local tab_steps = { 'minisnippets_next', 'minisnippets_expand', 'jump_after_tsnode', 'jump_after_close' }
map_multistep('i', '<Tab>', tab_steps)

local shifttab_steps = { 'minisnippets_prev', 'jump_before_tsnode', 'jump_before_open' }
map_multistep('i', '<S-Tab>', shifttab_steps)

-- mini.clue
local miniclue = require('mini.clue')
miniclue.setup({
  triggers = {
    -- Leader triggers
    { mode = 'n', keys = '<Leader>' },
    { mode = 'x', keys = '<Leader>' },

    -- Built-in completion
    { mode = 'i', keys = '<C-x>' },

    -- `g` key
    { mode = 'n', keys = 'g' },
    { mode = 'x', keys = 'g' },

    -- Marks
    { mode = 'n', keys = "'" },
    { mode = 'n', keys = '`' },
    { mode = 'x', keys = "'" },
    { mode = 'x', keys = '`' },

    -- Registers
    { mode = 'n', keys = '"' },
    { mode = 'x', keys = '"' },
    { mode = 'i', keys = '<C-r>' },
    { mode = 'c', keys = '<C-r>' },

    -- Window commands
    { mode = 'n', keys = '<C-w>' },

    -- `z` key
    { mode = 'n', keys = 'z' },
    { mode = 'x', keys = 'z' },

    -- `m` key
    { mode = 'n', keys = 'm' },
    { mode = 'x', keys = 'm' },

    -- `\` key
    { mode = 'n', keys = '\\' },
    { mode = 'x', keys = '\\' },
  },

  clues = {
    -- Enhance this by adding descriptions for <Leader> mapping groups
    miniclue.gen_clues.builtin_completion(),
    miniclue.gen_clues.g(),
    miniclue.gen_clues.marks(),
    miniclue.gen_clues.registers(),
    miniclue.gen_clues.windows(),
    miniclue.gen_clues.z(),
  },
})
