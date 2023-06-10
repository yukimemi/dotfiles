import type { Denops } from "https://deno.land/x/denops_std@v5.0.0/mod.ts";
import type { Plug } from "https://deno.land/x/dvpm@0.4.5/mod.ts";

import * as autocmd from "https://deno.land/x/denops_std@v5.0.0/autocmd/mod.ts";
import * as fn from "https://deno.land/x/denops_std@v5.0.0/function/mod.ts";
import * as lambda from "https://deno.land/x/denops_std@v5.0.0/lambda/mod.ts";
import * as mapping from "https://deno.land/x/denops_std@v5.0.0/mapping/mod.ts";
import * as nvimFn from "https://deno.land/x/denops_std@v5.0.0/function/nvim/mod.ts";
import * as option from "https://deno.land/x/denops_std@v5.0.0/option/mod.ts";
import { globals } from "https://deno.land/x/denops_std@v5.0.0/variable/mod.ts";
import { notify } from "../util.ts";

export const denops: Plug[] = [
  {
    url: "yukimemi/dps-autocursor",
    dst: "~/src/github.com/yukimemi/dps-autocursor",
    before: async (denops: Denops) => {
      await globals.set(denops, "autocursor_debug", false);
      await globals.set(denops, "autocursor_blacklist_filetypes", [
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
    before: async (denops: Denops) => {
      await globals.set(denops, "autobackup_debug", false);
      await globals.set(denops, "autobackup_enable", true);
      await globals.set(denops, "autobackup_write_echo", false);
      await globals.set(denops, "autobackup_use_ui_select", false);
      await globals.set(denops, "autobackup_blacklist_filetypes", [
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
    dst: "~/src/github.com/yukimemi/dps-asyngrep",
    before: async (denops: Denops) => {
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
    url: "yukimemi/dps-autodate",
    dst: "~/src/github.com/yukimemi/dps-autodate",
    before: async (denops: Denops) => {
      await globals.set(denops, "autodate_debug", false);
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
    dst: "~/src/github.com/yukimemi/dps-walk",
    before: async (denops: Denops) => {
      await globals.set(denops, "walk_debug", false);

      await mapping.map(denops, "<space>Wa", "<cmd>DenopsWalk<cr>", {
        mode: "n",
      });

      await mapping.map(denops, "<space>Wa", "<cmd>DenopsWalk<cr>", {
        mode: "n",
      });
      await mapping.map(
        denops,
        "<space>Ws",
        "<cmd>DenopsWalk --path=~/src<cr>",
        { mode: "n" },
      );
      await mapping.map(
        denops,
        "<space>Wd",
        "<cmd>DenopsWalk --path=~/.dotfiles<cr>",
        { mode: "n" },
      );
      await mapping.map(
        denops,
        "<space>Wc",
        "<cmd>DenopsWalk --path=~/.cache<cr>",
        { mode: "n" },
      );
      await mapping.map(
        denops,
        "<space>Wj",
        "<cmd>DenopsWalk --path=~/.cache/junkfile<cr>",
        { mode: "n" },
      );
      await mapping.map(
        denops,
        "<space>Wm",
        "<cmd>DenopsWalk --path=~/.memolist<cr>",
        { mode: "n" },
      );
      await mapping.map(denops, "<space>WD", "<cmd>DenopsWalkBufferDir<cr>", {
        mode: "n",
      });
    },
  },
  {
    url: "yukimemi/dps-randomcolorscheme",
    dst: "~/src/github.com/yukimemi/dps-randomcolorscheme",
    dependencies: [
      { url: "4513ECHO/vim-colors-hatsunemiku" },
      { url: "ChristianChiarulli/nvcode-color-schemes.vim" },
      { url: "Matsuuu/pinkmare" },
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
      { url: "rhysd/vim-color-splatoon" },
      { url: "rhysd/vim-color-spring-night" },
      { url: "sainnhe/edge" },
      { url: "sainnhe/gruvbox-material" },
      { url: "severij/vadelma" },
      { url: "srcery-colors/srcery-vim" },
      { url: "yuttie/hydrangea-vim" },
      {
        url: "folke/tokyonight.nvim",
        enabled: async (denops: Denops) => await fn.has(denops, "nvim"),
      },
      {
        url: "glepnir/zephyr-nvim",
        enabled: async (denops: Denops) => await fn.has(denops, "nvim"),
      },
      {
        url: "tiagovla/tokyodark.nvim",
        enabled: async (denops: Denops) => await fn.has(denops, "nvim"),
      },
      {
        url: "marko-cerovac/material.nvim",
        enabled: async (denops: Denops) => await fn.has(denops, "nvim"),
      },
      {
        url: "RRethy/nvim-base16",
        enabled: async (denops: Denops) => await fn.has(denops, "nvim"),
      },
      {
        url: "catppuccin/nvim",
        enabled: async (denops: Denops) => await fn.has(denops, "nvim"),
      },
    ],
    before: async (denops: Denops) => {
      await globals.set(denops, "randomcolorscheme_debug", false);
      await globals.set(denops, "randomcolorscheme_echo", true);
      await globals.set(denops, "randomcolorscheme_interval", 77);
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
    before: async (denops: Denops) => {
      await globals.set(denops, "hitori_debug", false);
      await globals.set(denops, "hitori_enable", true);
      await globals.set(denops, "hitori_quit", true);

      await globals.set(denops, "hitori_blacklist_patterns", [
        ".tmp$",
        ".diff$",
        "(COMMIT_EDIT|TAG_EDIT|MERGE_|SQUASH_)MSG$",
      ]);
    },
    after: async (denops: Denops) => {
      await notify(denops, "dps-hitori loaded");
    },
  },
  {
    url: "yukimemi/dps-ahdr",
    dst: "~/src/github.com/yukimemi/dps-ahdr",
    enabled: async (denops: Denops) => await fn.has(denops, "nvim"),
    before: async (denops: Denops) => {
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
