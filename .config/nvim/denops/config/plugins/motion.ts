import type { Plug } from "https://deno.land/x/dvpm@1.3.1/mod.ts";

import * as fn from "https://deno.land/x/denops_std@v5.0.1/function/mod.ts";
import * as mapping from "https://deno.land/x/denops_std@v5.0.1/mapping/mod.ts";
import { globals } from "https://deno.land/x/denops_std@v5.0.1/variable/mod.ts";

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
    enabled: async ({ denops }) => await fn.has(denops, "nvim"),
    after: async ({ denops }) => {
      await denops.cmd(`lua require("zero").setup()`);
    },
  },
  {
    url: "Bakudankun/BackAndForward.vim",
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
