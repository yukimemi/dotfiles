// =============================================================================
// File        : memo.ts
// Author      : yukimemi
// Last Change : 2026/01/12 11:05:36
// =============================================================================

import type { Plug } from "@yukimemi/dvpm";

import { exists } from "@std/fs";
import * as fn from "@denops/std/function";
import * as mapping from "@denops/std/mapping";
import * as vars from "@denops/std/variable";
import { z } from "zod";

import { pluginStatus } from "../pluginstatus.ts";

export const memo: Plug[] = [
  {
    url: "https://github.com/vimwiki/vimwiki",
    enabled: pluginStatus.vimwiki,
    profiles: ["memo"],
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
    profiles: ["memo"],
    cache: {
      beforeFile: ` ~/.config/nvim/rc/before/memolist.vim`,
    },
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
    enabled: false,
    profiles: ["memo"],
    after: async ({ denops }) => {
      const zettelkastenPath = await fn.expand(denops, "~/.zettelkasten");
      await denops.call(`luaeval`, `require("zettelkasten").setup(_A)`, {
        notes_path: zettelkastenPath,
      });
    },
  },
  {
    url: "https://github.com/renerocksai/calendar-vim",
    enabled: false,
    profiles: ["memo"],
  },
  {
    url: "https://github.com/renerocksai/telekasten.nvim",
    enabled: false,
    profiles: ["memo"],
    dependencies: [
      "https://github.com/nvim-telescope/telescope.nvim",
      "https://github.com/renerocksai/calendar-vim",
    ],
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("telekasten").setup(_A)`, {
        home: await fn.expand(denops, "~/.zettelkasten"),
      });

      // Launch panel if nothing is typed after <leader>z
      await mapping.map(denops, "<leader>z", "<cmd>Telekasten panel<CR>", {
        mode: "n",
      });

      // Most used functions
      await mapping.map(
        denops,
        "<leader>zf",
        "<cmd>Telekasten find_notes<CR>",
        { mode: "n" },
      );
      await mapping.map(
        denops,
        "<leader>zg",
        "<cmd>Telekasten search_notes<CR>",
        { mode: "n" },
      );
      await mapping.map(
        denops,
        "<leader>zd",
        "<cmd>Telekasten goto_today<CR>",
        { mode: "n" },
      );
      await mapping.map(
        denops,
        "<leader>zz",
        "<cmd>Telekasten follow_link<CR>",
        { mode: "n" },
      );
      await mapping.map(denops, "<leader>zn", "<cmd>Telekasten new_note<CR>", {
        mode: "n",
      });
      await mapping.map(
        denops,
        "<leader>zc",
        "<cmd>Telekasten show_calendar<CR>",
        { mode: "n" },
      );
      await mapping.map(
        denops,
        "<leader>zb",
        "<cmd>Telekasten show_backlinks<CR>",
        { mode: "n" },
      );
      await mapping.map(
        denops,
        "<leader>zI",
        "<cmd>Telekasten insert_img_link<CR>",
        { mode: "n" },
      );

      // Call insert link automatically when we start typing a link
      // await mapping.map(denops, "[[", "<cmd>Telekasten insert_link<CR>", { mode: "i" });
    },
  },
  {
    url: "https://github.com/walkersumida/fusen.nvim",
    enabled: pluginStatus.fusen,
    profiles: ["memo"],
    lazy: {
      keys: ["ml", "me", "mn", "mp"],
    },
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("fusen").setup(_A)`, {
        save_file: `${await fn.expand(denops, "~/.cache/fusen_marks.json")}`,
        keymaps: {
          list_marks: "ml",
        },
      });
    },
  },
  {
    url: "https://github.com/epwalsh/obsidian.nvim",
    enabled: pluginStatus.obsidian,
    profiles: ["memo"],
    dependencies: [
      "https://github.com/nvim-lua/plenary.nvim",
    ],
    cache: {
      afterFile: "~/.config/nvim/rc/after/obsidian.lua",
    },
    build: async ({ denops }) => {
      const path = z.string().parse(await fn.expand(denops, "~/obsidian"));
      if (!(await exists(path))) {
        console.log(`Cloning obsidian vault to ${path} ...`);
        await new Deno.Command("git", {
          args: [
            "clone",
            "https://github.com/yukimemi/obsidian-vault.git",
            path,
          ],
        }).output();
      }
    },
  },
];
