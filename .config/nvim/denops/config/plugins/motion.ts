import type { Denops, Plug } from "../dep.ts";
import { globals, mapping } from "../dep.ts";

export const motion: Plug[] = [
  {
    url: "haya14busa/vim-edgemotion",
    before: async (denops: Denops) => {
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
    before: async (denops: Denops) => {
      await globals.set(denops, "fuzzy_motion_auto_jump", false);
      await globals.set(denops, "fuzzy_motion_disable_match_highlight", false);
      await globals.set(denops, "fuzzy_motion_matchers", ["fzf", "kensaku"]);
      await mapping.map(denops, "ss", "<cmd>FuzzyMotion<cr>", { mode: "n" });
    },
  },
  {
    url: "Bakudankun/BackAndForward.vim",
    before: async (denops: Denops) => {
      await mapping.map(denops, "gH", "<Plug>(backandforward-back)", {
        mode: "n",
      });
      await mapping.map(denops, "gL", "<Plug>(backandforward-forward)", {
        mode: "n",
      });
    },
  },
];
