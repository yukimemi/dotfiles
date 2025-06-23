// =============================================================================
// File        : libs.ts
// Author      : yukimemi
// Last Change : 2025/05/05 18:24:23.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@7.0.3";

import * as autocmd from "jsr:@denops/std@7.6.0/autocmd";
import * as mapping from "jsr:@denops/std@7.6.0/mapping";
import * as vars from "jsr:@denops/std@7.6.0/variable";
import { pluginStatus } from "../pluginstatus.ts";

export const libs: Plug[] = [
  {
    url: "https://github.com/vim-denops/denops.vim",
    profiles: ["minimal"],
    cache: { beforeFile: `~/.config/nvim/rc/before/denops.vim` },
  },
  {
    url: "https://github.com/thinca/vim-localrc",
    cache: { enabled: true },
  },
  {
    url: "https://github.com/vim-denops/denops-shared-server.vim",
    dependencies: ["https://github.com/vim-denops/denops.vim"],
    // deno-lint-ignore require-await
    enabled: async ({ denops }) => denops.meta.platform === "windows",
    cache: { beforeFile: `~/.config/nvim/rc/before/denops-shared-server.vim` },
    build: async ({ denops, info }) => {
      if (info.isUpdate && info.isLoad) {
        await denops.call(`denops_shared_server#install`);
      }
    },
  },
  {
    url: "https://github.com/LunarVim/bigfile.nvim",
    cache: { afterFile: `~/.config/nvim/rc/after/bigfile.lua` },
  },
  {
    url: "https://github.com/tani/vim-artemis",
    profiles: ["default"],
    cache: { enabled: true },
  },
  {
    url: "https://github.com/j-hui/fidget.nvim",
    profiles: ["default"],
    enabled: pluginStatus.fidget,
    cache: { afterFile: "~/.config/nvim/rc/after/fidget.lua" },
  },
  {
    url: "https://github.com/rcarriga/nvim-notify",
    enabled: pluginStatus.nvimnotify,
    cache: {
      enabled: false,
      afterFile: "~/.config/nvim/rc/after/nvim-notify.lua",
    },
    afterFile: "~/.config/nvim/rc/after/nvim-notify.lua",
    after: async ({ denops }) => {
      await mapping.map(
        denops,
        "<leader>nc",
        `<cmd>lua require("notify").dismiss()<cr>`,
        {
          mode: "n",
        },
      );
    },
  },
  {
    url: "https://github.com/vigoux/notifier.nvim",
    enabled: pluginStatus.notifier,
    cache: {
      afterFile: "~/.config/nvim/rc/after/notifier.lua",
    },
    after: async ({ denops }) => {
      await mapping.map(
        denops,
        "<leader>nc",
        `<cmd>NotifierClear<cr>`,
        {
          mode: "n",
        },
      );
    },
  },
  {
    url: "https://github.com/nvim-lua/plenary.nvim",
    profiles: ["minimal"],
  },
  {
    url: "https://github.com/MunifTanjim/nui.nvim",
    profiles: ["minimal"],
  },
  {
    url: "https://github.com/stevearc/dressing.nvim",
    enabled: false,
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("dressing").setup()`);
    },
  },
  {
    url: "https://github.com/nvim-tree/nvim-web-devicons",
    profiles: ["minimal"],
    cache: { enabled: false },
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("nvim-web-devicons").setup(_A)`, {
        default: true,
      });
    },
  },
  {
    url: "https://github.com/rachartier/tiny-devicons-auto-colors.nvim",
    enabled: false,
    dependencies: ["https://github.com/nvim-tree/nvim-web-devicons"],
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("tiny-devicons-auto-colors").setup()`);
    },
  },
  {
    url: "https://github.com/folke/noice.nvim",
    profiles: ["minimal"],
    enabled: false,
    dependencies: [
      "https://github.com/MunifTanjim/nui.nvim",
    ],
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("noice").setup(_A)`, {
        lsp: {
          override: {
            "vim.lsp.util.convert_input_to_markdown_lines": true,
            "vim.lsp.util.stylize_markdown": true,
          },
        },
        presets: {
          bottom_search: true,
          command_palette: true,
          long_message_to_split: true,
          inc_rename: false,
          lsp_doc_border: false,
        },
        cmdline: {
          enabled: true,
          view: "cmdline",
        },
        notify: {
          enabled: true,
        },
      });
    },
  },
  {
    url: "https://github.com/kamalsacranie/nvim-mapper",
    profiles: ["default"],
    cache: { enabled: true },
  },
  {
    url: "https://github.com/kana/vim-repeat",
    enabled: false,
  },
  {
    url: "https://github.com/tyru/open-browser.vim",
    before: async ({ denops }) => {
      await vars.g.set(denops, "netrw_nogx", 1);
      await mapping.map(denops, "gx", "<Plug>(openbrowser-smart-search)", { mode: ["n", "x"] });
    },
  },
  {
    url: "https://github.com/tyru/open-browser-github.vim",
    dependencies: ["https://github.com/tyru/open-browser.vim"],
  },
  { url: "https://github.com/lambdalisue/vim-readablefold" },
  {
    url: "https://github.com/ryanoasis/vim-devicons",
    // deno-lint-ignore require-await
    enabled: async ({ denops }) => denops.meta.host === "vim",
    // deno-lint-ignore require-await
    clone: async ({ denops }) => denops.meta.host === "vim",
  },
  {
    url: "https://github.com/folke/which-key.nvim",
    profiles: ["minimal"],
    enabled: true,
    afterFile: `~/.config/nvim/rc/after/which-key.lua`,
  },
  {
    url: "https://github.com/lambdalisue/vim-findent",
    // deno-lint-ignore require-await
    enabled: async ({ denops }) => denops.meta.host === "vim",
    // deno-lint-ignore require-await
    clone: async ({ denops }) => denops.meta.host === "vim",
    before: async ({ denops }) => {
      await vars.g.set(denops, "findent#enable_warnings", 1);
      await vars.g.set(denops, "findent#enable_messages", 1);
      await autocmd.group(denops, "MyFindent", (helper) => {
        helper.remove("*");
        helper.define("BufRead", "*", "Findent");
      });
    },
  },
  {
    url: "https://github.com/hrsh7th/nvim-dansa",
    profiles: ["minimal"],
    afterFile: "~/.config/nvim/rc/after/nvim-dansa.lua",
  },
  { url: "https://github.com/yuki-yano/dedent-yank.vim" },
  {
    url: "https://github.com/kevinhwang91/promise-async",
    profiles: ["lsp"],
  },
];
