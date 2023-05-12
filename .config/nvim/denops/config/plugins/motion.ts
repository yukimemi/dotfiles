import { Plugin } from "./types.ts";

export const motion: Plugin[] = [
  {
    org: "haya14busa",
    repo: "vim-edgemotion",
    lua_post: `
      vim.keymap.set({"n", "x"}, "sj", "<Plug>(edgemotion-j)")
      vim.keymap.set({"n", "x"}, "sk", "<Plug>(edgemotion-k)")
    `
  },
]
