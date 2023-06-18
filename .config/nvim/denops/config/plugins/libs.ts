import type { Plug } from "https://deno.land/x/dvpm@1.2.1/mod.ts";

import * as autocmd from "https://deno.land/x/denops_std@v5.0.0/autocmd/mod.ts";
import * as fn from "https://deno.land/x/denops_std@v5.0.0/function/mod.ts";
import * as mapping from "https://deno.land/x/denops_std@v5.0.0/mapping/mod.ts";
import { execute } from "https://deno.land/x/denops_std@v5.0.0/helper/mod.ts";
import { globals } from "https://deno.land/x/denops_std@v5.0.0/variable/mod.ts";

export const libs: Plug[] = [
  { url: "vim-denops/denops.vim" },
  { url: "vim-denops/denops-shared-server.vim" },
  {
    url: "rcarriga/nvim-notify",
    enabled: async ({ denops }) => await fn.has(denops, "nvim"),
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("notify").setup(_A.param)`, {
        param: {
          stages: "slide",
        },
      });
      await execute(denops, `lua vim.notify = require("notify")`);
      await mapping.map(
        denops,
        "<leader>nc",
        `<cmd>lua require("notify").dismiss()<cr>`,
        {
          mode: "n",
        }
      );
    },
  },
  {
    url: "folke/noice.nvim",
    enabled: async ({ denops }) => await fn.has(denops, "nvim"),
    dependencies: [
      { url: "MunifTanjim/nui.nvim" },
      { url: "rcarriga/nvim-notify" },
    ],
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("noice").setup(_A.param)`, {
        param: {
          cmdline: {
            enabled: false,
          },
          messages: {
            enabled: false,
          },
        },
      });
    },
  },
  { url: "kana/vim-repeat" },
  { url: "mattn/vim-findroot" },
  { url: "tyru/open-browser.vim" },
  { url: "lambdalisue/readablefold.vim" },
  { url: "lambdalisue/kensaku.vim" },
  { url: "tani/vim-artemis" },
  {
    url: "MunifTanjim/nui.nvim",
    enabled: async ({ denops }) => await fn.has(denops, "nvim"),
  },
  {
    url: "nvim-lua/plenary.nvim",
    enabled: async ({ denops }) => await fn.has(denops, "nvim"),
  },
  {
    url: "nvim-tree/nvim-web-devicons",
    enabled: async ({ denops }) => await fn.has(denops, "nvim"),
    after: async ({ denops }) => {
      await denops.call(
        `luaeval`,
        `require("nvim-web-devicons").setup(_A.param)`,
        {
          param: {
            default: true,
          },
        }
      );
    },
  },
  {
    url: "ryanoasis/vim-devicons",
    enabled: async ({ denops }) => !(await fn.has(denops, "nvim")),
  },
  {
    url: "folke/which-key.nvim",
    enabled: async ({ denops }) => await fn.has(denops, "nvim"),
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("which-key").setup()`);
    },
  },
  {
    url: "liuchengxu/vim-which-key",
    enabled: async ({ denops }) => !(await fn.has(denops, "nvim")),
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
    enabled: async ({ denops }) => !(await fn.has(denops, "nvim")),
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
    enabled: async ({ denops }) => await fn.has(denops, "nvim"),
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("dansa").setup(_A.param)`, {
        param: {
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
        },
      });
    },
  },
];
