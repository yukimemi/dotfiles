// =============================================================================
// File        : git.ts
// Author      : yukimemi
// Last Change : 2026/01/12 21:48:38.
// =============================================================================

import * as mapping from "@denops/std/mapping";
import type { Plug } from "@yukimemi/dvpm";
import { pluginStatus } from "../pluginstatus.ts";
import { execCommand } from "../util.ts";

export const git: Plug[] = [
  {
    url: "https://github.com/lewis6991/gitsigns.nvim",
    profiles: ["git"],
    lazy: {
      event: "BufRead",
    },
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
        `<cmd>lua require("gitsigns").nav_hunk("next")<cr>`,
        {
          mode: "n",
        },
      );
      await mapping.map(
        denops,
        "[g",
        `<cmd>lua require("gitsigns").nav_hunk("prev")<cr>`,
        {
          mode: "n",
        },
      );
    },
  },
  {
    url: "https://github.com/lambdalisue/vim-askpass",
    profiles: ["git"],
    lazy: { enabled: true },
  },
  {
    url: "https://github.com/lambdalisue/vim-guise",
    profiles: ["git"],
    lazy: { enabled: true },
  },
  {
    url: "https://github.com/lambdalisue/vim-gin",
    profiles: ["git"],
    cache: { beforeFile: `~/.config/nvim/rc/before/vim-gin.lua` },
    afterFile: `~/.config/nvim/rc/after/vim-gin.lua`,
  },
  {
    url: "https://github.com/skanehira/denops-gh.vim",
    enabled: false,
    profiles: ["git"],
  },
  {
    url: "https://github.com/rhysd/committia.vim",
    profiles: ["git"],
    cache: {
      beforeFile: `~/.config/nvim/rc/before/committia.vim`,
    },
  },
  {
    url: "https://github.com/sindrets/diffview.nvim",
    enabled: pluginStatus.diffview,
    profiles: ["git"],
    lazy: {
      cmd: [
        "DiffviewOpen",
        "DiffviewClose",
        "DiffviewToggle",
        "DiffviewFocusFloat",
        "DiffviewLog",
        "DiffviewRefresh",
        "DiffviewFileHistory",
      ],
    },
    afterFile: `~/.config/nvim/rc/after/diffview.lua`,
  },
  {
    url: "https://github.com/clabby/difftastic.nvim",
    enabled: pluginStatus.difftastic,
    profiles: ["git"],
    dependencies: [
      "https://github.com/MunifTanjim/nui.nvim",
    ],
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("difftastic-nvim").setup(_A)`, {
        download: true,
      });
    },
  },
  {
    url: "https://github.com/linrongbin16/gitlinker.nvim",
    enabled: false,
    profiles: ["git"],
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("gitlinker").setup()`);
    },
  },
  {
    url: "https://github.com/pwntester/octo.nvim",
    enabled: pluginStatus.telescope,
    profiles: ["git"],
    lazy: {
      cmd: "Octo",
    },
    dependencies: [
      "https://github.com/nvim-lua/plenary.nvim",
      "https://github.com/nvim-telescope/telescope.nvim",
      "https://github.com/nvim-tree/nvim-web-devicons",
    ],
    afterFile: `~/.config/nvim/rc/after/octo.lua`,
  },
  {
    url: "https://github.com/akinsho/git-conflict.nvim",
    profiles: ["git"],
    lazy: {
      event: "BufRead",
    },
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("git-conflict").setup()`);
    },
  },
  {
    url: "https://github.com/2KAbhishek/octohub.nvim",
    enabled: false,
    profiles: ["git"],
    afterFile: `~/.config/nvim/rc/after/octohub.lua`,
  },
  {
    url: "https://github.com/kdheepak/lazygit.nvim",
    enabled: false,
    profiles: ["git"],
    lazy: {
      cmd: "LazyGit",
    },
    dependencies: ["https://github.com/nvim-lua/plenary.nvim"],
    build: async ({ denops, info }) => {
      if ((info.isInstalled || info.isUpdated) && info.isLoaded) {
        await execCommand(
          denops,
          "go",
          ["install", "github.com/jesseduffield/lazygit@latest"],
          info.dst,
        );
      }
    },
    afterFile: `~/.config/nvim/rc/after/lazygit.lua`,
  },
  {
    url: "https://github.com/skanehira/github-actions.nvim",
    profiles: ["git"],
    lazy: {
      keys: [
        {
          lhs: "<leader>Gd",
          rhs: "<cmd>lua require('github-actions').dispatch_workflow()<cr>",
          desc: "Dispatch workflow",
        },
        {
          lhs: "<leader>Gh",
          rhs: "<cmd>lua require('github-actions').show_history()<cr>",
          desc: "Show workflow history",
        },
        {
          lhs: "<leader>Gw",
          rhs: "<cmd>lua require('github-actions').watch_workflow()<cr>",
          desc: "Watch running workflow",
        },
      ],
    },
    afterFile: `~/.config/nvim/rc/after/github-actions.lua`,
  },
  {
    url: "https://github.com/yannvanhalewyn/jujutsu.nvim",
    enabled: false,
    profiles: ["git"],
    dependencies: [
      "https://github.com/clabby/difftastic.nvim",
    ],
    lazy: {
      keys: { lhs: "<space>j", rhs: "<cmd>JJ<cr>", mode: "n", desc: "JJ log" },
    },
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("jujutsu-nvim").setup(_A)`, {});
    },
  },
];
