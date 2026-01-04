// =============================================================================
// File        : libs.ts
// Author      : yukimemi
// Last Change : 2025/12/27 23:55:31.
// =============================================================================

import type { Plug } from "@yukimemi/dvpm";

import * as autocmd from "@denops/std/autocmd";
import * as mapping from "@denops/std/mapping";
import * as vars from "@denops/std/variable";
import { pluginStatus } from "../pluginstatus.ts";

export const libs: Plug[] = [
  {
    url: "https://github.com/vim-denops/denops.vim",
    profiles: ["core"],
    cache: { beforeFile: `~/.config/nvim/rc/before/denops.vim` },
  },
  {
    url: "https://github.com/thinca/vim-localrc",
    profiles: ["core"],
    cache: { enabled: true },
  },
  {
    url: "https://github.com/vim-denops/denops-shared-server.vim",
    // deno-lint-ignore require-await
    enabled: async ({ denops }) => denops.meta.platform === "windows" && false,
    profiles: ["core"],
    dependencies: ["https://github.com/vim-denops/denops.vim"],
    cache: { beforeFile: `~/.config/nvim/rc/before/denops-shared-server.vim` },
    build: async ({ denops, info }) => {
      if (info.isUpdate && info.isLoad) {
        await denops.call(`denops_shared_server#install`);
      }
    },
  },
  {
    url: "https://github.com/LunarVim/bigfile.nvim",
    enabled: false,
    profiles: ["core"],
    cache: { afterFile: `~/.config/nvim/rc/after/bigfile.lua` },
  },
  {
    url: "https://github.com/tani/vim-artemis",
    profiles: ["core"],
    cache: { enabled: true },
  },
  {
    url: "https://github.com/j-hui/fidget.nvim",
    enabled: pluginStatus.fidget,
    profiles: ["ui"],
    cache: { afterFile: "~/.config/nvim/rc/after/fidget.lua" },
  },
  {
    url: "https://github.com/rcarriga/nvim-notify",
    enabled: pluginStatus.nvimnotify,
    profiles: ["ui"],
    cache: {
      enabled: false,
      afterFile: "~/.config/nvim/rc/after/nvim-notify.lua",
    },
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
    afterFile: "~/.config/nvim/rc/after/nvim-notify.lua",
  },
  {
    url: "https://github.com/vigoux/notifier.nvim",
    enabled: pluginStatus.notifier,
    profiles: ["ui"],
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
    profiles: ["core"],
    lazy: { enabled: true },
  },
  {
    url: "https://github.com/MunifTanjim/nui.nvim",
    profiles: ["core"],
    lazy: { enabled: true },
  },
  {
    url: "https://github.com/nvim-tree/nvim-web-devicons",
    profiles: ["core"],
    lazy: { enabled: true },
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
    profiles: ["ui"],
    dependencies: ["https://github.com/nvim-tree/nvim-web-devicons"],
    after: async ({ denops }) => {
      await denops.call(
        `luaeval`,
        `require("tiny-devicons-auto-colors").setup()`,
      );
    },
  },
  {
    url: "https://github.com/folke/noice.nvim",
    enabled: pluginStatus.noice,
    profiles: ["core"],
    dependencies: [
      "https://github.com/MunifTanjim/nui.nvim",
    ],
    after: async ({ denops }) => {
      await vars.o.set(denops, "cmdheight", 0);
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
        },
        notify: {
          enabled: true,
        },
      });
    },
  },
  {
    url: "https://github.com/maikel-479/noti.nvim",
    enabled: false,
    profiles: ["core"],
    dependencies: [
      "https://github.com/nvim-lua/plenary.nvim",
      "https://github.com/nvzone/volt",
      "https://github.com/folke/noice.nvim",
    ],
    afterFile: `~/.config/nvim/rc/after/noti.lua`,
  },
  {
    url: "https://github.com/kamalsacranie/nvim-mapper",
    profiles: ["core"],
    cache: { enabled: true },
  },
  {
    url: "https://github.com/kana/vim-repeat",
    enabled: false,
    profiles: ["core"],
  },
  {
    url: "https://github.com/tyru/open-browser.vim",
    profiles: ["core"],
    before: async ({ denops }) => {
      await vars.g.set(denops, "netrw_nogx", 1);
      await mapping.map(denops, "gx", "<Plug>(openbrowser-smart-search)", {
        mode: ["n", "x"],
      });
    },
  },
  {
    url: "https://github.com/tyru/open-browser-github.vim",
    profiles: ["core"],
    dependencies: ["https://github.com/tyru/open-browser.vim"],
  },
  {
    url: "https://github.com/lambdalisue/vim-readablefold",
    profiles: ["core"],
    lazy: {
      event: ["BufRead", "BufNewFile"],
    },
  },
  {
    url: "https://github.com/ryanoasis/vim-devicons",
    // deno-lint-ignore require-await
    enabled: async ({ denops }) => denops.meta.host === "vim",
    // deno-lint-ignore require-await
    clone: async ({ denops }) => denops.meta.host === "vim",
    profiles: ["ui"],
    lazy: { enabled: true },
  },
  {
    url: "https://github.com/folke/which-key.nvim",
    enabled: true,
    profiles: ["core"],
    lazy: {
      event: "CursorHold",
    },
    afterFile: `~/.config/nvim/rc/after/which-key.lua`,
  },
  {
    url: "https://github.com/lambdalisue/vim-findent",
    // deno-lint-ignore require-await
    enabled: async ({ denops }) => denops.meta.host === "vim",
    // deno-lint-ignore require-await
    clone: async ({ denops }) => denops.meta.host === "vim",
    profiles: ["core"],
    lazy: {
      event: ["BufRead", "BufNewFile"],
    },
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
    profiles: ["core"],
    lazy: {
      event: ["BufRead", "BufNewFile"],
    },
    afterFile: "~/.config/nvim/rc/after/nvim-dansa.lua",
  },
  {
    url: "https://github.com/yuki-yano/dedent-yank.vim",
    enabled: false,
    profiles: ["core"],
    lazy: { enabled: true },
  },
  {
    url: "https://github.com/kevinhwang91/promise-async",
    profiles: ["core"],
    lazy: { enabled: true },
  },
];
