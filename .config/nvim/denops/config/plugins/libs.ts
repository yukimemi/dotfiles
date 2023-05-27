import type { Denops } from "https://deno.land/x/denops_std@v5.0.0/mod.ts";
import type { Plug } from "https://deno.land/x/dvpm@0.3.6/mod.ts";

import * as autocmd from "https://deno.land/x/denops_std@v5.0.0/autocmd/mod.ts";
import * as fn from "https://deno.land/x/denops_std@v5.0.0/function/mod.ts";
import * as mapping from "https://deno.land/x/denops_std@v5.0.0/mapping/mod.ts";
import { execute } from "https://deno.land/x/denops_std@v5.0.0/helper/mod.ts";
import { globals } from "https://deno.land/x/denops_std@v5.0.0/variable/mod.ts";

export const libs: Plug[] = [
  { url: "vim-denops/denops.vim" },
  { url: "kana/vim-repeat" },
  { url: "mattn/vim-findroot" },
  { url: "tyru/open-browser.vim" },
  { url: "lambdalisue/kensaku.vim" },
  { url: "tani/vim-artemis" },
  {
    url: "MunifTanjim/nui.nvim",
    enabled: async (denops: Denops) => await fn.has(denops, "nvim"),
  },
  {
    url: "nvim-lua/plenary.nvim",
    enabled: async (denops: Denops) => await fn.has(denops, "nvim"),
  },
  {
    url: "rcarriga/nvim-notify",
    enabled: async (denops: Denops) => await fn.has(denops, "nvim"),
    after: async (denops: Denops) => {
      await denops.call(
        `luaeval`,
        `require("notify").setup(_A.param)`,
        {
          param: {
            stages: "slide",
          },
        },
      );
      await execute(denops, `lua vim.notify = require("notify")`);
    },
  },
  {
    url: "nvim-tree/nvim-web-devicons",
    enabled: async (denops: Denops) => await fn.has(denops, "nvim"),
    after: async (denops: Denops) => {
      await denops.call(
        `luaeval`,
        `require("nvim-web-devicons").setup(_A.param)`,
        {
          param: {
            default: true,
          },
        },
      );
    },
  },
  {
    url: "ryanoasis/vim-devicons",
    enabled: async (denops: Denops) => !(await fn.has(denops, "nvim")),
  },
  {
    url: "folke/which-key.nvim",
    enabled: async (denops: Denops) => await fn.has(denops, "nvim"),
    after: async (denops: Denops) => {
      await denops.call(`luaeval`, `require("which-key").setup()`);
    },
  },
  {
    url: "liuchengxu/vim-which-key",
    enabled: async (denops: Denops) => !(await fn.has(denops, "nvim")),
    after: async (denops: Denops) => {
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
    enabled: false,
    after: async (denops: Denops) => {
      await execute(
        denops,
        `
        lua << EOB
          vim.keymap.set("i", "<C-e>", function()
            return vim.fn["codeium#Accept"]()
          end, { expr = true, nowait = true })
          vim.keymap.set("i", "<c-;>", function()
            return vim.fn["codeium#CycleCompletions"](1)
          end, { expr = true })
          vim.keymap.set("i", "<c-,>", function()
            return vim.fn["codeium#CycleCompletions"](-1)
          end, { expr = true })
          vim.keymap.set("i", "<c-x>", function()
            return vim.fn["codeium#Clear"]()
          end, { expr = true })
        EOB
    `,
      );
    },
  },
  {
    url: "lambdalisue/vim-findent",
    enabled: async (denops: Denops) => !(await fn.has(denops, "nvim")),
    before: async (denops: Denops) => {
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
    enabled: async (denops: Denops) => await fn.has(denops, "nvim"),
    after: async (denops: Denops) => {
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
