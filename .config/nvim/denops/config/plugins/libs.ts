import { Plugin } from "./types.ts";

export const libs: Plugin[] = [
  { org: "vim-denops", repo: "denops.vim" },
  { org: "lambdalisue", repo: "kensaku.vim" },
  { org: "MunifTanjim", repo: "nui.nvim" },
  { org: "tani", repo: "vim-artemis" },
  { org: "nvim-lua", repo: "plenary.nvim" },
  {
    org: "nvim-tree",
    repo: "nvim-web-devicons",
    lua_post: `require("nvim-web-devicons").setup({ default = true })`,
  },
  {
    org: "Exafunction",
    repo: "codeium.vim",
    enabled: false,
    lua_post: `
      vim.keymap.set("i", "<C-e>", function()
        return vim.fn["codeium#Accept"]()
      end, { expr = true, nowait = true })
      vim.keymap.set("i", "<c-;>", function()
        return vim.fn["codeium#CycleCompletions"](1)
      end, { expr = true })
      vim.keymap.set("i", "<c-,>", function()
        return vim.fn["codeium#CycleCompletions"](-1)
      end, { expr = true })
      vim.keymap.set("i", "<c-x>", function()
        return vim.fn["codeium#Clear"]()
      end, { expr = true })
    `,
  },
];
