// =============================================================================
// File        : terminal.ts
// Author      : yukimemi
// Last Change : 2025/02/09 10:34:51.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@6.2.2";

import * as autocmd from "jsr:@denops/std@7.4.0/autocmd";
import * as lambda from "jsr:@denops/std@7.4.0/lambda";
import * as mapping from "jsr:@denops/std@7.4.0/mapping";
import * as op from "jsr:@denops/std@7.4.0/option";
import { batch } from "jsr:@denops/std@7.4.0/batch";

export const terminal: Plug[] = [
  {
    url: "https://github.com/voldikss/vim-floaterm",
    enabled: false,
    after: async ({ denops }) => {
      await mapping.map(denops, `<c-s>`, `<cmd>FloatermToggle<cr>`, {
        mode: "n",
      });
    },
  },
  {
    url: "https://github.com/akinsho/toggleterm.nvim",
    profiles: ["default"],
    enabled: false,
    cache: { afterFile: `~/.config/nvim/rc/after/toggleterm.lua` },
  },
  {
    url: "https://github.com/Shougo/ddt-ui-shell",
    profiles: ["default"],
  },
  {
    url: "https://github.com/Shougo/ddt-ui-terminal",
    profiles: ["default"],
  },
  {
    url: "https://github.com/Shougo/ddt.vim",
    profiles: ["default"],
    enabled: true,
    dependencies: [
      "https://github.com/Shougo/ddt-ui-shell",
      "https://github.com/Shougo/ddt-ui-terminal",
    ],
    after: async ({ denops }) => {
      await denops.call("ddt#custom#patch_global", {
        uiParams: {
          shell: {
            noSaveHistoryCommands: ["history"],
            prompt: "»",
            promptPattern: "\\w*» \\?",
          },
          terminal: {
            command: denops.meta.platform === "windows" ? ["powershell"] : ["zsh"],
            prompt: "»",
            promptPattern: "\\w*» \\?",
          },
        },
      });
      // await mapping.map(
      //   denops,
      //   "<c-s>",
      //   `<cmd>call <SID>${denops.name}_notify("${
      //     lambda.register(
      //       denops,
      //       async () => {
      //         await denops.call("ddt#start", {
      //           ui: "shell",
      //         });
      //       },
      //     )
      //   }", [])<cr>`,
      //   { mode: "n" },
      // );
      await mapping.map(
        denops,
        "<c-s>",
        `<cmd>call <SID>${denops.name}_notify("${
          lambda.register(
            denops,
            async () => {
              await denops.call("ddt#start", {
                ui: "terminal",
              });
            },
          )
        }", [])<cr>`,
        { mode: "n" },
      );

      await autocmd.group(denops, "MyDdtShellMapping", (helper) => {
        helper.remove("*");
        helper.define(
          "FileType",
          "ddt-shell",
          `call <SID>${denops.name}_notify("${
            lambda.register(
              denops,
              async () => {
                await batch(denops, async (denops) => {
                  await op.signcolumn.setLocal(denops, "auto");
                  await op.cursorline.setLocal(denops, true);
                  await mapping.map(
                    denops,
                    "<cr>",
                    `<cmd>call ddt#ui#do_action('executeLine')<cr>`,
                    { mode: ["n", "i"], buffer: true, silent: true },
                  );
                  await mapping.map(
                    denops,
                    "<c-n>",
                    `<cmd>call ddt#ui#do_action('nextPrompt')<cr>`,
                    { mode: "n", buffer: true, silent: true },
                  );
                  await mapping.map(
                    denops,
                    "<c-p>",
                    `<cmd>call ddt#ui#do_action('previousPrompt')<cr>`,
                    { mode: "n", buffer: true, silent: true },
                  );
                  await mapping.map(
                    denops,
                    "<c-y>",
                    `<cmd>call ddt#ui#do_action('pastePrompt')<cr>`,
                    { mode: "n", buffer: true, silent: true },
                  );
                  await mapping.map(
                    denops,
                    "<c-c>",
                    `<cmd>call ddt#ui#do_action('teminate')<cr>`,
                    { mode: ["n", "i"], buffer: true, silent: true },
                  );
                });
              },
            )
          }", [])`,
        );
      });
      await autocmd.group(denops, "MyDdtTerminalMapping", (helper) => {
        helper.remove("*");
        helper.define(
          "FileType",
          "ddt-terminal",
          `call <SID>${denops.name}_notify("${
            lambda.register(
              denops,
              async () => {
                await batch(denops, async (denops) => {
                  await op.signcolumn.setLocal(denops, "auto");
                  await op.cursorline.setLocal(denops, true);
                  await mapping.map(
                    denops,
                    "<cr>",
                    `<cmd>call ddt#ui#do_action('executeLine')<cr>`,
                    { mode: ["n", "i"], buffer: true, silent: true },
                  );
                  await mapping.map(
                    denops,
                    "<c-n>",
                    `<cmd>call ddt#ui#do_action('nextPrompt')<cr>`,
                    { mode: "n", buffer: true, silent: true },
                  );
                  await mapping.map(
                    denops,
                    "<c-p>",
                    `<cmd>call ddt#ui#do_action('previousPrompt')<cr>`,
                    { mode: "n", buffer: true, silent: true },
                  );
                  await mapping.map(
                    denops,
                    "<c-y>",
                    `<cmd>call ddt#ui#do_action('pastePrompt')<cr>`,
                    { mode: "n", buffer: true, silent: true },
                  );
                  await mapping.map(
                    denops,
                    "<c-c>",
                    `<cmd>call ddt#ui#do_action('teminate')<cr>`,
                    { mode: ["n", "i"], buffer: true, silent: true },
                  );
                });
              },
            )
          }", [])`,
        );
      });
    },
  },
];
