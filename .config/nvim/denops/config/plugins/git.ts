import type { Plug } from "https://deno.land/x/dvpm@2.4.0/mod.ts";

import * as mapping from "https://deno.land/x/denops_std@v5.0.1/mapping/mod.ts";
import { execute } from "https://deno.land/x/denops_std@v5.0.1/helper/mod.ts";
import { pluginStatus } from "../main.ts";

export const git: Plug[] = [
  {
    url: "lewis6991/gitsigns.nvim",
    // deno-lint-ignore require-await
    enabled: async ({ denops }) =>
      denops.meta.host === "nvim" && !pluginStatus.vscode,
    after: async ({ denops }) => {
      await execute(denops, `lua require("gitsigns").setup()`);
      await mapping.map(
        denops,
        "]g",
        `<cmd>lua require("gitsigns").next_hunk()<cr>`,
        {
          mode: "n",
        },
      );
      await mapping.map(
        denops,
        "[g",
        `<cmd>lua require("gitsigns").prev_hunk()<cr>`,
        {
          mode: "n",
        },
      );
    },
  },
  {
    url: "lambdalisue/gin.vim",
    enabled: !pluginStatus.vscode,
    dependencies: [
      { url: "lambdalisue/askpass.vim" },
      { url: "lambdalisue/guise.vim" },
    ],
    before: async ({ denops }) => {
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
      await mapping.map(denops, "<space>gL", "<cmd>GinLog -p -- %<cr>", {
        mode: "n",
      });
      await mapping.map(denops, "<space>gp", "<cmd>Gin push<cr>", {
        mode: "n",
      });
    },
  },
];
