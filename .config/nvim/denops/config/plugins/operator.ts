import { Plugin } from "./types.ts";

export const operator: Plugin[] = [
  { org: "kana", repo: "vim-operator-user" },
  { org: "machakann", repo: "vim-sandwich" },
  { org: "tyru", repo: "operator-html-escape.vim" },
  {
    org: "yuki-yano",
    repo: "vim-operator-replace",
    lua_post: `
      vim.keymap.set({"n", "x"}, "_", "<Plug>(operator-replace)")
    `,
  },
];
