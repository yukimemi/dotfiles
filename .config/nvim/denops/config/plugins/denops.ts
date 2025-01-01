// =============================================================================
// File        : denops.ts
// Author      : yukimemi
// Last Change : 2025/01/01 19:58:57.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@5.6.0";

import * as autocmd from "jsr:@denops/std@7.4.0/autocmd";
import * as lambda from "jsr:@denops/std@7.4.0/lambda";
import * as nvimFn from "jsr:@denops/std@7.4.0/function/nvim";
import * as vars from "jsr:@denops/std@7.4.0/variable";

export const denops: Plug[] = [
  {
    url: "https://github.com/yukimemi/autocursor.vim",
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
        "fall-input",
        "fall-list",
        "fall-help",
      ]);
    },
  },
  {
    url: "https://github.com/yukimemi/silentsaver.vim",
    before: async ({ denops }) => {
      await vars.g.set(denops, "silentsaver_debug", false);
      await vars.g.set(denops, "silentsaver_enable", true);
      await vars.g.set(denops, "silentsaver_echo", false);
      await vars.g.set(denops, "silentsaver_notify", false);
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
        "gin-diff",
        "gin-status",
        "gundo",
        "list",
        "log",
        "neo-tree",
        "qf",
        "quickfix",
        "undotree",
        "fall-input",
        "fall-list",
        "fall-help",
      ]);
    },
  },
  {
    url: "https://github.com/yukimemi/asyncsearcher.vim",
    profiles: ["minimal"],
    dependencies: ["https://github.com/vim-denops/denops.vim"],
    cache: {
      beforeFile: "~/.config/nvim/rc/before/asyncsearcher.lua",
    },
  },
  {
    url: "https://github.com/yukimemi/chronicle.vim",
    profiles: ["minimal"],
    dependencies: ["https://github.com/vim-denops/denops.vim"],
    cache: {
      beforeFile: "~/.config/nvim/rc/before/chronicle.vim",
      afterFile: "~/.config/nvim/rc/after/chronicle.vim",
    },
  },
  {
    url: "https://github.com/yukimemi/autoreplacer.vim",
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
    dependencies: ["https://github.com/vim-denops/denops.vim"],
    cache: {
      beforeFile: "~/.config/nvim/rc/before/asyncwalker.lua",
    },
  },
  {
    url: "https://github.com/yukimemi/hitori.vim",
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
