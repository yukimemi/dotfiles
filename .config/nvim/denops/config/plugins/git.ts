// =============================================================================
// File        : git.ts
// Author      : yukimemi
// Last Change : 2024/07/21 18:56:36.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@4.0.2";

import * as mapping from "jsr:@denops/std@7.0.0/mapping";
import { pluginStatus } from "../pluginstatus.ts";

export const git: Plug[] = [
  {
    url: "https://github.com/lewis6991/gitsigns.nvim",
    enabled: !pluginStatus.vscode,
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("gitsigns").setup(_A)`, {
        signcolumn: true,
        numhl: false,
        linehl: false,
        word_diff: false,
        watch_gitdir: {
          follow_files: true,
        },
        attach_to_untracked: true,
        current_line_blame: true,
        current_line_blame_opts: {
          virt_text: true,
          virt_text_pos: "eol",
          delay: 1000,
          ignore_whitespace: true,
          virt_text_priority: 100,
        },
        current_line_blame_formatter: "<author>, <author_time:%Y-%m-%d> - <summary>",
        sign_priority: 6,
        update_debounce: 100,
        status_formatter: null,
        max_file_length: 40000,
        preview_config: {
          border: "single",
          style: "minimal",
          relative: "cursor",
          row: 0,
          col: 1,
        },
      });
      await mapping.map(
        denops,
        "]g",
        `<cmd>lua require("gitsigns").next_hunk()<cr>`,
        {
          mode: "n",
        },
      );
      await mapping.map(
        denops,
        "[g",
        `<cmd>lua require("gitsigns").prev_hunk()<cr>`,
        {
          mode: "n",
        },
      );
    },
  },
  {
    url: "https://github.com/lambdalisue/vim-gin",
    enabled: !pluginStatus.vscode,
    dependencies: [
      { url: "https://github.com/lambdalisue/vim-askpass" },
      { url: "https://github.com/lambdalisue/vim-guise" },
    ],
    cache: {
      beforeFile: `~/.config/nvim/rc/before/vim-gin.lua`,
    },
  },
  {
    url: "https://github.com/skanehira/denops-gh.vim",
    enabled: false,
  },
  {
    url: "https://github.com/rhysd/committia.vim",
    cache: {
      beforeFile: `~/.config/nvim/rc/before/committia.vim`,
    },
  },
  {
    url: "https://github.com/sindrets/diffview.nvim",
    afterFile: `~/.config/nvim/rc/after/diffview.lua`,
  },
  {
    url: "https://github.com/linrongbin16/gitlinker.nvim",
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("gitlinker").setup()`);
    },
  },
  {
    url: "https://github.com/pwntester/octo.nvim",
    afterFile: `~/.config/nvim/rc/after/octo.lua`,
  },
];
