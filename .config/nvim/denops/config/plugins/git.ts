import type { Denops } from "https://deno.land/x/denops_std@v4.3.3/mod.ts";
import type { Plug } from "https://deno.land/x/dvpm@0.1.1/mod.ts";

import * as mapping from "https://deno.land/x/denops_std@v4.3.3/mapping/mod.ts";
import { execute } from "https://deno.land/x/denops_std@v4.3.3/helper/mod.ts";
import { has } from "https://deno.land/x/denops_std@v4.3.3/function/mod.ts";

export const git: Plug[] = [
  {
    url: "lewis6991/gitsigns.nvim",
    enabled: async (denops: Denops) => (await has(denops, "nvim")),
    after: async (denops: Denops) => {
      await execute(denops, `lua require("gitsigns").setup()`);
    },
  },
  { url: "lambdalisue/askpass.vim" },
  { url: "lambdalisue/guise.vim" },
  {
    url: "lambdalisue/gin.vim",
    before: async (denops: Denops) => {
      await mapping.map(denops, "<space>gs", "<cmd>GinStatus<cr>", {
        mode: "n",
      });
      await mapping.map(denops, "<space>gc", "<cmd>Gin commit -v<cr>", {
        mode: "n",
      });
      await mapping.map(denops, "<space>gb", "<cmd>GinBranch<cr>", {
        mode: "n",
      });
      await mapping.map(denops, "<space>gg", "<cmd>Gin grep<cr>", {
        mode: "n",
      });
      await mapping.map(denops, "<space>gd", "<cmd>GinDiff<cr>", { mode: "n" });
      await mapping.map(denops, "<space>gl", "<cmd>GinLog<cr>", { mode: "n" });
      await mapping.map(denops, "<space>gL", "<cmd>GinLog -p %<cr>", {
        mode: "n",
      });
      await mapping.map(denops, "<space>gp", "<cmd>Gin push<cr>", {
        mode: "n",
      });
    },
  },
];
