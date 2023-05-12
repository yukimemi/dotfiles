import { Plugin } from "./types.ts";

export const util: Plugin[] = [
  {
    org: "thinca",
    repo: "vim-partedit",
    lua_pre: `
      vim.g["partedit#opener"] = "vsplit"
    `,
  },
];
