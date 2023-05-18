import type { Denops, Plug } from "../dep.ts";
import { autocmd, execute, globals, has, mapping } from "../dep.ts";

export const libs: Plug[] = [
  { url: "vim-denops/denops.vim" },
  { url: "kana/vim-repeat" },
  { url: "lambdalisue/kensaku.vim" },
  {
    url: "MunifTanjim/nui.nvim",
    enabled: async (denops: Denops) => (await has(denops, "nvim")),
  },
  { url: "tani/vim-artemis" },
  {
    url: "nvim-lua/plenary.nvim",
    enabled: async (denops: Denops) => (await has(denops, "nvim")),
  },
  {
    url: "rcarriga/nvim-notify",
    enabled: async (denops: Denops) => (await has(denops, "nvim")),
    after: async (denops: Denops) => {
      await execute(
        denops,
        `
lua << EOB
      local notify = require("notify")
      notify.setup({
        stages = "slide",
      })
      vim.notify = notify
EOB
    `,
      );
    },
  },
  {
    url: "nvim-tree/nvim-web-devicons",
    enabled: async (denops: Denops) => (await has(denops, "nvim")),
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
  {
    url: "lambdalisue/vim-findent",
    before: async (denops: Denops) => {
      await globals.set(denops, "findent#enable_warnings", 1);
      await globals.set(denops, "findent#enable_messages", 1);
      await autocmd.group(denops, "MyFindent", (helper) => {
        helper.remove("*");
        helper.define("BufRead", "*", "Findent!");
      });
    },
  },
];
