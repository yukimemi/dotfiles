// =============================================================================
// File        : libs.ts
// Author      : yukimemi
// Last Change : 2023/09/02 17:02:15.
// =============================================================================

import type { Plug } from "https://deno.land/x/dvpm@3.3.2/mod.ts";

import * as autocmd from "https://deno.land/x/denops_std@v5.0.1/autocmd/mod.ts";
import * as mapping from "https://deno.land/x/denops_std@v5.0.1/mapping/mod.ts";
import { globals } from "https://deno.land/x/denops_std@v5.0.1/variable/mod.ts";
import { pluginStatus } from "../main.ts";

export const libs: Plug[] = [
  {
    url: "vim-denops/denops.vim",
    cache: {
      // deno-lint-ignore require-await
      enabled: async ({ denops }) => denops.meta.platform === "windows",
      before: `
        let g:denops_server_addr = '127.0.0.1:32123'
      `,
    },
  },
  {
    url: "vim-denops/denops-shared-server.vim",
    // deno-lint-ignore require-await
    enabled: async ({ denops }) => denops.meta.platform === "windows",
  },
  {
    url: "LunarVim/bigfile.nvim",
    // deno-lint-ignore require-await
    enabled: async ({ denops }) => denops.meta.host === "nvim",
    cache: { enabled: true },
  },
  {
    url: "tani/vim-artemis",
    // deno-lint-ignore require-await
    enabled: async ({ denops }) => denops.meta.host === "nvim" && !pluginStatus.vscode,
    cache: { enabled: true },
  },
  {
    url: "rcarriga/nvim-notify",
    // deno-lint-ignore require-await
    enabled: async ({ denops }) =>
      denops.meta.host === "nvim" && pluginStatus.nvimnotify &&
      !pluginStatus.vscode,
    cache: {
      after: `
        lua << EOB
          require("notify").setup({
            render = "compact",
            stages = "slide",
          })
          vim.notify = require("notify")
        EOB
      `,
    },
    after: async ({ denops }) => {
      await mapping.map(
        denops,
        "<leader>nc",
        `<cmd>lua require("notify").dismiss()<cr>`,
        {
          mode: "n",
        },
      );
    },
  },
  {
    url: "vigoux/notifier.nvim",
    // deno-lint-ignore require-await
    enabled: async ({ denops }) =>
      denops.meta.host === "nvim" && pluginStatus.notifier &&
      !pluginStatus.vscode,
    cache: {
      after: `
        lua << EOB
          require("notifier").setup()
          vim.notify = require("notifier")
        EOB
      `,
    },
    after: async ({ denops }) => {
      await mapping.map(
        denops,
        "<leader>nc",
        `<cmd>NotifierClear<cr>`,
        {
          mode: "n",
        },
      );
    },
  },
  {
    url: "nvim-lua/plenary.nvim",
    cache: { enabled: false },
    // deno-lint-ignore require-await
    enabled: async ({ denops }) => denops.meta.host === "nvim" && !pluginStatus.vscode,
  },
  {
    url: "MunifTanjim/nui.nvim",
    // deno-lint-ignore require-await
    enabled: async ({ denops }) => denops.meta.host === "nvim" && !pluginStatus.vscode,
  },
  {
    url: "stevearc/dressing.nvim",
    // deno-lint-ignore require-await
    enabled: async ({ denops }) => denops.meta.host === "nvim" && !pluginStatus.vscode,
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("dressing").setup(_A)`, {});
    },
  },
  {
    url: "nvim-tree/nvim-web-devicons",
    cache: { enabled: false },
    // deno-lint-ignore require-await
    enabled: async ({ denops }) => denops.meta.host === "nvim" && !pluginStatus.vscode,
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("nvim-web-devicons").setup(_A)`, {
        default: true,
      });
    },
  },
  {
    url: "folke/noice.nvim",
    // deno-lint-ignore require-await
    enabled: async ({ denops }) => denops.meta.host === "nvim" && !pluginStatus.vscode && false,
    dependencies: [
      {
        url: "MunifTanjim/nui.nvim",
        // deno-lint-ignore require-await
        enabled: async ({ denops }) => denops.meta.host === "nvim" && !pluginStatus.vscode,
      },
      {
        url: "rcarriga/nvim-notify",
        // deno-lint-ignore require-await
        enabled: async ({ denops }) => denops.meta.host === "nvim" && !pluginStatus.vscode,
      },
    ],
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("noice").setup(_A)`, {
        cmdline: {
          enabled: false,
        },
        messages: {
          enabled: false,
        },
      });
    },
  },
  { url: "kana/vim-repeat" },
  { url: "mattn/vim-findroot" },
  { url: "tyru/open-browser.vim" },
  { url: "lambdalisue/readablefold.vim" },
  { url: "lambdalisue/kensaku.vim" },
  {
    url: "ryanoasis/vim-devicons",
    // deno-lint-ignore require-await
    enabled: async ({ denops }) => denops.meta.host === "vim",
    // deno-lint-ignore require-await
    clone: async ({ denops }) => denops.meta.host === "vim",
  },
  {
    url: "folke/which-key.nvim",
    // deno-lint-ignore require-await
    enabled: async ({ denops }) => denops.meta.host === "nvim" && !pluginStatus.vscode,
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("which-key").setup()`);
    },
  },
  {
    url: "liuchengxu/vim-which-key",
    // deno-lint-ignore require-await
    enabled: async ({ denops }) => denops.meta.host === "vim",
    // deno-lint-ignore require-await
    clone: async ({ denops }) => denops.meta.host === "vim",
    after: async ({ denops }) => {
      await mapping.map(denops, "<leader>", "<cmd>WhichKey '<space>'<cr>", {
        mode: ["n", "x"],
      });
      await mapping.map(denops, "<localleader>", "<cmd>WhichKey '\\'<cr>", {
        mode: ["n", "x"],
      });
    },
  },
  {
    url: "Exafunction/codeium.vim",
    enabled: Deno.build.os !== "windows",
  },
  {
    url: "lambdalisue/vim-findent",
    // deno-lint-ignore require-await
    enabled: async ({ denops }) => denops.meta.host === "vim",
    // deno-lint-ignore require-await
    clone: async ({ denops }) => denops.meta.host === "vim",
    before: async ({ denops }) => {
      await globals.set(denops, "findent#enable_warnings", 1);
      await globals.set(denops, "findent#enable_messages", 1);
      await autocmd.group(denops, "MyFindent", (helper) => {
        helper.remove("*");
        helper.define("BufRead", "*", "Findent");
      });
    },
  },
  {
    url: "hrsh7th/nvim-dansa",
    // deno-lint-ignore require-await
    enabled: async ({ denops }) => denops.meta.host === "nvim" && !pluginStatus.vscode,
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("dansa").setup(_A)`, {
        // The offset to specify how much lines to use.
        scan_offset: 100,

        // The count for cut-off the indent candidate.
        cutoff_count: 5,

        // The settings for tab-indentation or when it cannot be guessed.
        default: {
          expandtab: true,
          space: {
            shiftwidth: 2,
          },
          tab: {
            shiftwidth: 4,
          },
        },
      });
    },
  },
  { url: "yuki-yano/dedent-yank.vim" },
];
