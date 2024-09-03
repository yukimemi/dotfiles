// =============================================================================
// File        : motion.ts
// Author      : yukimemi
// Last Change : 2024/09/01 22:26:58.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@4.0.2";

import * as mapping from "jsr:@denops/std@7.1.1/mapping";
import * as vars from "jsr:@denops/std@7.1.1/variable";
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
    enabled: !pluginStatus.vscode && true,
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
    url: "https://github.com/thinca/vim-poslist",
    enabled: !pluginStatus.vscode && false,
    before: async ({ denops }) => {
      await mapping.map(denops, "<c-o>", "<Plug>(poslist-prev-pos)", {
        mode: ["n", "x"],
      });
      await mapping.map(denops, "<c-i>", "<Plug>(poslist-next-pos)", {
        mode: ["n", "x"],
      });
      await mapping.map(denops, "gH", "<Plug>(poslist-prev-buf)", {
        mode: "n",
      });
      await mapping.map(denops, "gL", "<Plug>(poslist-next-buf)", {
        mode: "n",
      });
    },
  },
  {
    url: "https://github.com/chaoren/vim-wordmotion",
    enabled: false,
  },
  {
    url: "https://github.com/psliwka/vim-smoothie",
    enabled: false,
  },
  {
    url: "https://github.com/declancm/cinnamon.nvim",
    enabled: false,
    afterFile: "~/.config/nvim/rc/after/cinnamon.lua",
  },
  {
    url: "https://github.com/karb94/neoscroll.nvim",
    enabled: false,
    afterFile: "~/.config/nvim/rc/after/neoscroll.lua",
  },
];
