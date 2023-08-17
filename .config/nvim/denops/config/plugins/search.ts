// =============================================================================
// File        : search.ts
// Author      : yukimemi
// Last Change : 2023/07/16 00:38:18.
// =============================================================================

import type { Plug } from "https://deno.land/x/dvpm@3.0.6/mod.ts";

import * as mapping from "https://deno.land/x/denops_std@v5.0.1/mapping/mod.ts";
import { execute } from "https://deno.land/x/denops_std@v5.0.1/helper/mod.ts";

import { pluginStatus } from "../main.ts";

export const search: Plug[] = [
  { url: "lambdalisue/reword.vim" },
  {
    url: "haya14busa/vim-asterisk",
    after: async ({ denops }) => {
      await mapping.map(denops, "*", "<Plug>(asterisk-z*)zv", {
        mode: ["n", "o", "x"],
      });
      await mapping.map(denops, "g*", "<Plug>(asterisk-gz*)zv", {
        mode: ["n", "o", "x"],
      });
      await mapping.map(denops, "#", "<Plug>(asterisk-z#)zv", {
        mode: ["n", "o", "x"],
      });
      await mapping.map(denops, "g#", "<Plug>(asterisk-gz#)zv", {
        mode: ["n", "o", "x"],
      });
    },
  },
  {
    url: "monaqa/modesearch.nvim",
    // deno-lint-ignore require-await
    enabled: async ({ denops }) => denops.meta.host === "nvim" && pluginStatus.modesearch,
    after: async ({ denops }) => {
      await execute(
        denops,
        `
        lua << EOB
          vim.keymap.set("n", "/", function() return require("modesearch").keymap.prompt.show("rawstr") end, { expr = true })
          vim.keymap.set(
            "c",
            "<C-x>",
            function() return require("modesearch").keymap.mode.cycle({ "rawstr", "migemo", "regexp" }) end,
            { expr = true }
          )
          require("modesearch").setup({
            modes = {
              rawstr = {
                prompt = "[rawstr]/",
                converter = function(query) return [[\\V]] .. vim.fn.escape(query, [[/\\]]) end,
              },
              regexp = {
                prompt = "[regexp]/",
                converter = function(query) return [[\\v]] .. vim.fn.escape(query, [[/]]) end,
              },
              migemo = {
                prompt = "[migemo]/",
                converter = function(query) return [[\\v]] .. vim.fn["kensaku#query"](query) end,
              },
            },
          })
        EOB
      `,
      );
    },
  },
  {
    url: "lambdalisue/kensaku-search.vim",
    enabled: false,
    dependencies: [
      { url: "lambdalisue/kensaku.vim" },
    ],
    after: async ({ denops }) => {
      await mapping.map(denops, "<cr>", "<Plug>(kensaku-search-replace)<cr>", {
        mode: "c",
      });
    },
  },
];
