// =============================================================================
// File        : libs.ts
// Author      : yukimemi
// Last Change : 2024/11/29 02:03:34.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@5.5.0";

import * as autocmd from "jsr:@denops/std@7.4.0/autocmd";
import * as fn from "jsr:@denops/std@7.4.0/function";
import * as mapping from "jsr:@denops/std@7.4.0/mapping";
import * as vars from "jsr:@denops/std@7.4.0/variable";
import { z } from "npm:zod@3.23.8";
import { exists } from "jsr:@std/fs@1.0.6";
import { pluginStatus } from "../pluginstatus.ts";

export const libs: Plug[] = [
  {
    url: "https://github.com/vim-denops/denops.vim",
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
    build: async ({ denops }) => {
      await denops.call(`denops_shared_server#install`);
    },
  },
  {
    url: "https://github.com/LunarVim/bigfile.nvim",
    cache: { afterFile: `~/.config/nvim/rc/after/bigfile.lua` },
  },
  {
    url: "https://github.com/tani/vim-artemis",
    cache: { enabled: true },
  },
  {
    url: "https://github.com/j-hui/fidget.nvim",
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
    cache: { enabled: false },
  },
  { url: "https://github.com/MunifTanjim/nui.nvim" },
  {
    url: "https://github.com/stevearc/dressing.nvim",
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("dressing").setup()`);
    },
  },
  {
    url: "https://github.com/nvim-tree/nvim-web-devicons",
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
          enabled: false,
        },
      });
    },
  },
  {
    url: "https://github.com/kana/vim-repeat",
    enabled: false,
  },
  { url: "https://github.com/mattn/vim-findroot" },
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
    enabled: false,
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("which-key").setup()`);
    },
  },
  {
    url: "https://github.com/liuchengxu/vim-which-key",
    // deno-lint-ignore require-await
    enabled: async ({ denops }) => denops.meta.host === "vim",
    // deno-lint-ignore require-await
    clone: async ({ denops }) => denops.meta.host === "vim",
    after: async ({ denops }) => {
      await mapping.map(denops, "<leader>", "<cmd>WhichKey '<space>'<cr>", {
        mode: ["n", "x"],
      });
      await mapping.map(denops, "<localleader>", "<cmd>WhichKey '\\'<cr>", {
        mode: ["n", "x"],
      });
    },
  },
  {
    url: "https://github.com/Exafunction/codeium.vim",
    enabled: async ({ denops }) =>
      await exists(z.string().parse(await fn.expand(denops, "~/.codeium"))) && false,
    before: async ({ denops }) => {
      await vars.g.set(denops, "codeium_no_map_tab", true);
    },
    after: async ({ denops }) => {
      await mapping.map(denops, "<c-e>", "codeium#Accept()", {
        mode: "i",
        expr: true,
        nowait: true,
      });
    },
  },
  {
    url: "https://github.com/monkoose/neocodeium",
    enabled: async ({ denops }) =>
      await exists(z.string().parse(await fn.expand(denops, "~/.codeium"))) && true,
    afterFile: "~/.config/nvim/rc/after/neocodeium.lua",
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
    afterFile: "~/.config/nvim/rc/after/nvim-dansa.lua",
  },
  { url: "https://github.com/yuki-yano/dedent-yank.vim" },
];
