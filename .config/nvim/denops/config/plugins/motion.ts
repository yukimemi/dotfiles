// =============================================================================
// File        : motion.ts
// Author      : yukimemi
// Last Change : 2023/07/16 00:38:09.
// =============================================================================

import type { Plug } from "https://deno.land/x/dvpm@2.4.2/mod.ts";

import * as mapping from "https://deno.land/x/denops_std@v5.0.1/mapping/mod.ts";
import { globals } from "https://deno.land/x/denops_std@v5.0.1/variable/mod.ts";
import { pluginStatus } from "../main.ts";

export const motion: Plug[] = [
  {
    url: "haya14busa/vim-edgemotion",
    before: async ({ denops }) => {
      await mapping.map(denops, "sj", "<Plug>(edgemotion-j)", {
        mode: ["n", "x"],
      });
      await mapping.map(denops, "sk", "<Plug>(edgemotion-k)", {
        mode: ["n", "x"],
      });
    },
  },
  {
    url: "yuki-yano/fuzzy-motion.vim",
    before: async ({ denops }) => {
      await globals.set(denops, "fuzzy_motion_auto_jump", false);
      await globals.set(denops, "fuzzy_motion_disable_match_highlight", false);
      await globals.set(denops, "fuzzy_motion_matchers", ["fzf", "kensaku"]);
      await mapping.map(denops, "ss", "<cmd>FuzzyMotion<cr>", { mode: "n" });
    },
  },
  {
    url: "yuki-yano/zero.nvim",
    // deno-lint-ignore require-await
    enabled: async ({ denops }) => denops.meta.host === "nvim",
    after: async ({ denops }) => {
      await denops.cmd(`lua require("zero").setup()`);
    },
  },
  {
    url: "Bakudankun/BackAndForward.vim",
    enabled: !pluginStatus.vscode,
    before: async ({ denops }) => {
      await mapping.map(denops, "gH", "<Plug>(backandforward-back)", {
        mode: "n",
      });
      await mapping.map(denops, "gL", "<Plug>(backandforward-forward)", {
        mode: "n",
      });
    },
  },
];
