import type { Denops } from "https://deno.land/x/denops_std@v5.0.0/mod.ts";
import type { Plug } from "https://deno.land/x/dvpm@0.3.7/mod.ts";

import * as fn from "https://deno.land/x/denops_std@v5.0.0/function/mod.ts";
import * as mapping from "https://deno.land/x/denops_std@v5.0.0/mapping/mod.ts";
import { execute } from "https://deno.land/x/denops_std@v5.0.0/helper/mod.ts";

import { pluginStatus } from "../main.ts";

export const edit: Plug[] = [
  {
    url: "editorconfig/editorconfig-vim",
    enabled: async (denops: Denops) => !(await fn.has(denops, "nvim")),
  },
  {
    url: "monaqa/dial.nvim",
    enabled: async (denops: Denops) => await fn.has(denops, "nvim"),
    after: async (denops: Denops) => {
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
    enabled: async (denops: Denops) =>
      await fn.has(denops, "nvim") && pluginStatus.autopairs,
    after: async (denops: Denops) => {
      await execute(denops, `lua require("nvim-autopairs").setup()`);
    },
  },
  {
    url: "hrsh7th/nvim-insx",
    enabled: async (denops: Denops) =>
      await fn.has(denops, "nvim") && pluginStatus.insx,
    after: async (denops: Denops) => {
      await denops.cmd(`lua require('insx.preset.standard').setup()`);
    },
  },
  {
    url: "uga-rosa/contextment.vim",
    dependencies: [{ url: "Shougo/context_filetype.vim" }],
    before: async (denops: Denops) => {
      await mapping.map(denops, "gcc", "<Plug>(contextment)", { mode: "x" });
      await mapping.map(denops, "gcc", "<Plug>(contextment-line)", {
        mode: "n",
      });
    },
  },
  {
    url: "gbprod/yanky.nvim",
    enabled: async (denops: Denops) => await fn.has(denops, "nvim"),
    after: async (denops: Denops) => {
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
  { url: "thinca/vim-qfreplace" },
  { url: "itchyny/vim-qfedit" },
];
