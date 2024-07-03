// =============================================================================
// File        : ui.ts
// Author      : yukimemi
// Last Change : 2024/07/03 00:55:45.
// =============================================================================

import type { Plug } from "https://deno.land/x/dvpm@3.14.7/mod.ts";

import * as autocmd from "https://deno.land/x/denops_std@v6.5.0/autocmd/mod.ts";
import * as fn from "https://deno.land/x/denops_std@v6.5.0/function/mod.ts";
import * as lambda from "https://deno.land/x/denops_std@v6.5.0/lambda/mod.ts";
import * as mapping from "https://deno.land/x/denops_std@v6.5.0/mapping/mod.ts";
import * as nvimFn from "https://deno.land/x/denops_std@v6.5.0/function/nvim/mod.ts";
import * as vars from "https://deno.land/x/denops_std@v6.5.0/variable/mod.ts";

import { pluginStatus } from "../pluginstatus.ts";

export const ui: Plug[] = [
  { url: "https://github.com/lambdalisue/vim-seethrough" },
  { url: "https://github.com/andymass/vim-matchup" },
  { url: "https://github.com/mopp/smartnumber.vim", enabled: true },
  { url: "https://github.com/sitiom/nvim-numbertoggle", enabled: false },
  {
    url: "https://github.com/lukas-reineke/virt-column.nvim",
    enabled: pluginStatus.virtcolumn && !pluginStatus.vscode,
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("virt-column").setup()`);
    },
  },
  {
    url: "https://github.com/ecthelionvi/NeoColumn.nvim",
    enabled: pluginStatus.neocolumn && !pluginStatus.vscode,
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("NeoColumn").setup(_A)`, {
        NeoColumn: 100,
      });
    },
  },
  {
    url: "https://github.com/RRethy/vim-illuminate",
    dependencies: [{ url: "https://github.com/nvim-treesitter/nvim-treesitter" }],
    // deno-lint-ignore require-await
    enabled: async ({ denops }) => denops.meta.host === "nvim" && !pluginStatus.vscode,
  },
  {
    url: "https://github.com/unblevable/quick-scope",
    before: async ({ denops }) => {
      await vars.g.set(denops, "qs_lazy_highlight", 1);
    },
  },
  { url: "https://github.com/itchyny/vim-parenmatch" },
  { url: "https://github.com/ntpeters/vim-better-whitespace" },
  {
    url: "https://github.com/LumaKernel/nvim-visual-eof.lua",
    after: async ({ denops }) => {
      await denops.cmd(`lua require("visual-eof").setup()`);
    },
  },
  { url: "https://github.com/DanilaMihailov/beacon.nvim" },
  {
    url: "https://github.com/mvllow/modes.nvim",
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("modes").setup(_A)`, {
        colors: {
          copy: "#f5c359",
          delete: "#c75c6a",
          insert: "#78ccc5",
          visual: "#9745be",
        },

        // Set opacity for cursorline and number background
        line_opacity: 0.15,

        // Enable cursor highlights
        set_cursor: true,

        // Enable cursorline initially, and disable cursorline for inactive windows
        // or ignored filetypes
        set_cursorline: true,

        // Enable line number highlights to match cursorline
        set_number: true,

        // Disable modes highlights in specified filetypes
        // Please PR commonly ignored filetypes
        ignore_filetypes: ["NvimTree", "TelescopePrompt"],
      });
    },
  },
  {
    url: "https://github.com/gen740/SmoothCursor.nvim",
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("smoothcursor").setup(_A)`, {
        autostart: true,
        cursor: "",
        texthl: "SmoothCursor",
        linehl: null,
        type: "default",
        fancy: {
          enable: true,
          head: { cursor: "▷", texthl: "SmoothCursor", linehl: null },
          body: [
            { cursor: "★", texthl: "SmoothCursorRed" },
            { cursor: "☆", texthl: "SmoothCursorOrange" },
            { cursor: "󱐋", texthl: "SmoothCursorYellow" },
            { cursor: "󱐌", texthl: "SmoothCursorGreen" },
            { cursor: "•", texthl: "SmoothCursorAqua" },
            { cursor: ".", texthl: "SmoothCursorBlue" },
            { cursor: ".", texthl: "SmoothCursorPurple" },
          ],
          tail: { cursor: null, texthl: "SmoothCursor" },
        },
        flyin_effect: "bottom",
        speed: 25,
        intervals: 35,
        priority: 10,
        timeout: 3000,
        threshold: 3,
        disable_float_win: false,
        enabled_filetypes: null,
        disabled_filetypes: ["ddu-ff", "ddu-ff-filter", "coc-explorer", "fern"],
      });

      await autocmd.group(denops, "MySmoothCursor", (helper) => {
        helper.remove("*");
        helper.define(
          "ModeChanged",
          "*",
          `call <SID>${denops.name}_notify("${
            lambda.register(
              denops,
              async () => {
                const mode = await fn.mode(denops);
                if (mode === "n") {
                  await nvimFn.nvim_set_hl(denops, 0, "SmoothCursor", {
                    fg: "#8aa872",
                  });
                  await denops.call("sign_define", "smoothcursor", {
                    text: "▷",
                  });
                } else if (mode === "v") {
                  await nvimFn.nvim_set_hl(denops, 0, "SmoothCursor", {
                    fg: "#bf616a",
                  });
                  await denops.call("sign_define", "smoothcursor", {
                    text: "",
                  });
                } else if (mode === "V") {
                  await nvimFn.nvim_set_hl(denops, 0, "SmoothCursor", {
                    fg: "#bf616a",
                  });
                  await denops.call("sign_define", "smoothcursor", {
                    text: "",
                  });
                } else if (mode === "") {
                  await nvimFn.nvim_set_hl(denops, 0, "SmoothCursor", {
                    fg: "#bf616a",
                  });
                  await denops.call("sign_define", "smoothcursor", {
                    text: "",
                  });
                } else if (mode === "i") {
                  await nvimFn.nvim_set_hl(denops, 0, "SmoothCursor", {
                    fg: "#668aab",
                  });
                  await denops.call("sign_define", "smoothcursor", {
                    text: "",
                  });
                }
              },
            )
          }", [])`,
        );
      });
    },
  },
  {
    url: "https://github.com/lukas-reineke/indent-blankline.nvim",
    enabled: pluginStatus.indentblankline && !pluginStatus.vscode,
    dependencies: [{ url: "https://github.com/nvim-treesitter/nvim-treesitter" }],
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("ibl").setup(_A)`, {
        indent: { char: `▏` },
      });
    },
  },
  {
    url: "https://github.com/shellRaining/hlchunk.nvim",
    enabled: pluginStatus.hlchunk && !pluginStatus.vscode,
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("hlchunk").setup(_A)`, {
        chunk: {
          enable: true,
          notify: true,
        },
        indent: {
          enable: true,
          use_treesitter: false,
        },
        line_num: {
          enable: true,
          use_treesitter: true,
        },
        blank: {
          enable: false,
        },
      });
    },
  },
  {
    url: "https://github.com/Yggdroot/indentLine",
    // deno-lint-ignore require-await
    enabled: async ({ denops }) => denops.meta.host === "vim",
    // deno-lint-ignore require-await
    clone: async ({ denops }) => denops.meta.host === "vim",
  },
  {
    url: "https://github.com/b0o/incline.nvim",
    enabled: !pluginStatus.vscode,
    dependencies: [
      { url: "https://github.com/nvim-tree/nvim-web-devicons" },
      { url: "https://github.com/lewis6991/gitsigns.nvim" },
    ],
    afterFile: `~/.config/nvim/rc/after/incline.lua`,
  },
  {
    url: "https://github.com/romgrk/barbar.nvim",
    enabled: !pluginStatus.vscode && pluginStatus.barbar,
    afterFile: `~/.config/nvim/rc/after/barbar.lua`,
  },
  {
    url: "https://github.com/akinsho/bufferline.nvim",
    enabled: !pluginStatus.vscode && pluginStatus.bufferline,
    after: async ({ denops }) => {
      await denops.cmd(`lua require("bufferline").setup()`);
    },
  },
  {
    url: "https://github.com/tomiis4/BufferTabs.nvim",
    enabled: pluginStatus.buffertabs,
    after: async ({ denops }) => {
      await denops.cmd(`lua require("buffertabs").setup()`);
    },
  },
  {
    url: "https://github.com/utilyre/barbecue.nvim",
    // HEAD
    enabled: pluginStatus.barbecue && !pluginStatus.vscode,
    dependencies: [
      { url: "https://github.com/SmiteshP/nvim-navic" },
      { url: "https://github.com/nvim-tree/nvim-web-devicons" },
    ],
    after: async ({ denops }) => {
      await denops.cmd(`lua require("barbecue").setup()`);
    },
  },
  {
    url: "https://github.com/tzachar/highlight-undo.nvim",
    after: async ({ denops }) => {
      await denops.call(
        `luaeval`,
        `require("highlight-undo").setup(_A)`,
        {
          hlgroup: "HighlightUndo",
          duration: 500,
        },
      );
    },
  },
  {
    url: "https://github.com/folke/edgy.nvim",
    enabled: !pluginStatus.vscode,
    afterFile: `~/.config/nvim/rc/after/edgy.lua`,
  },
  {
    url: "https://github.com/lewis6991/satellite.nvim",
    enabled: !pluginStatus.vscode && false,
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("satellite").setup()`);
    },
  },
  {
    url: "https://github.com/4513ECHO/vim-snipewin",
    enabled: pluginStatus.snipewin,
    before: async ({ denops }) => {
      await mapping.map(denops, "sw", "<Plug>(snipewin)", { mode: "n" });
    },
  },
  {
    url: "https://github.com/s1n7ax/nvim-window-picker",
    enabled: pluginStatus.windowpicker,
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("window-picker").setup(_A)`, {
        hint: "floating-big-letter",
      });
      await mapping.map(
        denops,
        "sw",
        "<cmd>lua require('window-picker').pick_window()<cr>",
        {
          mode: "n",
        },
      );
    },
  },
  {
    url: "https://github.com/nvim-zh/colorful-winsep.nvim",
    enabled: !pluginStatus.vscode,
    after: async ({ denops }) => {
      await denops.cmd(`lua require("colorful-winsep").setup()`);
    },
  },
  {
    url: "https://github.com/Aasim-A/scrollEOF.nvim",
    enabled: !pluginStatus.vscode,
    after: async ({ denops }) => {
      await denops.cmd(`lua require("scrollEOF").setup()`);
    },
  },
  {
    url: "https://github.com/tamton-aquib/flirt.nvim",
    enabled: !pluginStatus.vscode && Deno.build.os !== "windows" && false,
    after: async ({ denops }) => {
      await denops.cmd(`lua require("flirt").setup()`);
    },
  },
  { url: "https://github.com/gw31415/scrollUptoLastLine.vim" },
  {
    url: "https://github.com/moyiz/command-and-cursor.nvim",
    enabled: false,
    afterFile: "~/.config/nvim/rc/after/command-and-cursor.lua",
  },
  {
    url: "https://github.com/adelarsq/snake_cursor.nvim",
    enabled: false,
    after: async ({ denops }) => {
      await denops.cmd(`lua require("snake_cursor").setup()`);
    },
  },
  {
    url: "https://github.com/luukvbaal/statuscol.nvim",
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("statuscol").setup()`);
    },
  },
  {
    url: "https://github.com/petertriho/nvim-scrollbar",
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("scrollbar").setup()`);
    },
  },
];
