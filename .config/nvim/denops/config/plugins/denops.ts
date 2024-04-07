// =============================================================================
// File        : denops.ts
// Author      : yukimemi
// Last Change : 2024/04/07 16:55:05.
// =============================================================================

import type { Plug } from "https://deno.land/x/dvpm@3.9.0/mod.ts";

import * as autocmd from "https://deno.land/x/denops_std@v6.4.0/autocmd/mod.ts";
import * as fn from "https://deno.land/x/denops_std@v6.4.0/function/mod.ts";
import * as lambda from "https://deno.land/x/denops_std@v6.4.0/lambda/mod.ts";
import * as mapping from "https://deno.land/x/denops_std@v6.4.0/mapping/mod.ts";
import * as nvimFn from "https://deno.land/x/denops_std@v6.4.0/function/nvim/mod.ts";
import * as option from "https://deno.land/x/denops_std@v6.4.0/option/mod.ts";
import * as vars from "https://deno.land/x/denops_std@v6.4.0/variable/mod.ts";
import { pluginStatus } from "../pluginstatus.ts";

export const denops: Plug[] = [
  {
    url: "https://github.com/yukimemi/autocursor.vim",
    enabled: !pluginStatus.vscode,
    dst: "~/src/github.com/yukimemi/autocursor.vim",
    before: async ({ denops }) => {
      await vars.g.set(denops, "autocursor_debug", false);
      await vars.g.set(denops, "autocursor_notify", false);
      await vars.g.set(denops, "autocursor_cursorline", {
        enable: true,
        events: [
          {
            name: [
              "BufEnter",
              "CmdwinLeave",
              "CursorHold",
              "CursorHoldI",
              "FocusGained",
              "FocusLost",
              "InsertLeave",
              "ModeChanged",
              "TextChanged",
              "VimResized",
              "WinEnter",
            ],
            set: true,
            wait: 0,
          },
          {
            name: [
              "CursorMoved",
              "CursorMovedI",
              "InsertEnter",
            ],
            set: false,
            wait: 3000,
          },
        ],
      });
      await vars.g.set(denops, "autocursor_cursorcolumn", {
        enable: true,
        events: [
          {
            name: [
              "BufEnter",
              "CmdwinLeave",
              "CursorHold",
              "CursorHoldI",
              "FocusGained",
              "FocusLost",
              "InsertLeave",
              "ModeChanged",
              "TextChanged",
              "VimResized",
              "WinEnter",
            ],
            set: true,
            wait: 0,
          },
          {
            name: [
              "CursorMoved",
              "CursorMovedI",
              "InsertEnter",
            ],
            set: false,
            wait: 3000,
          },
        ],
      });
      await vars.g.set(denops, "autocursor_ignore_filetypes", [
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
    url: "https://github.com/yukimemi/silentsaver.vim",
    dst: "~/src/github.com/yukimemi/silentsaver.vim",
    before: async ({ denops }) => {
      await vars.g.set(denops, "silentsaver_debug", false);
      await vars.g.set(denops, "silentsaver_enable", true);
      await vars.g.set(denops, "silentsaver_echo", false);
      await vars.g.set(denops, "silentsaver_notify", true);
      await vars.g.set(denops, "silentsaver_use_ui_select", false);
      await vars.g.set(denops, "silentsaver_events", [
        "CursorHold",
        "BufWritePre",
        "InsertLeave",
      ]);
      await vars.g.set(denops, "silentsaver_ignore_filetypes", [
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
    url: "https://github.com/yukimemi/dps-asyngrep",
    enabled: !pluginStatus.vscode,
    dst: "~/src/github.com/yukimemi/dps-asyngrep",
    before: async ({ denops }) => {
      await vars.g.set(denops, "asyngrep_debug", false);
      await vars.g.set(
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
    url: "https://github.com/yukimemi/chronicle.vim",
    dst: "~/src/github.com/yukimemi/chronicle.vim",
    cache: {
      enabled: true,
      beforeFile: "~/.config/nvim/rc/before/chronicle.vim",
      afterFile: "~/.config/nvim/rc/after/chronicle.vim",
    },
  },
  {
    url: "https://github.com/yukimemi/dps-autodate",
    dst: "~/src/github.com/yukimemi/dps-autodate",
    before: async ({ denops }) => {
      await vars.g.set(denops, "autodate_debug", false);
      await vars.g.set(denops, "autodate_notify", false);
      await vars.g.set(denops, "autodate_config", {
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
            [
              '/^(.*\\$version = ")[0-9_]+(".*)/i',
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
        toml: {
          replace: [
            [
              "/^(version = [\"'])[0-9_]+([\"'])/",
              '$1${format(now, "yyyyMMdd_HHmmss")}$2',
            ],
          ],
          event: "BufWritePre",
          pat: ["*.toml"],
          head: 50,
          tail: 5,
        },
      });
    },
  },
  {
    url: "https://github.com/yukimemi/scanwalker.vim",
    enabled: !pluginStatus.vscode,
    dst: "~/src/github.com/yukimemi/scanwalker.vim",
    before: async ({ denops }) => {
      await mapping.map(denops, "mw", "<cmd>ScanWalk<cr>", { mode: "n" });
      await mapping.map(denops, "ms", "<cmd>ScanWalk --path=~/src<cr>", { mode: "n" });
      await mapping.map(denops, "mD", "<cmd>ScanWalk --path=~/.dotfiles<cr>", { mode: "n" });
      await mapping.map(denops, "mC", "<cmd>ScanWalk --path=~/.cache<cr>", { mode: "n" });
      await mapping.map(denops, "md", "<cmd>ScanWalkBufferDir<cr>", { mode: "n" });
      await mapping.map(denops, "mM", "<cmd>ScanWalk --path=~/.memolist<cr>", {
        mode: "n",
      });
      await mapping.map(denops, "<space>wc", "<cmd>ScanWalk --path=~/.cache<cr>", { mode: "n" });
      await mapping.map(denops, "<space>wj", "<cmd>ScanWalk --path=~/.cache/junkfile<cr>", {
        mode: "n",
      });
    },
  },
  {
    url: "https://github.com/yukimemi/spectrism.vim",
    enabled: !pluginStatus.vscode,
    dst: "~/src/github.com/yukimemi/spectrism.vim",
    dependencies: [
      { url: "https://github.com/4513ECHO/vim-colors-hatsunemiku" },
      { url: "https://github.com/ChristianChiarulli/nvcode-color-schemes.vim" },
      { url: "https://github.com/KeitaNakamura/neodark.vim" },
      { url: "https://github.com/NLKNguyen/papercolor-theme" },
      { url: "https://github.com/liuchengxu/space-vim-dark" },
      { url: "https://github.com/PHSix/nvim-hybrid" },
      { url: "https://github.com/adrian5/oceanic-next-vim" },
      { url: "https://github.com/bluz71/vim-nightfly-guicolors" },
      { url: "https://github.com/cocopon/iceberg.vim" },
      { url: "https://github.com/doums/darcula" },
      { url: "https://github.com/drewtempelmeyer/palenight.vim" },
      { url: "https://github.com/fenetikm/falcon" },
      { url: "https://github.com/gkeep/iceberg-dark" },
      { url: "https://github.com/joshdick/onedark.vim" },
      { url: "https://github.com/kjssad/quantum.vim" },
      { url: "https://github.com/rafamadriz/neon" },
      { url: "https://github.com/rafi/awesome-vim-colorschemes" },
      { url: "https://github.com/rhysd/vim-color-spring-night" },
      { url: "https://github.com/sainnhe/edge" },
      { url: "https://github.com/sainnhe/gruvbox-material" },
      { url: "https://github.com/ellisonleao/gruvbox.nvim" },
      { url: "https://github.com/severij/vadelma" },
      { url: "https://github.com/srcery-colors/srcery-vim" },
      { url: "https://github.com/aereal/vim-colors-japanesque" },
      { url: "https://github.com/yuttie/hydrangea-vim" },
      { url: "https://github.com/Rigellute/rigel" },
      { url: "https://github.com/kyoh86/momiji" },
      { url: "https://github.com/Matsuuu/pinkmare" },
      { url: "https://github.com/sigmavim/kyotonight" },
      { url: "https://github.com/lourenci/github-colors" },
      { url: "https://github.com/rebelot/kanagawa.nvim" },
      { url: "https://github.com/folke/tokyonight.nvim" },
      { url: "https://github.com/glepnir/zephyr-nvim" },
      { url: "https://github.com/tiagovla/tokyodark.nvim" },
      { url: "https://github.com/marko-cerovac/material.nvim" },
      { url: "https://github.com/RRethy/nvim-base16" },
      { url: "https://github.com/catppuccin/nvim" },
      { url: "https://github.com/rose-pine/neovim" },
      { url: "https://github.com/Allianaab2m/penumbra.nvim" },
      { url: "https://github.com/kihachi2000/yash.nvim" },
      { url: "https://github.com/craftzdog/solarized-osaka.nvim" },
      { url: "https://github.com/arrow2nd/aqua" },
      { url: "https://github.com/oxfist/night-owl.nvim" },
      { url: "https://github.com/AlessandroYorba/Alduin" },
      {
        url: "https://github.com/crispybaccoon/evergarden",
        after: async ({ denops }) => {
          await denops.call(`luaeval`, `require("evergarden").setup(_A)`, {
            transparent_background: true,
            constrast_dark: "medium",
          });
        },
      },
      {
        url: "https://github.com/scottmckendry/cyberdream.nvim",
        after: async ({ denops }) => {
          await denops.call(`luaeval`, `require("cyberdream").setup(_A)`, {
            transparent: true,
            italic_comments: true,
            hide_fillchars: true,
            boarderless_telescope: true,
          });
        },
      },
    ],
    before: async ({ denops }) => {
      await vars.g.set(denops, "spectrism_debug", false);
      await vars.g.set(denops, "spectrism_echo", false);
      await vars.g.set(denops, "spectrism_notify", true);
      await vars.g.set(denops, "spectrism_interval", 100);
      // await globals.set(denops, "spectrism_checkwait", 30000);
      await vars.g.set(denops, "spectrism_disables", [
        "evening",
        "default",
        "blue",
      ]);
      await vars.g.set(
        denops,
        "spectrism_path",
        await fn.expand(denops, "~/.config/spectrism/colorscheme.toml"),
      );
      await vars.g.set(denops, "spectrism_notmatch", "[Ll]ight");
      await vars.g.set(denops, "spectrism_background", "dark");

      await mapping.map(denops, "<space>ro", "<cmd>ChangeColorscheme<cr>", {
        mode: "n",
      });
      await mapping.map(
        denops,
        "<space>rd",
        "<cmd>DisableThisColorscheme<cr>",
        { mode: "n" },
      );
      await mapping.map(denops, "ml", "<cmd>LikeThisColorscheme<cr>", {
        mode: "n",
      });
      await mapping.map(denops, "mh", "<cmd>HateThisColorscheme<cr>", {
        mode: "n",
      });
    },
  },
  {
    url: "https://github.com/yukimemi/hitori.vim",
    dst: "~/src/github.com/yukimemi/hitori.vim",
    before: async ({ denops }) => {
      await vars.g.set(denops, "hitori_debug", false);
      await vars.g.set(denops, "hitori_enable", true);
      await vars.g.set(denops, "hitori_quit", true);
      await vars.g.set(denops, "hitori_wsl", true);
      await vars.g.set(denops, "hitori_opener", "vsplit");

      await vars.g.set(denops, "hitori_ignore_patterns", [
        ".tmp$",
        ".diff$",
        ".dump$",
        ".jjdescription$",
        "(COMMIT_EDIT|TAG_EDIT|MERGE_|SQUASH_)MSG$",
      ]);
    },
  },
  {
    url: "https://github.com/yukimemi/dps-ahdr",
    dst: "~/src/github.com/yukimemi/dps-ahdr",
    before: async ({ denops }) => {
      await vars.g.set(denops, "ahdr_debug", false);
      await vars.g.set(denops, "ahdr_cfg_path", "~/.config/ahdr/ahdr.toml");

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
      await nvimFn.nvim_create_user_command(
        denops,
        "DenopsAhdrPwshDebug",
        `call denops#notify("${denops.name}", "${
          lambda.register(
            denops,
            async () => {
              await autocmd.group(denops, "MyAhdr", (helper) => {
                helper.remove("*");
                helper.define(
                  "BufWritePost",
                  "<buffer>",
                  "DenopsAhdr waitcmdpwsh",
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
