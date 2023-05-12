import { Plugin } from "./types.ts";

export const libs: Plugin[] = [
  { org: "vim-denops", repo: "denops.vim" },
  { org: "lambdalisue", repo: "kensaku.vim" },
  { org: "MunifTanjim", repo: "nui.nvim" },
  { org: "nvim-lua", repo: "plenary.nvim" },
  {
    org: "nvim-tree",
    repo: "nvim-web-devicons",
    lua_post: `require("nvim-web-devicons").setup({ default = true })`,
  },
];
