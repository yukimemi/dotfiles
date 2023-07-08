import type { Plug } from "https://deno.land/x/dvpm@2.3.0/mod.ts";

import * as autocmd from "https://deno.land/x/denops_std@v5.0.1/autocmd/mod.ts";
import * as fn from "https://deno.land/x/denops_std@v5.0.1/function/mod.ts";
import * as vars from "https://deno.land/x/denops_std@v5.0.1/variable/mod.ts";
import * as mapping from "https://deno.land/x/denops_std@v5.0.1/mapping/mod.ts";
import { execute } from "https://deno.land/x/denops_std@v5.0.1/helper/mod.ts";

import { pluginStatus } from "../main.ts";

export const edit: Plug[] = [
  {
    url: "editorconfig/editorconfig-vim",
    enabled: async ({ denops }) => !(await fn.has(denops, "nvim")),
  },
  {
    url: "monaqa/dial.nvim",
    enabled: async ({ denops }) => await fn.has(denops, "nvim"),
    after: async ({ denops }) => {
      await mapping.map(denops, "<c-a>", `<Plug>(dial-increment)`, {
        mode: "n",
      });
      await mapping.map(denops, "<c-x>", `<Plug>(dial-decrement)`, {
        mode: "n",
      });
      await mapping.map(denops, "g<c-a>", `g<Plug>(dial-increment)`, {
        mode: "n",
      });
      await mapping.map(denops, "g<c-x>", `g<Plug>(dial-decrement)`, {
        mode: "n",
      });
    },
  },
  {
    url: "windwp/nvim-autopairs",
    enabled: async ({ denops }) => await fn.has(denops, "nvim") && pluginStatus.autopairs,
    after: async ({ denops }) => {
      await execute(denops, `lua require("nvim-autopairs").setup()`);
    },
  },
  {
    url: "hrsh7th/nvim-insx",
    enabled: async ({ denops }) => await fn.has(denops, "nvim") && pluginStatus.insx,
    after: async ({ denops }) => {
      await denops.cmd(`lua require('insx.preset.standard').setup()`);
    },
  },
  {
    url: "uga-rosa/contextment.vim",
    dependencies: [{ url: "Shougo/context_filetype.vim" }],
    before: async ({ denops }) => {
      await mapping.map(denops, "gcc", "<Plug>(contextment)", { mode: "x" });
      await mapping.map(denops, "gcc", "<Plug>(contextment-line)", {
        mode: "n",
      });
    },
  },
  {
    url: "gbprod/yanky.nvim",
    enabled: async ({ denops }) => await fn.has(denops, "nvim") && pluginStatus.yanky,
    after: async ({ denops }) => {
      await mapping.map(denops, "p", "<Plug>(YankyPutAfter)", {
        mode: ["n", "x"],
      });
      await mapping.map(denops, "P", "<Plug>(YankyPutBefore)", {
        mode: ["n", "x"],
      });
      await mapping.map(denops, "gp", "<Plug>(YankyGPutAfter)", {
        mode: ["n", "x"],
      });
      await mapping.map(denops, "gP", "<Plug>(YankyGPutBefore)", {
        mode: ["n", "x"],
      });
      await mapping.map(denops, "<c-n>", "<Plug>(YankyCycleForward)", {
        mode: "n",
      });
      await mapping.map(denops, "<c-p>", "<Plug>(YankyCycleBackward)", {
        mode: "n",
      });
      await denops.call(`luaeval`, `require("yanky").setup(_A.param)`, {
        param: {
          ring: {
            history_length: 300,
            storage: "shada",
            sync_with_numbered_registers: true,
            cancel_event: "update",
          },
          system_clipboard: {
            sync_with_ring: true,
          },
        },
      });
    },
  },
  {
    url: "LeafCage/yankround.vim",
    enabled: pluginStatus.yankround,
    after: async ({ denops }) => {
      await vars.g.set(denops, "yankround_max_history", 10000);
      await vars.g.set(denops, "yankround_use_region_hl", 1);
      await vars.g.set(
        denops,
        "yankround_dir",
        await fn.expand(denops, "~/.cache/yankround"),
      );

      await mapping.map(denops, "p", "<Plug>(yankround-p)", {
        mode: ["n", "x"],
      });
      await mapping.map(denops, "P", "<Plug>(yankround-P)", { mode: "n" });

      await mapping.map(
        denops,
        "<c-n>",
        `yankround#is_active() ? "<Plug>(yankround-prev)" : "gt"`,
        { mode: "n", expr: true },
      );
      await mapping.map(
        denops,
        "<c-p>",
        `yankround#is_active() ? "<Plug>(yankround-prev)" : "gT"`,
        { mode: "n", expr: true },
      );
    },
  },
  { url: "thinca/vim-qfreplace" },
  { url: "itchyny/vim-qfedit" },
  {
    url: "tani/vim-typo",
    enabled: false,
    before: async ({ denops }) => {
      await autocmd.group(denops, "MyTypoSettings", (helper) => {
        helper.remove("*");
        helper.define(
          "FileType",
          [
            "ctrlp",
            "ddu-ff",
            "ddu-ff-filter",
            "ddu-filer",
            "dpswalk",
            "dpswalk-filter",
            "list",
            "qf",
            "quickfix",
          ],
          `let b:typo_did_setup = 1`,
        );
      });
    },
  },
];
