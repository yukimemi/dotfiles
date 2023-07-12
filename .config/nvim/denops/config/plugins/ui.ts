import type { Plug } from "https://deno.land/x/dvpm@2.3.0/mod.ts";

import * as autocmd from "https://deno.land/x/denops_std@v5.0.1/autocmd/mod.ts";
import * as lambda from "https://deno.land/x/denops_std@v5.0.1/lambda/mod.ts";
import * as fn from "https://deno.land/x/denops_std@v5.0.1/function/mod.ts";
import * as nvimFn from "https://deno.land/x/denops_std@v5.0.1/function/nvim/mod.ts";
import { globals } from "https://deno.land/x/denops_std@v5.0.1/variable/variable.ts";

import { pluginStatus } from "../main.ts";

export const ui: Plug[] = [
  { url: "lambdalisue/seethrough.vim" },
  { url: "andymass/vim-matchup" },
  { url: "mopp/smartnumber.vim" },
  {
    url: "RRethy/vim-illuminate",
    // deno-lint-ignore require-await
    enabled: async ({ denops }) =>
      denops.meta.host === "nvim" && !pluginStatus.vscode,
  },
  {
    url: "unblevable/quick-scope",
    before: async ({ denops }) => {
      await globals.set(denops, "qs_lazy_highlight", 1);
    },
  },
  { url: "itchyny/vim-parenmatch" },
  { url: "ntpeters/vim-better-whitespace" },
  {
    url: "LumaKernel/nvim-visual-eof.lua",
    // deno-lint-ignore require-await
    enabled: async ({ denops }) => denops.meta.host === "nvim",
    after: async ({ denops }) => {
      await denops.cmd(`lua require("visual-eof").setup()`);
    },
  },
  {
    url: "DanilaMihailov/beacon.nvim",
    // deno-lint-ignore require-await
    enabled: async ({ denops }) => denops.meta.host === "nvim",
  },
  {
    url: "mvllow/modes.nvim",
    // deno-lint-ignore require-await
    enabled: async ({ denops }) => denops.meta.host === "nvim",
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("modes").setup(_A.param)`, {
        param: {
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
        },
      });
    },
  },
  {
    url: "gen740/SmoothCursor.nvim",
    // deno-lint-ignore require-await
    enabled: async ({ denops }) => denops.meta.host === "nvim",
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("smoothcursor").setup(_A.param)`, {
        param: {
          autostart: true,
          cursor: "",
          texthl: "SmoothCursor",
          linehl: null,
          type: "default",
          fancy: {
            enable: true,
            head: { cursor: "▷", texthl: "SmoothCursor", linehl: null },
            body: [
              { cursor: "", texthl: "SmoothCursorRed" },
              { cursor: "", texthl: "SmoothCursorOrange" },
              { cursor: "●", texthl: "SmoothCursorYellow" },
              { cursor: "●", texthl: "SmoothCursorGreen" },
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
          disabled_filetypes: ["ddu-ff", "ddu-ff-filter"],
        },
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
    url: "lukas-reineke/indent-blankline.nvim",
    // deno-lint-ignore require-await
    enabled: async ({ denops }) =>
      denops.meta.host === "nvim" && !pluginStatus.vscode,
    dependencies: [{ url: "nvim-treesitter/nvim-treesitter" }],
    after: async ({ denops }) => {
      await denops.call(
        `luaeval`,
        `require("indent_blankline").setup(_A.param)`,
        {
          param: {
            space_char_blankline: " ",
            show_current_context: true,
            show_current_context_start: true,
          },
        },
      );
    },
  },
  {
    url: "Yggdroot/indentLine",
    // deno-lint-ignore require-await
    enabled: async ({ denops }) => denops.meta.host === "vim",
  },
  {
    url: "b0o/incline.nvim",
    // deno-lint-ignore require-await
    enabled: async ({ denops }) =>
      denops.meta.host === "nvim" && !pluginStatus.vscode,
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("incline").setup(_A.param)`, {
        param: {
          window: {
            width: "fit",
            placement: { horizontal: "right", vertical: "top" },
            margin: {
              horizontal: { left: 1, right: 0 },
              vertical: { bottom: 0, top: 1 },
            },
            padding: { left: 1, right: 1 },
            padding_char: " ",
            winhighlight: {
              Normal: "TreesitterContext",
            },
          },
        },
      });
    },
  },
  {
    url: "akinsho/bufferline.nvim",
    // deno-lint-ignore require-await
    enabled: async ({ denops }) =>
      denops.meta.host === "nvim" && !pluginStatus.vscode &&
      pluginStatus.bufferline,
    after: async ({ denops }) => {
      await denops.cmd(`lua require("bufferline").setup()`);
    },
  },
  {
    url: "tomiis4/BufferTabs.nvim",
    enabled: async ({ denops }) =>
      (await fn.has(denops, "nvim")) && pluginStatus.buffertabs,
    after: async ({ denops }) => {
      await denops.cmd(`lua require("buffertabs").setup()`);
    },
  },
  {
    url: "utilyre/barbecue.nvim",
    // HEAD
    // deno-lint-ignore require-await
    enabled: async ({ denops }) =>
      denops.meta.host === "nvim" && pluginStatus.barbecue &&
      !pluginStatus.vscode,
    dependencies: [
      { url: "SmiteshP/nvim-navic" },
      { url: "nvim-tree/nvim-web-devicons" },
    ],
    after: async ({ denops }) => {
      await denops.cmd(`lua require("barbecue").setup()`);
    },
  },
  {
    url: "kevinhwang91/nvim-bqf",
    // deno-lint-ignore require-await
    enabled: async ({ denops }) =>
      denops.meta.host === "nvim" && !pluginStatus.vscode,
  },
  {
    url: "tzachar/highlight-undo.nvim",
    // deno-lint-ignore require-await
    enabled: async ({ denops }) => denops.meta.host === "nvim",
    after: async ({ denops }) => {
      await denops.call(
        `luaeval`,
        `require("highlight-undo").setup(_A.param)`,
        {
          param: {
            hlgroup: "HighlightUndo",
            duration: 500,
          },
        },
      );
    },
  },
  {
    url: "folke/edgy.nvim",
    // deno-lint-ignore require-await
    enabled: async ({ denops }) =>
      denops.meta.host === "nvim" && !pluginStatus.vscode,
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("edgy").setup(_A.param)`, {
        param: {},
      });
    },
  },
  {
    url: "lewis6991/satellite.nvim",
    // deno-lint-ignore require-await
    enabled: async ({ denops }) =>
      denops.meta.host === "nvim" && !pluginStatus.vscode,
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("satellite").setup(_A.param)`, {
        param: {},
      });
    },
  },
  {
    url: "goolord/alpha-nvim",
    enabled: false,
    cache: {
      after: `
        lua require("alpha").setup(require("alpha.themes.startify").config)
      `,
    },
  },
  {
    url: "startup-nvim/startup.nvim",
    enabled: false,
    cache: {
      after: `
        lua require("startup").setup({theme = "startify"})
      `,
    },
  },
];
