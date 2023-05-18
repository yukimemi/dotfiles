import type { Denops, Plug } from "../dep.ts";
import { expand, globals, mapping } from "../dep.ts";

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
