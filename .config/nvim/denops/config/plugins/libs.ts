import { Denops } from "https://deno.land/x/denops_std@v4.3.3/mod.ts";
import { execute } from "https://deno.land/x/denops_std@v4.3.3/helper/mod.ts";
import { type Plug } from "https://deno.land/x/dvpm@0.1.1/mod.ts";

export const libs: Plug[] = [
  { url: "vim-denops/denops.vim" },
  { url: "lambdalisue/kensaku.vim" },
  { url: "MunifTanjim/nui.nvim" },
  { url: "tani/vim-artemis" },
  { url: "nvim-lua/plenary.nvim" },
  {
    url: "nvim-tree/nvim-web-devicons",
    after: async (denops: Denops) => {
      await execute(
        denops,
        `
lua require("nvim-web-devicons").setup({ default = true })
        `,
      );
    },
  },
  {
    url: "Exafunction/codeium.vim",
    enabled: false,
    after: async (denops: Denops) => {
      await execute(
        denops,
        `
lua << EOF
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
EOF
    `,
      );
    },
  },
];
