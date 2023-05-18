import type { Denops } from "https://deno.land/x/denops_std@v4.3.3/mod.ts";
import type { Plug } from "https://deno.land/x/dvpm@0.1.2/mod.ts";

import * as mapping from "https://deno.land/x/denops_std@v4.3.3/mapping/mod.ts";
import { globals } from "https://deno.land/x/denops_std@v4.3.3/variable/mod.ts";
import { expand } from "https://deno.land/x/denops_std@v4.3.3/function/mod.ts";

export const util: Plug[] = [
  {
    url: "thinca/vim-partedit",
    before: async (denops: Denops) => {
      await globals.set(denops, "partedit#opener", "vsplit");
    },
  },
  { url: "tyru/capture.vim" },
  {
    url: "glidenote/memolist.vim",
    before: async (denops: Denops) => {
      await globals.set(
        denops,
        "memolist_path",
        await expand(denops, "~/.memolist"),
      );
      await globals.set(denops, "memolist_memo_suffix", "md");
      await globals.set(denops, "memolist_prompt_tags", 1);

      await mapping.map(denops, "<leader>mn", "<cmd>MemoNew<cr>", {
        mode: "n",
      });
      await mapping.map(denops, "<leader>ml", "<cmd>MemoList<cr>", {
        mode: "n",
      });
    },
  },
];
