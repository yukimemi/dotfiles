// =============================================================================
// File        : libs.ts
// Author      : yukimemi
// Last Change : 2024/01/04 08:04:02.
// =============================================================================

import type { Plug } from "https://deno.land/x/dvpm@3.8.1/mod.ts";

import * as autocmd from "https://deno.land/x/denops_std@v5.2.0/autocmd/mod.ts";
import * as fn from "https://deno.land/x/denops_std@v5.2.0/function/mod.ts";
import * as mapping from "https://deno.land/x/denops_std@v5.2.0/mapping/mod.ts";
import * as vars from "https://deno.land/x/denops_std@v5.2.0/variable/mod.ts";
import { ensure, is } from "https://deno.land/x/unknownutil@v3.13.0/mod.ts";
import { exists } from "https://deno.land/std@0.212.0/fs/mod.ts";
import { pluginStatus } from "../pluginstatus.ts";

export const libs: Plug[] = [
  {
    url: "https://github.com/vim-denops/denops.vim",
    branch: "v6-pre",
    cache: {
      // deno-lint-ignore require-await
      enabled: async ({ denops }) => denops.meta.platform === "windows" && false,
      before: `
        let g:denops_server_addr = '127.0.0.1:32123'
      `,
    },
  },
  {
    url: "https://github.com/vim-denops/denops-shared-server.vim",
    // deno-lint-ignore require-await
    enabled: async ({ denops }) => denops.meta.platform === "windows",
  },
  {
    url: "https://github.com/LunarVim/bigfile.nvim",
    // deno-lint-ignore require-await
    enabled: async ({ denops }) => denops.meta.host === "nvim",
    cache: { enabled: true },
  },
  {
    url: "https://github.com/tani/vim-artemis",
    // deno-lint-ignore require-await
    enabled: async ({ denops }) => denops.meta.host === "nvim" && !pluginStatus.vscode,
    cache: { enabled: true },
  },
  {
    url: "https://github.com/rcarriga/nvim-notify",
    // deno-lint-ignore require-await
    enabled: async ({ denops }) =>
      denops.meta.host === "nvim" && pluginStatus.nvimnotify &&
      !pluginStatus.vscode,
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
    // deno-lint-ignore require-await
    enabled: async ({ denops }) =>
      denops.meta.host === "nvim" && pluginStatus.notifier &&
      !pluginStatus.vscode,
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
    // deno-lint-ignore require-await
    enabled: async ({ denops }) => denops.meta.host === "nvim" && !pluginStatus.vscode,
  },
  {
    url: "https://github.com/MunifTanjim/nui.nvim",
    // deno-lint-ignore require-await
    enabled: async ({ denops }) => denops.meta.host === "nvim" && !pluginStatus.vscode,
  },
  {
    url: "https://github.com/stevearc/dressing.nvim",
    // deno-lint-ignore require-await
    enabled: async ({ denops }) => denops.meta.host === "nvim" && !pluginStatus.vscode,
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("dressing").setup()`);
    },
  },
  {
    url: "https://github.com/nvim-tree/nvim-web-devicons",
    cache: { enabled: false },
    // deno-lint-ignore require-await
    enabled: async ({ denops }) => denops.meta.host === "nvim" && !pluginStatus.vscode,
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("nvim-web-devicons").setup(_A)`, {
        default: true,
      });
    },
  },
  {
    url: "https://github.com/folke/noice.nvim",
    // deno-lint-ignore require-await
    enabled: async ({ denops }) =>
      denops.meta.host === "nvim" && !pluginStatus.vscode && denops.meta.platform !== "windows",
    dependencies: [
      { url: "https://github.com/MunifTanjim/nui.nvim" },
      { url: "https://github.com/rcarriga/nvim-notify" },
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
          command_palette: false,
          long_message_to_split: true,
          inc_rename: false,
          lsp_doc_border: false,
        },
        cmdline: {
          view: "cmdline",
        },
      });
    },
  },
  { url: "https://github.com/kana/vim-repeat" },
  { url: "https://github.com/mattn/vim-findroot" },
  {
    url: "https://github.com/tyru/open-browser.vim",
    before: async ({ denops }) => {
      await vars.g.set(denops, "netrw_nogx", 1);
      await mapping.map(denops, "gx", "<Plug>(openbrowser-smart-search)", { mode: ["n", "x"] });
    },
  },
  { url: "https://github.com/lambdalisue/readablefold.vim" },
  { url: "https://github.com/lambdalisue/kensaku.vim" },
  {
    url: "https://github.com/ryanoasis/vim-devicons",
    // deno-lint-ignore require-await
    enabled: async ({ denops }) => denops.meta.host === "vim",
    // deno-lint-ignore require-await
    clone: async ({ denops }) => denops.meta.host === "vim",
  },
  {
    url: "https://github.com/folke/which-key.nvim",
    // deno-lint-ignore require-await
    enabled: async ({ denops }) => denops.meta.host === "nvim" && !pluginStatus.vscode && false,
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
      await exists(ensure(await fn.expand(denops, "~/.codeium"), is.String)),
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
    // deno-lint-ignore require-await
    enabled: async ({ denops }) => denops.meta.host === "nvim" && !pluginStatus.vscode,
    afterFile: "~/.config/nvim/rc/after/nvim-dansa.lua",
  },
  { url: "https://github.com/yuki-yano/dedent-yank.vim" },
];
