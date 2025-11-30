// =============================================================================
// File        : motion.ts
// Author      : yukimemi
// Last Change : 2025/11/29 07:35:25.
// =============================================================================

import type { Plug } from "@yukimemi/dvpm";

import * as mapping from "@denops/std/mapping";
import * as vars from "@denops/std/variable";
import { pluginStatus } from "../pluginstatus.ts";

export const motion: Plug[] = [
  {
    url: "https://github.com/haya14busa/vim-edgemotion",
    profiles: ["minimal", "core"],
    cache: { afterFile: `~/.config/nvim/rc/after/vim-edgemotion.lua` },
  },
  {
    url: "https://github.com/yuki-yano/fuzzy-motion.vim",
    enabled: pluginStatus.fuzzymotion,
    profiles: ["minimal"],
    before: async ({ denops }) => {
      await vars.g.set(denops, "fuzzy_motion_auto_jump", false);
      await vars.g.set(denops, "fuzzy_motion_disable_match_highlight", false);
      await vars.g.set(denops, "fuzzy_motion_matchers", ["fzf", "kensaku"]);
      await mapping.map(denops, "ss", "<cmd>FuzzyMotion<cr>", { mode: "n" });
    },
  },
  {
    url: "https://github.com/folke/flash.nvim",
    enabled: pluginStatus.flash,
    profiles: ["core"],
    cache: { afterFile: `~/.config/nvim/rc/after/flash.lua` },
  },
  {
    url: "https://github.com/atusy/jab.nvim",
    enabled: pluginStatus.jab,
    profiles: ["minimal", "core"],
    dependencies: ["https://github.com/lambdalisue/vim-kensaku"],
    cache: { afterFile: `~/.config/nvim/rc/after/jab.lua` },
  },
  {
    url: "https://github.com/nekowasabi/hellshake-yano.vim",
    enabled: pluginStatus.hellshake,
    profiles: ["minimal", "core"],
    cache: { beforeFile: `~/.config/nvim/rc/before/hellshake-yano.lua` },
  },
  {
    url: "https://github.com/FluxxField/smart-motion.nvim",
    enabled: pluginStatus.smartmotion,
    afterFile: `~/.config/nvim/rc/after/smart-motion.lua`,
  },
  {
    url: "https://github.com/lambdalisue/vim-initial",
    enabled: pluginStatus.initial,
    after: async ({ denops }) => {
      await mapping.map(denops, "ss", "<cmd>Initial<cr>", { mode: "n" });
    },
  },
  {
    url: "https://github.com/yuki-yano/zero.nvim",
    profiles: ["minimal"],
    after: async ({ denops }) => {
      await denops.cmd(`lua require("zero").setup()`);
    },
  },
  {
    url: "https://github.com/Bakudankun/BackAndForward.vim",
    profiles: ["minimal", "core"],
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
    enabled: false,
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
  {
    url: "https://github.com/hrsh7th/nvim-swm",
    afterFile: "~/.config/nvim/rc/after/nvim-swim.lua",
  },
  {
    url: "https://github.com/kamecha/bimove",
    profiles: ["core"],
    cache: { beforeFile: `~/.config/nvim/rc/before/bimove.vim` },
  },
];
