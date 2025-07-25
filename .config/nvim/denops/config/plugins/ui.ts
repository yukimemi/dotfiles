// =============================================================================
// File        : ui.ts
// Author      : yukimemi
// Last Change : 2025/05/10 20:51:16.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@7.1.0";

import * as autocmd from "jsr:@denops/std@7.6.0/autocmd";
import * as fn from "jsr:@denops/std@7.6.0/function";
import * as lambda from "jsr:@denops/std@7.6.0/lambda";
import * as mapping from "jsr:@denops/std@7.6.0/mapping";
import * as nvimFn from "jsr:@denops/std@7.6.0/function/nvim";
import * as vars from "jsr:@denops/std@7.6.0/variable";

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
    profiles: ["default"],
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
    profiles: ["default"],
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
    profiles: ["default"],
    afterFile: `~/.config/nvim/rc/after/eyeliner.lua`,
  },
  { url: "https://github.com/deris/vim-shot-f", enabled: false },
  {
    url: "https://github.com/mei28/luminate.nvim",
    enabled: false,
    afterFile: `~/.config/nvim/rc/after/luminate.lua`,
  },
  { url: "https://github.com/itchyny/vim-parenmatch", enabled: false },
  {
    url: "https://github.com/ntpeters/vim-better-whitespace",
    profiles: ["default"],
    enabled: pluginStatus.betterwhitespace,
    after: async ({ denops }) => {
      await vars.g.set(denops, "better_whitespace_filetypes_blacklist", [
        "diff",
        "git",
        "gitcommit",
        "unite",
        "qf",
        "help",
        "markdown",
        "fugitive",
        "fall-input",
        "fall-list",
        "fall-help",
      ]);
    },
  },
  {
    url: "https://github.com/LumaKernel/nvim-visual-eof.lua",
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("visual-eof").setup()`);
    },
  },
  {
    url: "https://github.com/DanilaMihailov/beacon.nvim",
    enabled: true,
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("beacon").setup()`);
    },
  },
  {
    url: "https://github.com/cxwx/specs.nvim",
    enabled: false,
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("specs").setup(_A)`, {});
    },
  },
  {
    url: "https://github.com/mvllow/modes.nvim",
    enabled: false,
    afterFile: `~/.config/nvim/rc/after/modes.lua`,
  },
  {
    url: "https://github.com/gen740/SmoothCursor.nvim",
    profiles: ["full"],
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
        disabled_filetypes: [
          "NvimTree",
          "TelescopePrompt",
          "aerial",
          "asyncwalker",
          "asyncwalker-filter",
          "coc-explorer",
          "ctrlp",
          "ddu",
          "ddu-ff",
          "ddu-ff-filter",
          "ddu-filer",
          "fall-help",
          "fall-input",
          "fall-list",
          "gundo",
          "list",
          "neo-tree",
          "qf",
          "quickfix",
          "undotree",
        ],
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
    url: "https://github.com/sphamba/smear-cursor.nvim",
    enabled: false,
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("smear_cursor").setup()`);
    },
  },
  {
    url: "https://github.com/lukas-reineke/indent-blankline.nvim",
    profiles: ["full"],
    enabled: pluginStatus.indentblankline,
    dependencies: [
      "https://github.com/nvim-treesitter/nvim-treesitter",
      "https://github.com/HiPhish/rainbow-delimiters.nvim",
    ],
    afterFile: `~/.config/nvim/rc/after/indent-blankline.lua`,
  },
  {
    url: "https://github.com/shellRaining/hlchunk.nvim",
    profiles: ["full"],
    enabled: pluginStatus.hlchunk,
    dependencies: ["https://github.com/nvim-treesitter/nvim-treesitter"],
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("hlchunk").setup(_A)`, {
        chunk: {
          enable: true,
          notify: true,
        },
        indent: {
          enable: true,
          use_treesitter: true,
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
    enabled: pluginStatus.incline,
    dependencies: [
      "https://github.com/SmiteshP/nvim-navic",
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
      await denops.call(`luaeval`, `require("bufferline").setup()`);
    },
  },
  {
    url: "https://github.com/tomiis4/BufferTabs.nvim",
    enabled: pluginStatus.buffertabs,
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("buffertabs").setup()`);
    },
  },
  {
    url: "https://github.com/utilyre/barbecue.nvim",
    enabled: pluginStatus.barbecue,
    dependencies: [
      "https://github.com/SmiteshP/nvim-navic",
      "https://github.com/nvim-tree/nvim-web-devicons",
    ],
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("barbecue").setup()`);
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
      await denops.call(`luaeval`, `require("colorful-winsep").setup()`);
    },
  },
  {
    url: "https://github.com/Aasim-A/scrollEOF.nvim",
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("scrollEOF").setup()`);
    },
  },
  {
    url: "https://github.com/tamton-aquib/flirt.nvim",
    enabled: Deno.build.os !== "windows" && false,
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("flirt").setup()`);
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
      await denops.call(`luaeval`, `require("snake_cursor").setup()`);
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
    dependencies: ["https://github.com/catppuccin/nvim"],
    afterFile: "~/.config/nvim/rc/after/line-number-change-mode.lua",
  },
  {
    url: "https://github.com/sedm0784/vim-rainbow-trails",
    enabled: false,
    after: async ({ denops }) => {
      await denops.cmd(`RainbowTrails`);
    },
  },
  {
    url: "https://github.com/folke/drop.nvim",
    enabled: false,
    afterFile: "~/.config/nvim/rc/after/drop.lua",
  },
  {
    url: "https://github.com/mawkler/hml.nvim",
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("hml").setup()`);
    },
  },
  {
    url: "https://github.com/itchyny/vim-highlighturl",
    profiles: ["colors", "favaritecolors"],
  },
  {
    url: "https://github.com/Bekaboo/dropbar.nvim",
    profiles: ["full"],
    afterFile: "~/.config/nvim/rc/after/dropbar.lua",
  },
  {
    url: "https://github.com/kevinhwang91/nvim-ufo",
    dependencies: ["https://github.com/kevinhwang91/promise-async"],
    profiles: ["lsp"],
    afterFile: "~/.config/nvim/rc/after/nvim-ufo.lua",
  },
];
