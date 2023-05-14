import { Plugin } from "./types.ts";

export const ui: Plugin[] = [
  { org: "rafi", repo: "awesome-vim-colorschemes" },
  { org: "RRethy", repo: "nvim-base16" },
  {
    org: "catppuccin",
    repo: "nvim",
    lua_post: `
      require("catppuccin").setup({
        integrations = {
          aerial = true,
          bufferline = true,
          gitsigns = true,
          illuminate = true,
          lsp_trouble = true,
          mason = true,
          notify = true,
          nvimtree = true,
          sandwich = true,
          semantic_tokens = true,
          treesitter = true,
          treesitter_context = true,

          native_lsp = {
            enabled = true,
          },
        },
      })
      vim.cmd([[colorscheme catppuccin-mocha]])
    `,
  },
  {
    org: "rcarriga",
    repo: "nvim-notify",
    lua_post: `
      local notify = require("notify")
      notify.setup({
        stages = "slide",
      })
      vim.notify = notify
    `,
  },
  {
    org: "gen740",
    repo: "SmoothCursor.nvim",
    lua_post: `
      require("smoothcursor").setup({
        autostart = true,
        cursor = "", -- cursor shape (need nerd font)
        texthl = "SmoothCursor", -- highlight group, default is { bg = nil, fg = "#FFD400" }
        linehl = nil, -- highlight sub-cursor line like 'cursorline', "CursorLine" recommended
        type = "default", -- define cursor movement calculate function, "default" or "exp" (exponential).
        fancy = {
          enable = true, -- enable fancy mode
          head = { cursor = "▷", texthl = "SmoothCursor", linehl = nil },
          body = {
            { cursor = "", texthl = "SmoothCursorRed" },
            { cursor = "", texthl = "SmoothCursorOrange" },
            { cursor = "●", texthl = "SmoothCursorYellow" },
            { cursor = "●", texthl = "SmoothCursorGreen" },
            { cursor = "•", texthl = "SmoothCursorAqua" },
            { cursor = ".", texthl = "SmoothCursorBlue" },
            { cursor = ".", texthl = "SmoothCursorPurple" },
          },
          tail = { cursor = nil, texthl = "SmoothCursor" }
        },
        flyin_effect = "bottom", -- "bottom" or "top"
        speed = 25, -- max is 100 to stick to your current position
        intervals = 35, -- tick interval
        priority = 10, -- set marker priority
        timeout = 3000, -- timout for animation
        threshold = 3, -- animate if threshold lines jump
        disable_float_win = false, -- disable on float window
        enabled_filetypes = nil, -- example: { "lua", "vim" }
        disabled_filetypes = nil, -- this option will be skipped if enabled_filetypes is set. example: { "TelescopePrompt", "NvimTree" }
      })

      vim.api.nvim_create_autocmd({ 'ModeChanged' }, {
        callback = function()
          local current_mode = vim.fn.mode()
          if current_mode == 'n' then
            vim.api.nvim_set_hl(0, 'SmoothCursor', { fg = '#8aa872' })
            vim.fn.sign_define('smoothcursor', { text = '▷' })
          elseif current_mode == 'v' then
            vim.api.nvim_set_hl(0, 'SmoothCursor', { fg = '#bf616a' })
            vim.fn.sign_define('smoothcursor', { text = '' })
          elseif current_mode == 'V' then
            vim.api.nvim_set_hl(0, 'SmoothCursor', { fg = '#bf616a' })
            vim.fn.sign_define('smoothcursor', { text = '' })
          elseif current_mode == '' then
            vim.api.nvim_set_hl(0, 'SmoothCursor', { fg = '#bf616a' })
            vim.fn.sign_define('smoothcursor', { text = '' })
          elseif current_mode == 'i' then
            vim.api.nvim_set_hl(0, 'SmoothCursor', { fg = '#668aab' })
            vim.fn.sign_define('smoothcursor', { text = '' })
          end
        end,
      })
    `,
  },
  {
    org: "windwp",
    repo: "nvim-autopairs",
    lua_post: `require("nvim-autopairs").setup()`,
  },
  {
    org: "monaqa",
    repo: "modesearch.nvim",
    lua_pre: `
      vim.keymap.set("n", "/", function() return require("modesearch").keymap.prompt.show("rawstr") end, { expr = true })
      vim.keymap.set(
        "c",
        "<C-x>",
        function() return require("modesearch").keymap.mode.cycle({ "rawstr", "migemo", "regexp" }) end,
        { expr = true }
      )
    `,
    lua_post: `
      require("modesearch").setup({
        modes = {
          rawstr = {
            prompt = "[rawstr]/",
            converter = function(query) return [[\\V]] .. vim.fn.escape(query, [[/\\]]) end,
          },
          regexp = {
            prompt = "[regexp]/",
            converter = function(query) return [[\\v]] .. vim.fn.escape(query, [[/]]) end,
          },
          migemo = {
            prompt = "[migemo]/",
            converter = function(query) return [[\\v]] .. vim.fn["kensaku#query"](query) end,
          },
        },
      })
    `,
  },
  {
    org: "folke",
    repo: "which-key.nvim",
    lua_post: `
      require("which-key").setup()
    `,
  },
];
