import type { Denops } from "https://deno.land/x/denops_std@v5.0.0/mod.ts";
import type { Plug } from "https://deno.land/x/dvpm@0.3.5/mod.ts";

import * as autocmd from "https://deno.land/x/denops_std@v5.0.0/autocmd/mod.ts";
import * as mapping from "https://deno.land/x/denops_std@v5.0.0/mapping/mod.ts";
import * as lambda from "https://deno.land/x/denops_std@v5.0.0/lambda/mod.ts";
import * as op from "https://deno.land/x/denops_std@v5.0.0/option/mod.ts";
import { batch } from "https://deno.land/x/denops_std@v5.0.0/batch/mod.ts";
import * as fn from "https://deno.land/x/denops_std@v5.0.0/function/mod.ts";

export const ddu: Plug[] = [
  {
    url: "Shougo/ddu.vim",
    dependencies: [
      { url: "4513ECHO/ddu-kind-url" },
      { url: "4513ECHO/ddu-source-emoji" },
      { url: "4513ECHO/ddu-source-source" },
      { url: "Milly/ddu-filter-kensaku" },
      { url: "Shougo/ddu-kind-file" },
      { url: "Shougo/ddu-kind-word" },
      { url: "Shougo/ddu-source-file" },
      { url: "Shougo/ddu-source-file_old" },
      { url: "Shougo/ddu-source-file_rec" },
      { url: "Shougo/ddu-source-file_point" },
      { url: "Shougo/ddu-source-line" },
      { url: "Shougo/ddu-source-register" },
      { url: "Shougo/ddu-ui-ff" },
      { url: "Shougo/ddu-commands.vim" },
      { url: "matsui54/ddu-source-file_external" },
      { url: "matsui54/ddu-source-command_history" },
      { url: "matsui54/ddu-source-help" },
      { url: "uga-rosa/ddu-filter-converter_devicon" },
      {
        url: "matsui54/ddu-vim-ui-select",
        enabled: async (denops: Denops) => await fn.has(denops, "nvim"),
      },
      { url: "shun/ddu-source-buffer" },
    ],
    enabled: async (denops: Denops) => await fn.has(denops, "nvim"),
    before: async (denops: Denops) => {
      await mapping.map(
        denops,
        "<leader>dM",
        "<cmd>Ddu -name=source source<cr>",
        { mode: "n" },
      );
      await mapping.map(
        denops,
        "<leader>do",
        "<cmd>Ddu -name=old file_old<cr>",
        { mode: "n" },
      );
      await mapping.map(
        denops,
        "<leader>db",
        "<cmd>Ddu -name=buffer buffer<cr>",
        { mode: "n" },
      );
      await mapping.map(
        denops,
        "<leader>dd",
        `<cmd>call <SID>${denops.name}_notify("${
          lambda.register(
            denops,
            async () => {
              await denops.call("ddu#start", {
                sources: [
                  {
                    name: "file_rec",
                    options: {
                      path: await fn.fnamemodify(
                        denops,
                        await fn.expand(denops, "%"),
                        ":p:h",
                      ),
                    },
                  },
                ],
              });
            },
          )
        }", [])<cr>`,
        { mode: "n" },
      );
      await mapping.map(
        denops,
        "<leader>ds",
        `<cmd>call <SID>${denops.name}_notify("${
          lambda.register(
            denops,
            async () => {
              await denops.call("ddu#start", {
                sources: [
                  {
                    name: "file_rec",
                    options: {
                      path: await fn.expand(denops, "~/src"),
                    },
                  },
                ],
              });
            },
          )
        }", [])<cr>`,
        { mode: "n" },
      );
      await mapping.map(
        denops,
        "<leader>dD",
        `<cmd>call <SID>${denops.name}_notify("${
          lambda.register(
            denops,
            async () => {
              await denops.call("ddu#start", {
                sources: [
                  {
                    name: "file_rec",
                    options: {
                      path: await fn.expand(denops, "~/.dotfiles"),
                    },
                  },
                ],
              });
            },
          )
        }", [])<cr>`,
        { mode: "n" },
      );
    },
    after: async (denops: Denops) => {
      // global settings.
      await denops.call("ddu#custom#patch_global", {
        ui: "ff",
        uiParams: {
          ff: {
            prompt: "> ",
            split: "floating",
            floatingBorder: "single",
            startFilter: true,
          },
        },
        sources: {},
        sourceOptions: {
          _: {
            matchers: ["matcher_kensaku"],
            converters: ["converter_devicon"],
          },
        },
        sourceParams: {},
        kindOptions: {
          command_history: { defaultAction: "edit" },
          file: { defaultAction: "open" },
          source: { defaultAction: "execute" },
          ui_select: { defaultAction: "select" },
          url: { defaultAction: "browse" },
          word: { defaultAction: "append" },
        },
      });

      await autocmd.group(denops, "MyDduUiFfMapping", (helper) => {
        helper.remove("*");
        helper.define(
          "FileType",
          "ddu-ff",
          `call <SID>${denops.name}_notify("${
            lambda.register(
              denops,
              async () => {
                await batch(denops, async (denops) => {
                  await op.cursorline.setLocal(denops, true);
                  await mapping.map(
                    denops,
                    "<cr>",
                    `<cmd>call ddu#ui#do_action('itemAction')<cr>`,
                    { mode: "n", buffer: true, silent: true },
                  );
                  await mapping.map(
                    denops,
                    "<space>",
                    `<cmd>call ddu#ui#do_action('toggleSelectItem')<cr>`,
                    { mode: "n", buffer: true, silent: true },
                  );
                  await mapping.map(
                    denops,
                    "i",
                    `<cmd>call ddu#ui#do_action('openFilterWindow')<cr>`,
                    { mode: "n", buffer: true, silent: true },
                  );
                  await mapping.map(
                    denops,
                    "a",
                    `<cmd>call ddu#ui#do_action('chooseAction')<cr>`,
                    { mode: "n", buffer: true, silent: true },
                  );
                  await mapping.map(
                    denops,
                    "A",
                    `<cmd>call ddu#ui#do_action('inputAction')<cr>`,
                    { mode: "n", buffer: true, silent: true },
                  );
                  await mapping.map(
                    denops,
                    "<C-l>",
                    `<cmd>call ddu#ui#do_action('refreshItems')<cr>`,
                    { mode: "n", buffer: true, silent: true },
                  );
                  await mapping.map(
                    denops,
                    "p",
                    `<cmd>call ddu#ui#do_action('preview')<cr>`,
                    { mode: "n", buffer: true, silent: true },
                  );
                  await mapping.map(
                    denops,
                    "q",
                    `<cmd>call ddu#ui#do_action('quit')<cr>`,
                    { mode: "n", buffer: true, silent: true },
                  );
                  await mapping.map(
                    denops,
                    "c",
                    `<cmd>call ddu#ui#do_action('itemAction', {'name': 'cd'})<cr>`,
                    { mode: "n", buffer: true, silent: true },
                  );
                  await mapping.map(
                    denops,
                    "d",
                    `<cmd>call ddu#ui#do_action('itemAction', {'name': 'delete'})<cr>`,
                    { mode: "n", buffer: true, silent: true },
                  );
                  await mapping.map(
                    denops,
                    "e",
                    `<cmd>call ddu#ui#do_action('itemAction', {'name': 'edit'})<cr>`,
                    { mode: "n", buffer: true, silent: true },
                  );
                  await mapping.map(
                    denops,
                    "E",
                    `<cmd>call ddu#ui#do_action('itemAction', {'params': eval(input('params: '))})<cr>`,
                    { mode: "n", buffer: true, silent: true },
                  );
                  await mapping.map(
                    denops,
                    "v",
                    `<cmd>call ddu#ui#do_action('itemAction', {'name': 'open', 'params': {'command': 'vsplit'}})<cr>`,
                    { mode: "n", buffer: true, silent: true },
                  );
                  await mapping.map(
                    denops,
                    "N",
                    `<cmd>call ddu#ui#do_action('itemAction', {'name': 'new'})<cr>`,
                    { mode: "n", buffer: true, silent: true },
                  );
                  await mapping.map(
                    denops,
                    "r",
                    `<cmd>call ddu#ui#do_action('itemAction', {'name': 'quickfix'})<cr>`,
                    { mode: "n", buffer: true, silent: true },
                  );
                  await mapping.map(
                    denops,
                    "<esc>",
                    `<cmd>call ddu#ui#do_action('quit')<cr>`,
                    { mode: "n", buffer: true, silent: true, nowait: true },
                  );
                  await mapping.map(
                    denops,
                    "u",
                    `<cmd>call ddu#ui#do_action('updateOptions', {'sourceOptions': {'_': {'matchers': []}}})<cr>`,
                    { mode: "n", buffer: true, silent: true },
                  );
                });
              },
            )
          }", [])`,
        );
        helper.define(
          "FileType",
          "ddu-ff-filter",
          `call <SID>${denops.name}_notify("${
            lambda.register(
              denops,
              async () => {
                await batch(denops, async (denops) => {
                  await mapping.map(
                    denops,
                    "<cr>",
                    "<cmd>call ddu#ui#do_action('itemAction')<cr>",
                    { mode: "i", buffer: true, silent: true },
                  );
                  await mapping.map(
                    denops,
                    "<esc>",
                    "<esc><cmd>call ddu#ui#do_action('closeFilterWindow')<cr>",
                    { mode: "i", buffer: true, silent: true, nowait: true },
                  );
                  await mapping.map(
                    denops,
                    "<c-j>",
                    `<cmd>call ddu#ui#do_action('cursorNext')<cr>`,
                    { mode: "i", buffer: true, silent: true },
                  );
                  await mapping.map(
                    denops,
                    "<c-k>",
                    `<cmd>call ddu#ui#do_action('cursorPrevious')<cr>`,
                    { mode: "i", buffer: true, silent: true },
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
