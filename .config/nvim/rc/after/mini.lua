-- =============================================================================
-- File        : mini.lua
-- Author      : yukimemi
-- Last Change : 2025/09/14 13:25:23.
-- =============================================================================

require("mini.notify").setup({})
require("mini.icons").setup({})
-- require("mini.animate").setup({})
require("mini.align").setup({})
require("mini.tabline").setup({})
require("mini.cursorword").setup({})
require("mini.hipatterns").setup({})
require("mini.trailspace").setup({})
require("mini.visits").setup({})

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
require("mini.files").setup({})
vim.keymap.set("n", "ge", MiniFiles.open, { desc = "Mini files" })

-- mini.pick
require("mini.pick").setup({})
vim.keymap.set("n", "<space>pp", "<cmd>Pick files<cr>", { desc = "MiniPick files" })
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
require("mini.extra").setup({})

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
require("mini.indentscope").setup({})

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
    -- Load custom file with global snippets first (adjust for Windows)
    gen_loader.from_file('~/.config/nvim/snippets/global.json'),

    -- Load snippets based on current language by reading files from
    -- "snippets/" subdirectories from 'runtimepath' directories.
    gen_loader.from_lang(),
  },
})

-- mini.splitjoin
require("mini.splitjoin").setup({})

-- mini.starter
-- require("mini.starter").setup({})

-- mini.surround
require("mini.surround").setup({
  mappings = {
    highlight = nil,
  }
})
