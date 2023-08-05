// =============================================================================
// File        : treesitter.ts
// Author      : yukimemi
// Last Change : 2023/07/16 00:38:47.
// =============================================================================

import type { Plug } from "https://deno.land/x/dvpm@3.0.0/mod.ts";

import * as mapping from "https://deno.land/x/denops_std@v5.0.1/mapping/mod.ts";
import { execute } from "https://deno.land/x/denops_std@v5.0.1/helper/mod.ts";
import { pluginStatus } from "../main.ts";

export const treesitter: Plug[] = [
  {
    url: "nvim-treesitter/nvim-treesitter",
    // deno-lint-ignore require-await
    enabled: async ({ denops }) => denops.meta.host === "nvim" && !pluginStatus.vscode,
    after: async ({ denops }) => {
      await execute(
        denops,
        `
        lua << EOB
          require("nvim-treesitter.configs").setup({
            sync_install = false,
            highlight = {
              enable = true,
              additional_vim_regex_highlighting = false,
              disable = function(lang)
                local byte_size = vim.api.nvim_buf_get_offset(0, vim.api.nvim_buf_line_count(0))
                if byte_size > 1024 * 1024 then return true end
                if not pcall(function() vim.treesitter.get_parser(0, lang):parse() end) then return true end
                if not pcall(function() vim.treesitter.query.get(lang, "highlights") end) then return true end
                return false
              end,
            },
          })
        EOB
`,
      );
    },
  },
  {
    url: "yioneko/nvim-yati",
    dependencies: [{ url: "nvim-treesitter/nvim-treesitter" }],
    // deno-lint-ignore require-await
    enabled: async ({ denops }) => denops.meta.host === "nvim" && !pluginStatus.vscode,
    after: async ({ denops }) => {
      await execute(
        denops,
        `
        lua << EOB
          require("nvim-treesitter.configs").setup({
            yati = {
              enable = true,
              -- Disable by languages
              disable = {},

              -- Whether to enable lazy mode (recommend to enable this if bad indent happens frequently)
              default_lazy = true,

              -- Determine the fallback method used when we cannot calculate indent by tree-sitter
              --   "auto": fallback to vim auto indent
              --   "asis": use current indent as-is
              --   "cindent": see ':h cindent()'
              default_fallback = "auto"
            },
            indent = {
              enable = false -- disable builtin indent module
            }
          })
        EOB
`,
      );
    },
  },
  {
    url: "nvim-treesitter/nvim-treesitter-context",
    dependencies: [{ url: "nvim-treesitter/nvim-treesitter" }],
    // deno-lint-ignore require-await
    enabled: async ({ denops }) => denops.meta.host === "nvim" && !pluginStatus.vscode,
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("treesitter-context").setup()`);
    },
  },
  {
    url: "windwp/nvim-ts-autotag",
    // deno-lint-ignore require-await
    enabled: async ({ denops }) => denops.meta.host === "nvim" && !pluginStatus.vscode,
    dependencies: [{ url: "nvim-treesitter/nvim-treesitter" }],
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("nvim-ts-autotag").setup()`);
    },
  },
  {
    url: "monaqa/nvim-treesitter-clipping",
    // deno-lint-ignore require-await
    enabled: async ({ denops }) => denops.meta.host === "nvim" && !pluginStatus.vscode,
    dependencies: [
      { url: "nvim-treesitter/nvim-treesitter" },
      { url: "thinca/vim-partedit" },
    ],
    after: async ({ denops }) => {
      await mapping.map(
        denops,
        "<space>C",
        "<Plug>(ts-clipping-clip)",
        { mode: "n" },
      );
      await mapping.map(
        denops,
        "<space>C",
        "<Plug>(ts-clipping-select)",
        { mode: ["x", "o"] },
      );
    },
  },
  {
    url: "HiPhish/rainbow-delimiters.nvim",
    // deno-lint-ignore require-await
    enabled: async ({ denops }) => denops.meta.host === "nvim" && !pluginStatus.vscode,
    dependencies: [{ url: "nvim-treesitter/nvim-treesitter" }],
  },
];
