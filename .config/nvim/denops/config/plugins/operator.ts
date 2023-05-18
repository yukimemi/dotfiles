import type { Denops, Plug } from "../dep.ts";
import { mapping } from "../dep.ts";

export const operator: Plug[] = [
  { url: "kana/vim-operator-user" },
  { url: "machakann/vim-sandwich" },
  { url: "tyru/operator-html-escape.vim" },
  {
    url: "yuki-yano/vim-operator-replace",
    before: async (denops: Denops) => {
      await mapping.map(denops, "_", "<Plug>(operator-replace)", {
        mode: ["n", "x"],
      });
    },
  },
];
