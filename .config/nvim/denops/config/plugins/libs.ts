// =============================================================================
// File        : libs.ts
// Author      : yukimemi
// Last Change : 2026/01/18 01:35:42.
// =============================================================================

import type { Plug } from "@yukimemi/dvpm";

import * as autocmd from "@denops/std/autocmd";
import * as mapping from "@denops/std/mapping";
import * as vars from "@denops/std/variable";

import { selections } from "../pluginstatus.ts";

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
      if ((info.isInstalled || info.isUpdated) && info.isLoaded) {
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
    url: "https://github.com/kamalsacranie/nvim-mapper",
    profiles: ["core"],
    cache: { enabled: true },
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
    url: "https://github.com/lambdalisue/vim-findent",
    enabled: selections.detect_indent === "findent",
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
    enabled: selections.detect_indent === "dansa",
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
