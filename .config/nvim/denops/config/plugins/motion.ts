// =============================================================================
// File        : motion.ts
// Author      : yukimemi
// Last Change : 2024/03/17 12:34:15.
// =============================================================================

import type { Plug } from "https://deno.land/x/dvpm@3.8.1/mod.ts";

import * as mapping from "https://deno.land/x/denops_std@v6.4.0/mapping/mod.ts";
import * as vars from "https://deno.land/x/denops_std@v6.4.0/variable/mod.ts";
import { pluginStatus } from "../pluginstatus.ts";

export const motion: Plug[] = [
  {
    url: "https://github.com/haya14busa/vim-edgemotion",
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
    url: "https://github.com/yuki-yano/fuzzy-motion.vim",
    before: async ({ denops }) => {
      await vars.g.set(denops, "fuzzy_motion_auto_jump", false);
      await vars.g.set(denops, "fuzzy_motion_disable_match_highlight", false);
      await vars.g.set(denops, "fuzzy_motion_matchers", ["fzf", "kensaku"]);
      await mapping.map(denops, "ss", "<cmd>FuzzyMotion<cr>", { mode: "n" });
    },
  },
  {
    url: "https://github.com/yuki-yano/zero.nvim",
    after: async ({ denops }) => {
      await denops.cmd(`lua require("zero").setup()`);
    },
  },
  {
    url: "https://github.com/Bakudankun/BackAndForward.vim",
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
  {
    url: "https://github.com/chaoren/vim-wordmotion",
    enabled: false,
  },
];
