import { Plugin } from "./types.ts";

export const git: Plugin[] = [
  {
    org: "lewis6991",
    repo: "gitsigns.nvim",
    lua_post: `require("gitsigns").setup()`,
  },
  { org: "lambdalisue", repo: "askpass.vim" },
  { org: "lambdalisue", repo: "guise.vim" },
  {
    org: "lambdalisue",
    repo: "gin.vim",
    lua_pre: `
      vim.keymap.set("n", "<space>gs", "<cmd>GinStatus<cr>")
      vim.keymap.set("n", "<space>gc", "<cmd>Gin commit -v<cr>")
      vim.keymap.set("n", "<space>gb", "<cmd>GinBranch<cr>")
      vim.keymap.set("n", "<space>gg", "<cmd>Gin grep<cr>")
      vim.keymap.set("n", "<space>gd", "<cmd>GinDiff<cr>")
      vim.keymap.set("n", "<space>gl", "<cmd>GinLog<cr>")
      vim.keymap.set("n", "<space>gL", "<cmd>GinLog -p %<cr>")
      vim.keymap.set("n", "<space>gp", "<cmd>Gin push<cr>")
    `,
  },
];
