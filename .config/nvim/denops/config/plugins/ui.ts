import { Denops } from "https://deno.land/x/denops_std@v4.3.1/mod.ts";
import { execute } from "https://deno.land/x/denops_std@v4.3.1/helper/mod.ts";
import { type Plug } from "https://deno.land/x/dvpm@0.0.6/plugin.ts";

export const ui: Plug[] = [
  { url: "rafi/awesome-vim-colorschemes" },
  { url: "RRethy/nvim-base16" },
  { url: "catppuccin/nvim" },
  {
    url: "rcarriga/nvim-notify",
    after: async (denops: Denops) => {
      await execute(
        denops,
        `
lua << EOB
      local notify = require("notify")
      notify.setup({
        stages = "slide",
      })
      vim.notify = notify
EOB
    `,
      );
    },
  },
  {
    url: "gen740/SmoothCursor.nvim",
    after: async (denops: Denops) => {
      await execute(
        denops,
        `
lua << EOB
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
EOB
    `,
      );
    },
  },
  {
    url: "windwp/nvim-autopairs",
    after: async (denops: Denops) => {
      await execute(denops, `lua require("nvim-autopairs").setup()`);
    },
  },
  {
    url: "monaqa/modesearch.nvim",
    after: async (denops: Denops) => {
      await execute(
        denops,
        `
lua << EOB
      vim.keymap.set("n", "/", function() return require("modesearch").keymap.prompt.show("rawstr") end, { expr = true })
      vim.keymap.set(
        "c",
        "<C-x>",
        function() return require("modesearch").keymap.mode.cycle({ "rawstr", "migemo", "regexp" }) end,
        { expr = true }
      )
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
EOB
    `,
      );
    },
  },
  {
    url: "folke/which-key.nvim",
    after: async (denops: Denops) => {
      await execute(denops, `lua require("which-key").setup()`);
    },
  },
];