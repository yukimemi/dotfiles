import * as mapping from "https://deno.land/x/denops_std@v4.3.3/mapping/mod.ts";
import { globals } from "https://deno.land/x/denops_std@v4.3.3/variable/mod.ts";
import { Denops } from "https://deno.land/x/denops_std@v4.3.3/mod.ts";
import { type Plug } from "https://deno.land/x/dvpm@0.1.1/mod.ts";

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
];
