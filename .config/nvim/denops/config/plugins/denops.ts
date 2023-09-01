// =============================================================================
// File        : denops.ts
// Author      : yukimemi
// Last Change : 2023/09/01 22:36:22.
// =============================================================================

import type { Plug } from "https://deno.land/x/dvpm@3.3.0/mod.ts";

import * as autocmd from "https://deno.land/x/denops_std@v5.0.1/autocmd/mod.ts";
import * as fn from "https://deno.land/x/denops_std@v5.0.1/function/mod.ts";
import * as lambda from "https://deno.land/x/denops_std@v5.0.1/lambda/mod.ts";
import * as mapping from "https://deno.land/x/denops_std@v5.0.1/mapping/mod.ts";
import * as nvimFn from "https://deno.land/x/denops_std@v5.0.1/function/nvim/mod.ts";
import * as option from "https://deno.land/x/denops_std@v5.0.1/option/mod.ts";
import { globals } from "https://deno.land/x/denops_std@v5.0.1/variable/mod.ts";
import { pluginStatus } from "../main.ts";

export const denops: Plug[] = [
  {
    url: "yukimemi/dps-autocursor",
    enabled: !pluginStatus.vscode,
    dst: "~/src/github.com/yukimemi/dps-autocursor",
    before: async ({ denops }) => {
      await globals.set(denops, "autocursor_debug", false);
      await globals.set(denops, "autocursor_notify", false);
      await globals.set(denops, "autocursor_ignore_filetypes", [
        "ctrlp",
        "ddu-ff",
        "ddu-ff-filter",
        "ddu-filer",
        "dpswalk",
        "list",
        "qf",
        "quickfix",
      ]);
    },
  },
  {
    url: "yukimemi/dps-autobackup",
    dst: "~/src/github.com/yukimemi/dps-autobackup",
    before: async ({ denops }) => {
      await globals.set(denops, "autobackup_debug", false);
      await globals.set(denops, "autobackup_enable", true);
      await globals.set(denops, "autobackup_echo", false);
      await globals.set(denops, "autobackup_notify", true);
      await globals.set(denops, "autobackup_use_ui_select", false);
      await globals.set(denops, "autobackup_ignore_filetypes", [
        "csv",
        "ctrlp",
        "ddu-ff",
        "ddu-ff-filter",
        "ddu-filer",
        "dpswalk",
        "gin-diff",
        "gin-status",
        "list",
        "log",
        "qf",
        "quickfix",
      ]);
    },
  },
  {
    url: "yukimemi/dps-asyngrep",
    enabled: !pluginStatus.vscode,
    dst: "~/src/github.com/yukimemi/dps-asyngrep",
    before: async ({ denops }) => {
      await globals.set(denops, "asyngrep_debug", false);
      await globals.set(
        denops,
        "asyngrep_cfg_path",
        await fn.expand(denops, "~/.config/asyngrep/asyngrep.toml"),
      );
      await option.grepformat.set(denops, "%f:%l:%c:%m");

      await mapping.map(denops, "<space>ss", "<cmd>Agp<cr>", { mode: "n" });
      await mapping.map(denops, "<space>sr", "<cmd>Agp --tool=ripgrep<cr>", {
        mode: "n",
      });
      await mapping.map(denops, "<space>sp", "<cmd>Agp --tool=pt<cr>", {
        mode: "n",
      });
      await mapping.map(denops, "<space>sj", "<cmd>Agp --tool=jvgrep<cr>", {
        mode: "n",
      });

      await mapping.map(
        denops,
        "<space>sS",
        "<cmd>Agp --tool=default-all<cr>",
        { mode: "n" },
      );
      await mapping.map(
        denops,
        "<space>sR",
        "<cmd>Agp --tool=ripgrep-all<cr>",
        { mode: "n" },
      );
      await mapping.map(denops, "<space>sP", "<cmd>Agp --tool=pt-all<cr>", {
        mode: "n",
      });
      await mapping.map(denops, "<space>sJ", "<cmd>Agp --tool=jvgrep-all<cr>", {
        mode: "n",
      });
    },
  },
  {
    url: "yukimemi/dps-chronicle",
    dst: "~/src/github.com/yukimemi/dps-chronicle",
    cache: {
      enabled: false,
      before: `
        let g:chronicle_echo = v:false
        let g:chronicle_notify = v:true
        let g:chronicle_read_path = '~/.cache/chronicle/read'
        let g:chronicle_write_path = '~/.cache/chronicle/write'
        nnoremap mr <cmd>OpenChronicleRead<cr>
        nnoremap mw <cmd>OpenChronicleWrite<cr>
      `,
    },
    before: async ({ denops }) => {
      await globals.set(denops, "chronicle_debug", false);
      await globals.set(denops, "chronicle_echo", false);
      await globals.set(denops, "chronicle_notify", false);
      await globals.set(denops, "chronicle_read_path", `~/.cache/chronicle/read`);
      await globals.set(denops, "chronicle_write_path", `~/.cache/chronicle/write`);
      await mapping.map(denops, "mr", "<cmd>OpenChronicleRead<cr>", { mode: "n" });
      await mapping.map(denops, "mw", "<cmd>OpenChronicleWrite<cr>", { mode: "n" });
    },
  },
  {
    url: "yukimemi/dps-autodate",
    dst: "~/src/github.com/yukimemi/dps-autodate",
    before: async ({ denops }) => {
      await globals.set(denops, "autodate_debug", false);
      await globals.set(denops, "autodate_notify", true);
      await globals.set(denops, "autodate_config", {
        xml: {
          replace: [
            [
              '/^(.*key="version">)[^<]*(<.*)/i',
              '$1${format(now, "yyyyMMdd_HHmmss")}$2',
            ],
            [
              '/^(.*key="%{task_file}%_version">)[^<]*(<.*)/i',
              '$1${format(now, "yyyyMMdd_HHmmss")}$2',
            ],
            [
              '/^(.*key="%{task_name}%_version">)[^<]*(<.*)/i',
              '$1${format(now, "yyyyMMdd_HHmmss")}$2',
            ],
            [
              '/^(.*key="autobot_version">)[^<]*(<.*)/i',
              '$1${format(now, "yyyyMMdd_HHmmss")}$2',
            ],
          ],
          event: "BufWritePre",
          pat: ["*.xml", "*.xaml"],
          head: 30,
          tail: 5,
        },
        ps1: {
          replace: [
            [
              "/^(s*.Last Change: ).*/i",
              '$1${format(now, "yyyy/MM/dd HH:mm:ss")}',
            ],
            [
              '/^(.*"version", ")[0-9_]+(".*)/i',
              '$1${format(now, "yyyyMMdd_HHmmss")}$2',
            ],
          ],
          event: "BufWritePre",
          pat: ["*.ps1"],
          head: 50,
          tail: 5,
        },
        typescript: {
          replace: [
            [
              '/^(const version = ")[0-9_]+(";)/',
              '$1${format(now, "yyyyMMdd_HHmmss")}$2',
            ],
          ],
          event: "BufWritePre",
          pat: ["*.ts"],
          head: 50,
          tail: 5,
        },
      });
    },
  },
  {
    url: "yukimemi/dps-walk",
    enabled: !pluginStatus.vscode,
    dst: "~/src/github.com/yukimemi/dps-walk",
    before: async ({ denops }) => {
      await globals.set(denops, "walk_debug", false);
      await globals.set(denops, "walk_no_mapping", false);

      await mapping.map(denops, "mW", "<cmd>DenopsWalk<cr>", {
        mode: "n",
      });
      await mapping.map(
        denops,
        "ms",
        "<cmd>DenopsWalk --path=~/src<cr>",
        { mode: "n" },
      );
      await mapping.map(
        denops,
        "mD",
        "<cmd>DenopsWalk --path=~/.dotfiles<cr>",
        { mode: "n" },
      );
      await mapping.map(denops, "md", "<cmd>DenopsWalkBufferDir<cr>", {
        mode: "n",
      });

      await mapping.map(
        denops,
        "<space>wm",
        "<cmd>DenopsWalk --path=~/.memolist<cr>",
        { mode: "n" },
      );

      await mapping.map(
        denops,
        "<space>wc",
        "<cmd>DenopsWalk --path=~/.cache<cr>",
        { mode: "n" },
      );
      await mapping.map(
        denops,
        "<space>wj",
        "<cmd>DenopsWalk --path=~/.cache/junkfile<cr>",
        { mode: "n" },
      );
    },
  },
  {
    url: "yukimemi/dps-randomcolorscheme",
    enabled: !pluginStatus.vscode,
    dst: "~/src/github.com/yukimemi/dps-randomcolorscheme",
    dependencies: [
      { url: "4513ECHO/vim-colors-hatsunemiku" },
      { url: "ChristianChiarulli/nvcode-color-schemes.vim" },
      { url: "KeitaNakamura/neodark.vim" },
      { url: "NLKNguyen/papercolor-theme" },
      { url: "PHSix/nvim-hybrid" },
      { url: "adrian5/oceanic-next-vim" },
      { url: "bluz71/vim-nightfly-guicolors" },
      { url: "cocopon/iceberg.vim" },
      { url: "doums/darcula" },
      { url: "drewtempelmeyer/palenight.vim" },
      { url: "fenetikm/falcon" },
      { url: "gkeep/iceberg-dark" },
      { url: "joshdick/onedark.vim" },
      { url: "kjssad/quantum.vim" },
      { url: "rafamadriz/neon" },
      { url: "rafi/awesome-vim-colorschemes" },
      { url: "rhysd/vim-color-spring-night" },
      { url: "sainnhe/edge" },
      { url: "sainnhe/gruvbox-material" },
      { url: "severij/vadelma" },
      { url: "srcery-colors/srcery-vim" },
      { url: "aereal/vim-colors-japanesque" },
      { url: "yuttie/hydrangea-vim" },
      { url: "Rigellute/rigel" },
      { url: "kyoh86/momiji" },
      { url: "sigmavim/kyotonight" },
      {
        url: "rhysd/vim-color-splatoon",
        // deno-lint-ignore require-await
        enabled: async ({ denops }) => denops.meta.host === "vim",
      },
      {
        url: "Matsuuu/pinkmare",
        // deno-lint-ignore require-await
        enabled: async ({ denops }) => denops.meta.host === "nvim",
      },
      {
        url: "lourenci/github-colors",
        // deno-lint-ignore require-await
        enabled: async ({ denops }) => denops.meta.host === "nvim",
      },
      {
        url: "rebelot/kanagawa.nvim",
        // deno-lint-ignore require-await
        enabled: async ({ denops }) => denops.meta.host === "nvim",
      },
      {
        url: "folke/tokyonight.nvim",
        // deno-lint-ignore require-await
        enabled: async ({ denops }) => denops.meta.host === "nvim",
      },
      {
        url: "glepnir/zephyr-nvim",
        // deno-lint-ignore require-await
        enabled: async ({ denops }) => denops.meta.host === "nvim",
      },
      {
        url: "tiagovla/tokyodark.nvim",
        // deno-lint-ignore require-await
        enabled: async ({ denops }) => denops.meta.host === "nvim",
      },
      {
        url: "marko-cerovac/material.nvim",
        // deno-lint-ignore require-await
        enabled: async ({ denops }) => denops.meta.host === "nvim",
      },
      {
        url: "RRethy/nvim-base16",
        // deno-lint-ignore require-await
        enabled: async ({ denops }) => denops.meta.host === "nvim",
      },
      {
        url: "catppuccin/nvim",
        // deno-lint-ignore require-await
        enabled: async ({ denops }) => denops.meta.host === "nvim",
      },
      {
        url: "rose-pine/neovim",
        // deno-lint-ignore require-await
        enabled: async ({ denops }) => denops.meta.host === "nvim",
      },
      {
        url: "Allianaab2m/penumbra.nvim",
        // deno-lint-ignore require-await
        enabled: async ({ denops }) => denops.meta.host === "nvim",
      },
      {
        url: "kihachi2000/yash.nvim",
        // deno-lint-ignore require-await
        enabled: async ({ denops }) => denops.meta.host === "nvim",
      },
    ],
    before: async ({ denops }) => {
      await globals.set(denops, "randomcolorscheme_debug", false);
      await globals.set(denops, "randomcolorscheme_echo", false);
      await globals.set(denops, "randomcolorscheme_notify", true);
      if (denops.meta.platform === "windows") {
        await globals.set(denops, "randomcolorscheme_interval", 1800);
      } else {
        await globals.set(denops, "randomcolorscheme_interval", 77);
      }
      // await globals.set(denops, "randomcolorscheme_checkwait", 30000);
      await globals.set(denops, "randomcolorscheme_disables", [
        "evening",
        "default",
        "blue",
      ]);
      await globals.set(
        denops,
        "randomcolorscheme_path",
        await fn.expand(denops, "~/.config/randomcolorscheme/colorscheme.toml"),
      );
      await globals.set(denops, "randomcolorscheme_notmatch", "[Ll]ight");
      await globals.set(denops, "randomcolorscheme_background", "dark");

      await mapping.map(denops, "<space>ro", "<cmd>ChangeColorscheme<cr>", {
        mode: "n",
      });
      await mapping.map(
        denops,
        "<space>rd",
        "<cmd>DisableThisColorscheme<cr>",
        { mode: "n" },
      );
      await mapping.map(denops, "<space>rl", "<cmd>LikeThisColorscheme<cr>", {
        mode: "n",
      });
      await mapping.map(denops, "<space>rh", "<cmd>HateThisColorscheme<cr>", {
        mode: "n",
      });
    },
  },
  {
    url: "yukimemi/dps-hitori",
    dst: "~/src/github.com/yukimemi/dps-hitori",
    // deno-lint-ignore require-await
    enabled: async ({ denops }) => denops.meta.host === "nvim",
    before: async ({ denops }) => {
      await globals.set(denops, "hitori_debug", false);
      await globals.set(denops, "hitori_enable", true);
      await globals.set(denops, "hitori_quit", true);

      await globals.set(denops, "hitori_ignore_patterns", [
        ".tmp$",
        ".diff$",
        ".dump$",
        "(COMMIT_EDIT|TAG_EDIT|MERGE_|SQUASH_)MSG$",
      ]);
    },
  },
  {
    url: "yukimemi/dps-ahdr",
    dst: "~/src/github.com/yukimemi/dps-ahdr",
    before: async ({ denops }) => {
      await globals.set(denops, "ahdr_debug", false);
      await globals.set(denops, "ahdr_cfg_path", "~/.config/ahdr/ahdr.toml");

      await nvimFn.nvim_create_user_command(
        denops,
        "DenopsAhdrDebug",
        `call denops#notify("${denops.name}", "${
          lambda.register(
            denops,
            async () => {
              await autocmd.group(denops, "MyAhdr", (helper) => {
                helper.remove("*");
                helper.define(
                  "BufWritePost",
                  "<buffer>",
                  "DenopsAhdr waitcmd",
                  {},
                );
              });
            },
          )
        }", [])`,
        {},
      );
    },
  },
];
