// =============================================================================
// File        : wiki.ts
// Author      : yukimemi
// Last Change : 2023/10/17 23:26:53.
// =============================================================================

import type { Plug } from "https://deno.land/x/dvpm@3.7.2/mod.ts";

import * as fn from "https://deno.land/x/denops_std@v5.2.0/function/mod.ts";
import * as mapping from "https://deno.land/x/denops_std@v5.2.0/mapping/mod.ts";
import * as vars from "https://deno.land/x/denops_std@v5.2.0/variable/mod.ts";

import { pluginStatus } from "../pluginstatus.ts";

export const memo: Plug[] = [
  {
    url: "https://github.com/vimwiki/vimwiki",
    enabled: pluginStatus.vimwiki,
    before: async ({ denops }) => {
      await vars.g.set(denops, "vimwiki_list", [
        {
          path: "~/.vimwiki",
          syntax: "markdown",
          ext: ".md",
        },
      ]);
    },
  },
  {
    url: "https://github.com/glidenote/memolist.vim",
    before: async ({ denops }) => {
      await vars.g.set(
        denops,
        "memolist_path",
        await fn.expand(denops, "~/.memolist"),
      );
      await vars.g.set(denops, "memolist_memo_suffix", "md");
      await vars.g.set(denops, "memolist_prompt_tags", 1);

      await mapping.map(denops, "<leader>mn", "<cmd>MemoNew<cr>", {
        mode: "n",
      });
      await mapping.map(denops, "<leader>ml", "<cmd>MemoList<cr>", {
        mode: "n",
      });
    },
  },
  {
    url: "https://github.com/Furkanzmc/zettelkasten.nvim",
    // deno-lint-ignore require-await
    enabled: async ({ denops }) => denops.meta.host === "nvim" && false,
    after: async ({ denops }) => {
      const zettelkastenPath = await fn.expand(denops, "~/.zettelkasten");
      await denops.call(`luaeval`, `require("zettelkasten").setup(_A)`, {
        notes_path: zettelkastenPath,
      });
    },
  },
  {
    url: "https://github.com/renerocksai/telekasten.nvim",
    dependencies: [
      { url: "https://github.com/nvim-telescope/telescope.nvim" },
      { url: "https://github.com/renerocksai/calendar-vim" },
    ],
    // deno-lint-ignore require-await
    enabled: async ({ denops }) => denops.meta.host === "nvim",
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("telekasten").setup(_A)`, {
        home: await fn.expand(denops, "~/.zettelkasten"),
      });

      // Launch panel if nothing is typed after <leader>z
      await mapping.map(denops, "<leader>z", "<cmd>Telekasten panel<CR>", { mode: "n" });

      // Most used functions
      await mapping.map(denops, "<leader>zf", "<cmd>Telekasten find_notes<CR>", { mode: "n" });
      await mapping.map(denops, "<leader>zg", "<cmd>Telekasten search_notes<CR>", { mode: "n" });
      await mapping.map(denops, "<leader>zd", "<cmd>Telekasten goto_today<CR>", { mode: "n" });
      await mapping.map(denops, "<leader>zz", "<cmd>Telekasten follow_link<CR>", { mode: "n" });
      await mapping.map(denops, "<leader>zn", "<cmd>Telekasten new_note<CR>", { mode: "n" });
      await mapping.map(denops, "<leader>zc", "<cmd>Telekasten show_calendar<CR>", { mode: "n" });
      await mapping.map(denops, "<leader>zb", "<cmd>Telekasten show_backlinks<CR>", { mode: "n" });
      await mapping.map(denops, "<leader>zI", "<cmd>Telekasten insert_img_link<CR>", { mode: "n" });

      // Call insert link automatically when we start typing a link
      // await mapping.map(denops, "[[", "<cmd>Telekasten insert_link<CR>", { mode: "i" });
    },
  },
];
