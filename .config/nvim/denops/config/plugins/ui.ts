// =============================================================================
// File        : ui.ts
// Author      : yukimemi
// Last Change : 2024/10/19 08:35:39.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@5.0.9";

import * as autocmd from "jsr:@denops/std@7.2.0/autocmd";
import * as fn from "jsr:@denops/std@7.2.0/function";
import * as lambda from "jsr:@denops/std@7.2.0/lambda";
import * as mapping from "jsr:@denops/std@7.2.0/mapping";
import * as nvimFn from "jsr:@denops/std@7.2.0/function/nvim";
import * as vars from "jsr:@denops/std@7.2.0/variable";

import { pluginStatus } from "../pluginstatus.ts";

export const ui: Plug[] = [
  { url: "https://github.com/lambdalisue/vim-seethrough", enabled: true },
  { url: "https://github.com/andymass/vim-matchup", enabled: false },
  { url: "https://github.com/mopp/smartnumber.vim", enabled: true },
  { url: "https://github.com/sitiom/nvim-numbertoggle", enabled: false },
  {
    url: "https://github.com/Isrothy/neominimap.nvim",
    enabled: false,
    before: async ({ denops }) => {
      await vars.o.set(denops, "sidescrolloff", 36);
      await vars.g.set(denops, "neominimap", {
        auto_enable: true,
        exclude_filetypes: [
          "help",
          "ddu-ff",
        ],
        exclude_buftypes: [
          "nofile",
          "nowrite",
          "quickfix",
          "terminal",
          "prompt",
        ],
      });
    },
  },
  {
    url: "https://github.com/lukas-reineke/virt-column.nvim",
    enabled: pluginStatus.virt_column,
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("virt-column").setup()`);
    },
  },
  {
    url: "https://github.com/xiyaowong/virtcolumn.nvim",
    enabled: pluginStatus.virtcolumn,
  },
  {
    url: "https://github.com/ecthelionvi/NeoColumn.nvim",
    enabled: pluginStatus.neocolumn,
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("NeoColumn").setup(_A)`, {
        NeoColumn: 100,
      });
    },
  },
  {
    url: "https://github.com/RRethy/vim-illuminate",
    dependencies: ["https://github.com/nvim-treesitter/nvim-treesitter"],
    enabled: true,
  },
  {
    url: "https://github.com/unblevable/quick-scope",
    enabled: false,
    before: async ({ denops }) => {
      await vars.g.set(denops, "qs_lazy_highlight", 1);
    },
  },
  {
    url: "https://github.com/jinh0/eyeliner.nvim",
    afterFile: `~/.config/nvim/rc/after/eyeliner.lua`,
  },
  { url: "https://github.com/deris/vim-shot-f", enabled: false },
  {
    url: "https://github.com/mei28/luminate.nvim",
    enabled: false,
    afterFile: `~/.config/nvim/rc/after/luminate.lua`,
  },
  { url: "https://github.com/itchyny/vim-parenmatch", enabled: false },
  { url: "https://github.com/ntpeters/vim-better-whitespace" },
  {
    url: "https://github.com/LumaKernel/nvim-visual-eof.lua",
    after: async ({ denops }) => {
      await denops.cmd(`lua require("visual-eof").setup()`);
    },
  },
  { url: "https://github.com/DanilaMihailov/beacon.nvim", enabled: false },
  {
    url: "https://github.com/mvllow/modes.nvim",
    afterFile: `~/.config/nvim/rc/after/modes.lua`,
  },
  {
    url: "https://github.com/gen740/SmoothCursor.nvim",
    enabled: true,
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
    enabled: pluginStatus.indentblankline,
    dependencies: [
      "https://github.com/nvim-treesitter/nvim-treesitter",
      // "https://github.com/HiPhish/rainbow-delimiters.nvim",
    ],
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("ibl").setup(_A)`, {
        indent: { char: `▏` },
      });
    },
    // afterFile: `~/.config/nvim/rc/after/indent-blankline.lua`,
  },
  {
    url: "https://github.com/shellRaining/hlchunk.nvim",
    enabled: pluginStatus.hlchunk,
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
    dependencies: [
      "https://github.com/nvim-tree/nvim-web-devicons",
      "https://github.com/lewis6991/gitsigns.nvim",
    ],
    afterFile: `~/.config/nvim/rc/after/incline.lua`,
  },
  {
    url: "https://github.com/romgrk/barbar.nvim",
    enabled: pluginStatus.barbar,
    afterFile: `~/.config/nvim/rc/after/barbar.lua`,
  },
  {
    url: "https://github.com/akinsho/bufferline.nvim",
    enabled: pluginStatus.bufferline,
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
    enabled: pluginStatus.barbecue,
    dependencies: [
      "https://github.com/SmiteshP/nvim-navic",
      "https://github.com/nvim-tree/nvim-web-devicons",
    ],
    after: async ({ denops }) => {
      await denops.cmd(`lua require("barbecue").setup()`);
    },
  },
  {
    url: "https://github.com/tzachar/highlight-undo.nvim",
    enabled: false,
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
    afterFile: `~/.config/nvim/rc/after/edgy.lua`,
  },
  {
    url: "https://github.com/lewis6991/satellite.nvim",
    enabled: pluginStatus.satellite,
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
    after: async ({ denops }) => {
      await denops.cmd(`lua require("colorful-winsep").setup()`);
    },
  },
  {
    url: "https://github.com/Aasim-A/scrollEOF.nvim",
    after: async ({ denops }) => {
      await denops.cmd(`lua require("scrollEOF").setup()`);
    },
  },
  {
    url: "https://github.com/tamton-aquib/flirt.nvim",
    enabled: Deno.build.os !== "windows" && false,
    after: async ({ denops }) => {
      await denops.cmd(`lua require("flirt").setup()`);
    },
  },
  { url: "https://github.com/gw31415/scrollUptoLastLine.vim", enabled: false },
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
    enabled: pluginStatus.scrollbar,
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("scrollbar").setup()`);
    },
  },
  {
    url: "https://github.com/shortcuts/no-neck-pain.nvim",
    enabled: false,
  },
  { url: "https://github.com/haolian9/gary.nvim", enabled: false },
  { url: "https://github.com/thinca/vim-zenspace" },
  {
    url: "https://github.com/Abizrh/beastie.nvim",
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("beastie").setup()`);
    },
  },
  { url: "https://github.com/ikouchiha47/games.nvim" },
  {
    url: "https://github.com/sethen/line-number-change-mode.nvim",
    afterFile: "~/.config/nvim/rc/after/line-number-change-mode.lua",
  },
];
