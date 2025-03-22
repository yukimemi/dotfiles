// =============================================================================
// File        : denops.ts
// Author      : yukimemi
// Last Change : 2025/03/09 14:09:51.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@7.0.0";

import * as autocmd from "jsr:@denops/std@7.5.0/autocmd";
import * as lambda from "jsr:@denops/std@7.5.0/lambda";
import * as nvimFn from "jsr:@denops/std@7.5.0/function/nvim";
import * as vars from "jsr:@denops/std@7.5.0/variable";

export const denops: Plug[] = [
  {
    url: "https://github.com/yukimemi/autocursor.vim",
    profiles: ["minimal"],
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
        "deck",
        "fall-help",
        "fall-input",
        "fall-list",
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
    profiles: ["minimal"],
    before: async ({ denops }) => {
      await vars.g.set(denops, "silentsaver_debug", false);
      await vars.g.set(denops, "silentsaver_enable", true);
      await vars.g.set(denops, "silentsaver_echo", false);
      await vars.g.set(denops, "silentsaver_notify", false);
      await vars.g.set(denops, "silentsaver_diff_vertical", true);
      await vars.g.set(denops, "silentsaver_use_ui_select", false);
      await vars.g.set(denops, "silentsaver_events", [
        "CursorHold",
        "BufWritePre",
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
        "deck",
        "fall-help",
        "fall-input",
        "fall-list",
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
    profiles: ["minimal"],
    cache: {
      beforeFile: "~/.config/nvim/rc/before/asyncsearcher.lua",
    },
  },
  {
    url: "https://github.com/yukimemi/chronicle.vim",
    profiles: ["minimal"],
    cache: {
      beforeFile: "~/.config/nvim/rc/before/chronicle.vim",
      afterFile: "~/.config/nvim/rc/after/chronicle.vim",
    },
  },
  {
    url: "https://github.com/yukimemi/autoreplacer.vim",
    profiles: ["minimal"],
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
          head: 55,
          tail: 5,
        },
      });
    },
  },
  {
    url: "https://github.com/yukimemi/asyncwalker.vim",
    cache: { beforeFile: "~/.config/nvim/rc/before/asyncwalker.lua" },
  },
  {
    url: "https://github.com/yukimemi/hitori.vim",
    profiles: ["minimal"],
    cache: { beforeFile: "~/.config/nvim/rc/before/hitori.lua" },
  },
  {
    url: "https://github.com/yukimemi/dps-ahdr",
    profiles: ["minimal"],
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
