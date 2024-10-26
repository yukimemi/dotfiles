// =============================================================================
// File        : denops.ts
// Author      : yukimemi
// Last Change : 2024/10/23 00:29:52.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@5.0.9";

import * as autocmd from "jsr:@denops/std@7.3.0/autocmd";
import * as fn from "jsr:@denops/std@7.3.0/function";
import * as lambda from "jsr:@denops/std@7.3.0/lambda";
import * as mapping from "jsr:@denops/std@7.3.0/mapping";
import * as nvimFn from "jsr:@denops/std@7.3.0/function/nvim";
import * as option from "jsr:@denops/std@7.3.0/option";
import * as vars from "jsr:@denops/std@7.3.0/variable";

export const denops: Plug[] = [
  {
    url: "https://github.com/yukimemi/autocursor.vim",
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
            wait: 300,
          },
          {
            name: [
              "CursorMoved",
              "CursorMovedI",
              "InsertEnter",
            ],
            set: false,
            wait: 0,
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
            wait: 300,
          },
          {
            name: [
              "CursorMoved",
              "CursorMovedI",
              "InsertEnter",
            ],
            set: false,
            wait: 0,
          },
        ],
      });
      await vars.g.set(denops, "autocursor_ignore_filetypes", [
        "NvimTree",
        "TelescopePrompt",
        "aerial",
        "asyncwalker",
        "asyncwalker-filter",
        "coc-explorer",
        "ctrlp",
        "ddu",
        "ddu-ff",
        "ddu-ff-filter",
        "ddu-filer",
        "gundo",
        "list",
        "neo-tree",
        "qf",
        "quickfix",
        "undotree",
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
      await vars.g.set(denops, "silentsaver_notify", false);
      await vars.g.set(denops, "silentsaver_use_ui_select", false);
      await vars.g.set(denops, "silentsaver_events", [
        "CursorHold",
        "BufWritePre",
        "InsertLeave",
      ]);
      await vars.g.set(denops, "silentsaver_ignore_filetypes", [
        "NvimTree",
        "TelescopePrompt",
        "aerial",
        "asyncwalker",
        "asyncwalker-filter",
        "coc-explorer",
        "csv",
        "ctrlp",
        "ddu",
        "ddu-ff",
        "ddu-ff-filter",
        "ddu-filer",
        "gin-diff",
        "gin-status",
        "gundo",
        "list",
        "log",
        "neo-tree",
        "qf",
        "quickfix",
        "undotree",
      ]);
    },
  },
  {
    url: "https://github.com/yukimemi/asyncsearcher.vim",
    dst: "~/src/github.com/yukimemi/asyncsearcher.vim",
    before: async ({ denops }) => {
      await vars.g.set(denops, "asyncsearcher_debug", false);
      await vars.g.set(
        denops,
        "asyncsearcher_cfg_path",
        await fn.expand(denops, "~/.config/asyncsearcher/asyncsearcher.toml"),
      );
      await option.grepformat.set(denops, "%f:%l:%c:%m");

      await mapping.map(denops, "<space>ss", "<cmd>AsyncSearch<cr>", { mode: "n" });
      await mapping.map(denops, "<space>sr", "<cmd>AsyncSearch --tool=ripgrep<cr>", {
        mode: "n",
      });
      await mapping.map(denops, "<space>sp", "<cmd>AsyncSearch --tool=pt<cr>", {
        mode: "n",
      });
      await mapping.map(denops, "<space>sj", "<cmd>AsyncSearch --tool=jvgrep<cr>", {
        mode: "n",
      });

      await mapping.map(
        denops,
        "<space>sS",
        "<cmd>AsyncSearch --tool=default-all<cr>",
        { mode: "n" },
      );
      await mapping.map(
        denops,
        "<space>sR",
        "<cmd>AsyncSearch --tool=ripgrep-all<cr>",
        { mode: "n" },
      );
      await mapping.map(denops, "<space>sP", "<cmd>AsyncSearch --tool=pt-all<cr>", {
        mode: "n",
      });
      await mapping.map(denops, "<space>sJ", "<cmd>AsyncSearch --tool=jvgrep-all<cr>", {
        mode: "n",
      });
    },
  },
  {
    url: "https://github.com/yukimemi/chronicle.vim",
    dst: "~/src/github.com/yukimemi/chronicle.vim",
    dependencies: ["https://github.com/vim-denops/denops.vim"],
    cache: {
      beforeFile: "~/.config/nvim/rc/before/chronicle.vim",
      afterFile: "~/.config/nvim/rc/after/chronicle.vim",
    },
  },
  {
    url: "https://github.com/yukimemi/autoreplacer.vim",
    dst: "~/src/github.com/yukimemi/autoreplacer.vim",
    before: async ({ denops }) => {
      await vars.g.set(denops, "autoreplacer_debug", false);
      await vars.g.set(denops, "autoreplacer_notify", true);
      await vars.g.set(denops, "autoreplacer_config", {
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
              `/^(\\s*.Last Change\\s*: ).*\\./i`,
              '$1${format(now, "yyyy/MM/dd HH:mm:ss")}.',
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
    url: "https://github.com/yukimemi/asyncwalker.vim",
    dst: "~/src/github.com/yukimemi/asyncwalker.vim",
    before: async ({ denops }) => {
      await mapping.map(denops, "mw", "<cmd>AsyncWalk<cr>", { mode: "n" });
      await mapping.map(denops, "ms", "<cmd>AsyncWalk --path=~/src<cr>", { mode: "n" });
      await mapping.map(denops, "md", "<cmd>AsyncWalk --path=~/.dotfiles<cr>", { mode: "n" });
      await mapping.map(denops, "mC", "<cmd>AsyncWalk --path=~/.cache<cr>", { mode: "n" });
      await mapping.map(denops, "mb", "<cmd>AsyncWalkBufferDir<cr>", { mode: "n" });
      await mapping.map(denops, "mM", "<cmd>AsyncWalk --path=~/.memolist<cr>", {
        mode: "n",
      });
      await mapping.map(denops, "<space>wc", "<cmd>AsyncWalk --path=~/.cache<cr>", { mode: "n" });
      await mapping.map(denops, "<space>wj", "<cmd>AsyncWalk --path=~/.cache/junkfile<cr>", {
        mode: "n",
      });
      await mapping.map(denops, "<space>wr", "<cmd>AsyncWalkResume<cr>", {
        mode: "n",
      });
    },
  },
  {
    url: "https://github.com/yukimemi/hitori.vim",
    dst: "~/src/github.com/yukimemi/hitori.vim",
    enabled: Deno.build.os !== "linux",
    before: async ({ denops }) => {
      await vars.g.set(denops, "hitori_debug", false);
      await vars.g.set(denops, "hitori_enable", true);
      await vars.g.set(denops, "hitori_quit", true);
      await vars.g.set(denops, "hitori_wsl", true);
      await vars.g.set(denops, "hitori_opener", "edit");

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
