// =============================================================================
// File        : window.ts
// Author      : yukimemi
// Last Change : 2026/01/24 20:37:26.
// =============================================================================

import type { Plug } from "@yukimemi/dvpm";
import * as mapping from "@denops/std/mapping";
import * as vars from "@denops/std/variable";
import * as fn from "@denops/std/function";
import { pluginStatus } from "../pluginstatus.ts";

export const window: Plug[] = [
  {
    url: "https://github.com/anuvyklack/middleclass",
    enabled: pluginStatus.windows,
    profiles: ["window"],
  },
  {
    url: "https://github.com/anuvyklack/animation.nvim",
    enabled: pluginStatus.windows,
    profiles: ["window"],
  },
  {
    url: "https://github.com/anuvyklack/windows.nvim",
    enabled: pluginStatus.windows,
    profiles: ["window"],
    dependencies: [
      "https://github.com/anuvyklack/middleclass",
      "https://github.com/anuvyklack/animation.nvim",
    ],
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("windows").setup(_A)`, {
        autowidth: {
          enable: true,
          winwidth: 5,
          filetype: {
            help: 2,
          },
        },
        ignore: {
          buftype: ["quickfix"],
          filetype: [
            "NvimTree",
            "TelescopePrompt",
            "aerial",
            "coc-explorer",
            "ctrlp",
            "ddu",
            "ddu-ff",
            "ddu-ff-filter",
            "ddu-filer",
            "gundo",
            "list",
            "neo-tree",
            "qf",
            "quickfix",
            "scanwalker",
            "scanwalker-filter",
            "undotree",
            "fall-input",
            "fall-list",
            "fall-help",
            "deck",
          ],
        },
        animation: {
          enable: true,
          duration: 300,
          fps: 30,
          easing: "in_out_sine",
        },
      });
      await mapping.map(denops, "sz", "<cmd>WindowsMaximize<cr>", {
        mode: "n",
      });
      await mapping.map(denops, "s_", "<cmd>WindowsMaximizeVertically<cr>", {
        mode: "n",
      });
      await mapping.map(
        denops,
        "s\\|",
        "<cmd>WindowsMaximizeHorizontally<cr>",
        {
          mode: "n",
        },
      );
      await mapping.map(denops, "s=", "<cmd>WindowsEqualize<cr>", {
        mode: "n",
      });
    },
  },
  {
    url: "https://github.com/simeji/winresizer",
    profiles: ["window"],
    before: async ({ denops }) => {
      await vars.g.set(denops, "winresizer_gui_enable", 0);
    },
  },
  {
    url: "https://github.com/tenxsoydev/size-matters.nvim",
    enabled: async ({ denops }) =>
      (await fn.exists(denops, "g:neovide")) ||
      (await fn.exists(denops, ":GuiFont")),
    profiles: ["window"],
    afterFile: "~/.config/nvim/rc/after/size-matters.lua",
  },
  {
    url: "https://github.com/thinca/vim-winenv",
    enabled: Deno.build.os === "windows",
    profiles: ["window"],
  },
  {
    url: "https://github.com/lkzz/golden-ratio.nvim",
    enabled: false,
    profiles: ["window"],
    lazy: {
      event: ["WinEnter", "VimResized", "BufWinEnter"],
    },
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("golden-ratio").setup(_A)`, {
        exclude_buffer_patterns: [
          "aiboconsole://*",
          "aiboprompt://*",
          "deck://*",
        ],
        exclude_filetypes: ["deck"],
      });
      await denops.call(`luaeval`, `require("golden-ratio").enable()`);
    },
  },
  {
    url: "https://github.com/4513ECHO/vim-snipewin",
    enabled: pluginStatus.snipewin,
    profiles: ["window"],
    lazy: {
      keys: [
        { lhs: "sw", rhs: "<Plug>(snipewin)", mode: "n" },
      ],
    },
  },
  {
    url: "https://github.com/s1n7ax/nvim-window-picker",
    enabled: pluginStatus.windowpicker,
    profiles: ["window"],
    lazy: {
      keys: [
        {
          lhs: "sw",
          rhs: "<cmd>lua require('window-picker').pick_window()<cr>",
          mode: "n",
        },
      ],
    },
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("window-picker").setup(_A)`, {
        hint: "floating-big-letter",
      });
    },
  },
  {
    url: "https://github.com/nvim-zh/colorful-winsep.nvim",
    profiles: ["window"],
    lazy: {
      event: ["WinNew", "WinEnter"],
    },
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("colorful-winsep").setup()`);
    },
  },
  {
    url: "https://github.com/tamton-aquib/flirt.nvim",
    enabled: Deno.build.os !== "windows" && false,
    profiles: ["window"],
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("flirt").setup()`);
    },
  },
];
