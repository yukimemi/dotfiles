// =============================================================================
// File        : edit.ts
// Author      : yukimemi
// Last Change : 2024/03/31 15:07:53.
// =============================================================================

import type { Plug } from "https://deno.land/x/dvpm@3.10.1/mod.ts";

import * as autocmd from "https://deno.land/x/denops_std@v6.4.0/autocmd/mod.ts";
import * as fn from "https://deno.land/x/denops_std@v6.4.0/function/mod.ts";
import * as vars from "https://deno.land/x/denops_std@v6.4.0/variable/mod.ts";
import * as mapping from "https://deno.land/x/denops_std@v6.4.0/mapping/mod.ts";
import { execute } from "https://deno.land/x/denops_std@v6.4.0/helper/mod.ts";

import { pluginStatus } from "../pluginstatus.ts";
import { ensureDir } from "https://deno.land/std@0.223.0/fs/ensure_dir.ts";
import { z } from "https://deno.land/x/zod@v3.23.0-beta.0/mod.ts";

export const edit: Plug[] = [
  {
    url: "https://github.com/editorconfig/editorconfig-vim",
    // deno-lint-ignore require-await
    enabled: async ({ denops }) => denops.meta.host === "vim",
    // deno-lint-ignore require-await
    clone: async ({ denops }) => denops.meta.host === "vim",
  },
  {
    url: "https://github.com/monaqa/dial.nvim",
    afterFile: "~/.config/nvim/rc/after/dial.lua",
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
  },
  {
    url: "https://github.com/windwp/nvim-autopairs",
    enabled: pluginStatus.autopairs && !pluginStatus.vscode,
    after: async ({ denops }) => {
      await execute(denops, `lua require("nvim-autopairs").setup()`);
    },
  },
  {
    url: "https://github.com/hrsh7th/nvim-insx",
    enabled: pluginStatus.insx && !pluginStatus.vscode,
    after: async ({ denops }) => {
      await denops.cmd(`lua require('insx.preset.standard').setup()`);
    },
  },
  {
    url: "https://github.com/altermo/ultimate-autopair.nvim",
    enabled: pluginStatus.ultimatepair && !pluginStatus.vscode,
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require('ultimate-autopair').setup()`);
    },
  },
  {
    url: "https://github.com/uga-rosa/contextment.vim",
    dependencies: [{ url: "https://github.com/Shougo/context_filetype.vim" }],
    before: async ({ denops }) => {
      await mapping.map(denops, "gcc", "<Plug>(contextment)", { mode: "x" });
      await mapping.map(denops, "gcc", "<Plug>(contextment-line)", {
        mode: "n",
      });
    },
  },
  {
    url: "https://github.com/gbprod/yanky.nvim",
    enabled: pluginStatus.yanky && !pluginStatus.vscode,
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
          history_length: 300,
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
    enabled: pluginStatus.yankround && !pluginStatus.vscode,
    before: async ({ denops }) => {
      await ensureDir(z.string().parse(await fn.expand(denops, `~/.cache/yankround`)));
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
        `yankround#is_active() ? "<Plug>(yankround-prev)" : "gt"`,
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
  { url: "https://github.com/thinca/vim-qfreplace" },
  { url: "https://github.com/itchyny/vim-qfedit" },
  {
    url: "https://github.com/tani/vim-typo",
    enabled: false,
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
            "dpswalk",
            "dpswalk-filter",
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
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("auto-indent").setup()`);
    },
  },
  {
    url: "https://github.com/andrewferrier/wrapping.nvim",
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("wrapping").setup()`);
    },
  },
];
