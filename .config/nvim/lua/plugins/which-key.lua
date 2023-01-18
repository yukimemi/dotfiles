return {
  "folke/which-key.nvim",

  event = "VimEnter",

  config = function()
    local util = require("util")
    local wk = require("which-key")
    wk.setup({
      show_help = false,
      triggers = "auto",
      plugins = { spelling = true },
      key_labels = { ["<leader>"] = "SPC" },
    })

    local leader = {
      b = { name = "+bookmarks" },
      d = { name = "+ddu" },
      h = { name = "+help" },
      s = { name = "+search" },
      f = { name = "+file" },
      p = { name = "+project" },
      g = {
        name = "+git",
        h = { name = "+hunk" },
      },
      o = {
        name = "+open",
        i = { "<cmd>edit ~/.config/nvim/init.lua<cr>", "Open init.lua" },
      },
      t = {
        name = "toggle",
        s = {
          function() util.toggle("spell") end,
          "Toggle spell",
        },
        w = {
          function() util.toggle("wrap") end,
          "Toggle wrap",
        },
        n = {
          function() util.toggle("relativenumber", true) end,
          "Toggle relativenumber",
        },
        b = {
          name = "+background",
          o = {
            function()
              vim.cmd([[GuiWindowOpacity 0.9]])
            end,
            "GuiWindowOpacity 0.9",
          },
          O = {
            function()
              vim.cmd([[GuiWindowOpacity 1.0]])
            end,
            "GuiWindowOpacity 1.0",
          },
        },
        f = {
          name = "+fileformat",
          d = {
            function()
              vim.cmd([[e ++ff=dos]])
            end,
            "Dos",
          },
          u = {
            function()
              vim.cmd([[e ++ff=unix]])
            end,
            "Unix",
          },
        },
        r = {
          name = "+review",
          s = {
            function()
              vim.cmd([[GuiWindowOpacity 1.0]])
              vim.cmd([[DisableRandomColorscheme]])
              vim.cmd([[colorscheme github]])
              vim.opt.background = "light"
              vim.opt.relativenumber = false
              vim.opt.number = true
            end,
            "Review start",
          },
          e = {
            function()
              vim.cmd([[GuiWindowOpacity 0.9]])
              vim.cmd([[EnableRandomColorscheme]])
              vim.opt.relativenumber = true
            end,
            "Review end",
          },
        },
      },
      ["<tab>"] = {
        name = "tabs",
        ["<tab>"] = { "<cmd>tabnew<cr>", "New Tab" },
        n = { "<cmd>tabnext<cr>", "Next" },
        d = { "<cmd>tabclose<cr>", "Close" },
        p = { "<cmd>tabprevious<cr>", "Previous" },
        ["]"] = { "<cmd>tabnext<cr>", "Next" },
        ["["] = { "<cmd>tabprevious<cr>", "Previous" },
        f = { "<cmd>tabfirst<cr>", "First" },
        l = { "<cmd>tablast<cr>", "Last" },
      },
      q = {
        name = "+quit",
        q = { "<cmd>qa<cr>", "Quit" },
        ["!"] = { "<cmd>:qa!<cr>", "Quit without saving" },
      },
      x = {
        name = "+errors",
        l = { "<cmd>lopen<cr>", "Open Location List" },
        q = { "<cmd>copen<cr>", "Open Quickfix List" },
      },
      T = {
        function() util.test(true) end,
        "Plenary Test File",
      },
      D = {
        function() util.test() end,
        "Plenary Test Directory",
      },
    }

    wk.register(leader, { prefix = "<leader>" })

    wk.register({ g = { name = "+goto" } })
  end,
}
