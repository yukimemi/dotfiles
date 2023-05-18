import type { Denops, Plug } from "../dep.ts";
import { execute, has, mapping } from "../dep.ts";

export const edit: Plug[] = [
  {
    url: "editorconfig/editorconfig-vim",
    enabled: async (denops: Denops) => !(await has(denops, "nvim")),
  },
  {
    url: "monaqa/dial.nvim",
    after: async (denops: Denops) => {
      await mapping.map(
        denops,
        "<c-a>",
        '<cmd>lua require("dial.map").inc_normal()<cr>',
        { mode: "n" },
      );
      await mapping.map(
        denops,
        "<c-x>",
        '<cmd>lua require("dial.map").dec_normal()<cr>',
        { mode: "n" },
      );
    },
  },
  {
    url: "windwp/nvim-autopairs",
    enabled: async (denops: Denops) => (await has(denops, "nvim")),
    after: async (denops: Denops) => {
      await execute(denops, `lua require("nvim-autopairs").setup()`);
    },
  },
  { url: "Shougo/context_filetype.vim" },
  {
    url: "uga-rosa/contextment.vim",
    before: async (denops: Denops) => {
      await mapping.map(denops, "gcc", "<Plug>(contextment)", { mode: "x" });
      await mapping.map(denops, "gcc", "<Plug>(contextment-line)", {
        mode: "n",
      });
    },
  },
];
