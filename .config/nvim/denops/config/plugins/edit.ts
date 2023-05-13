import { Plugin } from "./types.ts";

export const edit: Plugin[] = [
  { org: "Shougo", repo: "context_filetype.vim" },
  {
    org: "uga-rosa",
    repo: "contextment.vim",
    lua_pre: `
      vim.keymap.set("x", "gcc", "<Plug>(contextment)")
      vim.keymap.set("n", "gcc", "<Plug>(contextment-line)")
    `,
  },
];
