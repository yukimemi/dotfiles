import type { Denops } from "https://deno.land/x/denops_std@v4.3.3/mod.ts";
import type { Plug } from "https://deno.land/x/dvpm@0.2.4/mod.ts";

import * as mapping from "https://deno.land/x/denops_std@v4.3.3/mapping/mod.ts";
import { execute } from "https://deno.land/x/denops_std@v4.3.3/helper/mod.ts";
import * as fn from "https://deno.land/x/denops_std@v4.3.3/function/mod.ts";

export const edit: Plug[] = [
  {
    url: "editorconfig/editorconfig-vim",
    enabled: async (denops: Denops) => !(await fn.has(denops, "nvim")),
  },
  {
    url: "monaqa/dial.nvim",
    enabled: async (denops: Denops) => await fn.has(denops, "nvim"),
    after: async (denops: Denops) => {
      await mapping.map(
        denops,
        "<c-a>",
        `<Plug>(dial-increment)`,
        { mode: "n" },
      );
      await mapping.map(
        denops,
        "<c-x>",
        `<Plug>(dial-decrement)`,
        { mode: "n" },
      );
      await mapping.map(
        denops,
        "g<c-a>",
        `g<Plug>(dial-increment)`,
        { mode: "n" },
      );
      await mapping.map(
        denops,
        "g<c-x>",
        `g<Plug>(dial-decrement)`,
        { mode: "n" },
      );
    },
  },
  {
    url: "windwp/nvim-autopairs",
    enabled: async (denops: Denops) => await fn.has(denops, "nvim"),
    after: async (denops: Denops) => {
      await execute(denops, `lua require("nvim-autopairs").setup()`);
    },
  },
  { url: "Shougo/context_filetype.vim" },
  {
    url: "uga-rosa/contextment.vim",
    before: async (denops: Denops) => {
      await mapping.map(denops, "gcc", "<Plug>(contextment)", { mode: "x" });
      await mapping.map(denops, "gcc", "<Plug>(contextment-line)", {
        mode: "n",
      });
    },
  },
];
