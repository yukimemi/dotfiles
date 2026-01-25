// =============================================================================
// File        : edit.ts
// Author      : yukimemi
// Last Change : 2026/01/18 02:44:49.
// =============================================================================

import type { Plug } from "@yukimemi/dvpm";

import * as autocmd from "@denops/std/autocmd";
import * as fn from "@denops/std/function";
import { execute } from "@denops/std/helper";
import * as mapping from "@denops/std/mapping";
import * as vars from "@denops/std/variable";

import { ensureDir } from "@std/fs/ensure-dir";
import { z } from "zod";
import { pluginStatus, selections } from "../pluginstatus.ts";

export const edit: Plug[] = [
  {
    url: "https://github.com/editorconfig/editorconfig-vim",
    // deno-lint-ignore require-await
    enabled: async ({ denops }) => denops.meta.host === "vim",
    profiles: ["core"],
    // deno-lint-ignore require-await
    clone: async ({ denops }) => denops.meta.host === "vim",
  },
  {
    url: "https://github.com/monaqa/dial.nvim",
    profiles: ["core"],
    after: async ({ denops }) => {
      await mapping.map(denops, "<c-a>", `<Plug>(dial-increment)`, {
        mode: "n",
      });
      await mapping.map(denops, "<c-x>", `<Plug>(dial-decrement)`, {
        mode: "n",
      });
      await mapping.map(denops, "g<c-a>", `g<Plug>(dial-increment)`, {
        mode: "n",
      });
      await mapping.map(denops, "g<c-x>", `g<Plug>(dial-decrement)`, {
        mode: "n",
      });
    },
    afterFile: "~/.config/nvim/rc/after/dial.lua",
  },
  {
    url: "https://github.com/windwp/nvim-autopairs",
    enabled: selections.pairs === "autopairs",
    profiles: ["core"],
    after: async ({ denops }) => {
      await execute(denops, `lua require("nvim-autopairs").setup()`);
    },
  },
  {
    url: "https://github.com/hrsh7th/nvim-insx",
    enabled: selections.pairs === "insx",
    profiles: ["core"],
    after: async ({ denops }) => {
      await denops.cmd(`lua require('insx.preset.standard').setup()`);
    },
  },
  {
    url: "https://github.com/altermo/ultimate-autopair.nvim",
    enabled: selections.pairs === "ultimatepair",
    profiles: ["core"],
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require('ultimate-autopair').setup()`);
    },
  },
  {
    url: "https://github.com/Shougo/context_filetype.vim",
    profiles: ["core"],
  },
  {
    url: "https://github.com/uga-rosa/contextment.vim",
    profiles: ["core"],
    dependencies: ["https://github.com/Shougo/context_filetype.vim"],
    before: async ({ denops }) => {
      await mapping.map(denops, "gcc", "<Plug>(contextment)", { mode: "x" });
      await mapping.map(denops, "gcc", "<Plug>(contextment-line)", {
        mode: "n",
      });
    },
  },
  {
    url: "https://github.com/gbprod/yanky.nvim",
    enabled: pluginStatus.yanky,
    profiles: ["yank"],
    after: async ({ denops }) => {
      await mapping.map(denops, "p", "<Plug>(YankyPutAfter)", {
        mode: ["n", "x"],
      });
      await mapping.map(denops, "P", "<Plug>(YankyPutBefore)", {
        mode: ["n", "x"],
      });
      await mapping.map(denops, "gp", "<Plug>(YankyGPutAfter)", {
        mode: ["n", "x"],
      });
      await mapping.map(denops, "gP", "<Plug>(YankyGPutBefore)", {
        mode: ["n", "x"],
      });
      await mapping.map(denops, "<c-n>", "<Plug>(YankyCycleForward)", {
        mode: "n",
      });
      await mapping.map(denops, "<c-p>", "<Plug>(YankyCycleBackward)", {
        mode: "n",
      });
      await denops.call(`luaeval`, `require("yanky").setup(_A)`, {
        ring: {
          history_length: 3000,
          storage: "shada",
          sync_with_numbered_registers: true,
          cancel_event: "update",
        },
        system_clipboard: {
          sync_with_ring: true,
        },
      });
    },
  },
  {
    url: "https://github.com/LeafCage/yankround.vim",
    enabled: pluginStatus.yankround,
    profiles: ["yank"],
    before: async ({ denops }) => {
      await ensureDir(
        z.string().parse(await fn.expand(denops, `~/.cache/yankround`)),
      );
    },
    after: async ({ denops }) => {
      await vars.g.set(denops, "yankround_max_history", 10000);
      await vars.g.set(denops, "yankround_use_region_hl", 1);
      await vars.g.set(
        denops,
        "yankround_dir",
        await fn.expand(denops, "~/.cache/yankround"),
      );

      await mapping.map(denops, "p", "<Plug>(yankround-p)", {
        mode: ["n", "x"],
      });
      await mapping.map(denops, "P", "<Plug>(yankround-P)", { mode: "n" });

      await mapping.map(
        denops,
        "<c-n>",
        `yankround#is_active() ? "<Plug>(yankround-next)" : "gt"`,
        { mode: "n", expr: true },
      );
      await mapping.map(
        denops,
        "<c-p>",
        `yankround#is_active() ? "<Plug>(yankround-prev)" : "<cmd>Clap<cr>"`,
        { mode: "n", expr: true },
      );
    },
  },
  {
    url: "https://github.com/yuki-yano/haritsuke.vim",
    enabled: pluginStatus.haritsuke,
    profiles: ["core"],
    afterFile: `~/.config/nvim/rc/after/haritsuke.lua`,
  },
  {
    url: "https://github.com/thinca/vim-qfreplace",
    enabled: pluginStatus.qfreplace,
    profiles: ["quickfix"],
    before: async ({ denops }) => {
      await vars.g.set(denops, "qfreplace_no_save", 0);
    },
  },
  {
    url: "https://github.com/tani/vim-typo",
    enabled: false,
    profiles: ["core"],
    before: async ({ denops }) => {
      await autocmd.group(denops, "MyTypoSettings", (helper) => {
        helper.remove("*");
        helper.define(
          "FileType",
          [
            "ctrlp",
            "ddu-ff",
            "ddu-ff-filter",
            "ddu-filer",
            "scanwalker",
            "scanwalker-filter",
            "list",
            "qf",
            "quickfix",
          ],
          `let b:typo_did_setup = 1`,
        );
      });
    },
  },
  {
    url: "https://github.com/VidocqH/auto-indent.nvim",
    enabled: false,
    profiles: ["core"],
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("auto-indent").setup()`);
    },
  },
  {
    url: "https://github.com/andrewferrier/wrapping.nvim",
    enabled: false,
    profiles: ["core"],
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("wrapping").setup()`);
    },
  },
  {
    url: "https://github.com/qwavies/smart-backspace.nvim",
    enabled: false,
    profiles: ["core"],
  },
  {
    url: "https://github.com/ysmb-wtsg/in-and-out.nvim",
    profiles: ["core"],
    afterFile: `~/.config/nvim/rc/after/in-and-out.lua`,
  },
  {
    url: "https://github.com/kana/vim-niceblock",
    profiles: ["core"],
  },
  {
    url: "https://github.com/chrisgrieser/nvim-chainsaw",
    profiles: ["core"],
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("chainsaw").setup()`);
    },
  },
  {
    url: "https://github.com/kako-jun/chillout.nvim",
    profiles: ["core"],
  },
  {
    url: "https://github.com/kako-jun/chunkundo.nvim",
    profiles: ["core"],
    dependencies: ["https://github.com/kako-jun/chillout.nvim"],
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("chunkundo").setup()`);
    },
  },
  {
    url: "https://github.com/junegunn/vim-easy-align",
    enabled: true,
    profiles: ["core"],
    before: async ({ denops }) => {
      await mapping.map(denops, "<enter>", "<Plug>(EasyAlign)", { mode: "v" });
      await vars.g.set(denops, "easy_align_delimiters", {
        ">": {
          "pattern": ">>\|=>\|>.\+",
          "right_margin": 0,
          "delimiter_align": "l",
        },
        "/": {
          "pattern": "//\+\|/\*\|\*/",
          "delimiter_align": "l",
          "ignore_groups": ["!Comment"],
        },
        ".": {
          "pattern": "/",
          "left_margin": 1,
          "right_margin": 1,
          "stick_to_left": 0,
          "ignore_groups": [],
        },
        "]": {
          "pattern": "[[\]]",
          "left_margin": 0,
          "right_margin": 0,
          "stick_to_left": 0,
        },
        ")": {
          "pattern": "[()]",
          "left_margin": 0,
          "right_margin": 0,
          "stick_to_left": 0,
        },
        "d": {
          "pattern": " \(\S\+\s*[;=]\)\@=",
          "left_margin": 0,
          "right_margin": 0,
        },
        "p": {
          "pattern": "pos=\|size=",
          "right_margin": 0,
        },
        "s": {
          "pattern": "sys=\|Trns=",
          "right_margin": 0,
        },
        "k": {
          "pattern": "key=\|cmt=",
          "right_margin": 0,
        },
        "c": {
          "pattern": "cmt=",
          "right_margin": 0,
        },
        ":": {
          "pattern": ":",
          "left_margin": 0,
          "right_margin": 1,
          "stick_to_left": 0,
          "ignore_groups": [],
        },
        "t": {
          "pattern": "\<tab>",
          "left_margin": 0,
          "right_margin": 0,
        },
        ";": {
          "pattern": ";",
          "left_margin": 1,
          "right_margin": 1,
          "stick_to_left": 0,
          "ignore_groups": [],
        },
        "|": {
          "pattern": "|",
          "left_margin": 1,
          "right_margin": 1,
          "stick_to_left": 0,
          "ignore_groups": [],
        },
      });
    },
  },
  {
    url: "https://github.com/kana/vim-repeat",
    enabled: true,
    profiles: ["core"],
  },
];
