import { Denops } from "https://deno.land/x/denops_std@v4.3.3/mod.ts";
import * as mapping from "https://deno.land/x/denops_std@v4.3.3/mapping/mod.ts";
import { has } from "https://deno.land/x/denops_std@v4.3.3/function/mod.ts";
import { execute } from "https://deno.land/x/denops_std@v4.3.3/helper/mod.ts";
import { type Plug } from "https://deno.land/x/dvpm@0.1.1/mod.ts";

export const ui: Plug[] = [
  { url: "rafi/awesome-vim-colorschemes" },
  {
    url: "RRethy/nvim-base16",
    enabled: async (denops: Denops) => (await has(denops, "nvim")),
  },
  {
    url: "catppuccin/nvim",
    enabled: async (denops: Denops) => (await has(denops, "nvim")),
  },
  {
    url: "rcarriga/nvim-notify",
    enabled: async (denops: Denops) => (await has(denops, "nvim")),
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
    enabled: async (denops: Denops) => (await has(denops, "nvim")),
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
    url: "lukas-reineke/indent-blankline.nvim",
    enabled: async (denops: Denops) => (await has(denops, "nvim")),
    after: async (denops: Denops) => {
      await execute(
        denops,
        `
lua << EOB
  require("indent_blankline").setup({
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true,
  })
EOB
    `,
      );
    },
  },
  {
    url: "monaqa/modesearch.nvim",
    enabled: async (denops: Denops) => (await has(denops, "nvim")),
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
    enabled: async (denops: Denops) => (await has(denops, "nvim")),
    after: async (denops: Denops) => {
      await execute(denops, `lua require("which-key").setup()`);
    },
  },
  {
    url: "liuchengxu/vim-which-key",
    enabled: async (denops: Denops) => !(await has(denops, "nvim")),
    after: async (denops: Denops) => {
      await mapping.map(denops, "<leader>", "<cmd>WhichKey '<space>'<cr>", {
        mode: ["n", "x"],
      });
      await mapping.map(denops, "<localleader>", "<cmd>WhichKey '\\'<cr>", {
        mode: ["n", "x"],
      });
    },
  },
];
