import type { Denops } from "https://deno.land/x/denops_std@v5.0.0/mod.ts";
import type { Plug } from "https://deno.land/x/dvpm@0.3.6/mod.ts";

import * as autocmd from "https://deno.land/x/denops_std@v5.0.0/autocmd/mod.ts";
import * as fn from "https://deno.land/x/denops_std@v5.0.0/function/mod.ts";
import * as lambda from "https://deno.land/x/denops_std@v5.0.0/lambda/mod.ts";
import * as mapping from "https://deno.land/x/denops_std@v5.0.0/mapping/mod.ts";
import * as op from "https://deno.land/x/denops_std@v5.0.0/option/mod.ts";
import { batch } from "https://deno.land/x/denops_std@v5.0.0/batch/mod.ts";
import { ensureString } from "https://deno.land/x/unknownutil@v2.1.1/ensure.ts";

export const ddu: Plug[] = [
  {
    url: "Shougo/ddu.vim",
    dependencies: [
      { url: "4513ECHO/ddu-kind-url" },
      { url: "4513ECHO/ddu-source-emoji" },
      { url: "4513ECHO/ddu-source-source" },
      { url: "4513ECHO/vim-readme-viewer" },
      { url: "Shougo/junkfile.vim" },
      { url: "Shougo/ddu-column-filename" },
      { url: "Shougo/ddu-commands.vim" },
      { url: "Shougo/ddu-kind-file" },
      { url: "Shougo/ddu-kind-word" },
      { url: "Shougo/ddu-source-action" },
      { url: "Shougo/ddu-source-file" },
      { url: "Shougo/ddu-source-file_old" },
      { url: "Shougo/ddu-source-file_point" },
      { url: "Shougo/ddu-source-file_rec" },
      { url: "Shougo/ddu-source-line" },
      { url: "Shougo/ddu-source-register" },
      { url: "Shougo/ddu-ui-ff" },
      { url: "Shougo/ddu-ui-filer" },
      { url: "kuuote/ddu-filter-fuse" },
      { url: "matsui54/ddu-source-command_history" },
      { url: "matsui54/ddu-source-file_external" },
      { url: "matsui54/ddu-source-help" },
      { url: "shun/ddu-source-rg" },
      { url: "uga-rosa/ddu-filter-converter_devicon" },
      { url: "yuki-yano/ddu-filter-fzf" },
      { url: "Milly/ddu-filter-merge" },
      {
        url: "Milly/ddu-filter-kensaku",
        dependencies: [{ url: "lambdalisue/kensaku.vim" }],
      },
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
        "<leader>dS",
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
      await mapping.map(
        denops,
        "<leader>dm",
        `<cmd>call <SID>${denops.name}_notify("${
          lambda.register(
            denops,
            async () => {
              await denops.call("ddu#start", {
                sources: [
                  {
                    name: "file_rec",
                    options: {
                      path: await fn.expand(denops, "~/.memolist"),
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
          lambda.register(denops, async () => {
            await denops.call("ddu#start", {
              name: "search",
              uiParams: {
                ff: {
                  ignoreEmpty: true,
                },
              },
              sources: [
                {
                  name: "rg",
                  options: {
                    path: await fn.input(
                      denops,
                      "Directory: ",
                      await fn.getcwd(denops),
                      "dir",
                    ),
                  },
                  params: {
                    input: await fn.input(
                      denops,
                      "Pattern: ",
                      ensureString(await fn.expand(denops, "<cword>")),
                    ),
                  },
                },
              ],
            });
          })
        }", [])<cr>`,
        { mode: "n" },
      );
      await mapping.map(
        denops,
        "<leader>dr",
        "<cmd>Ddu -name=search -resume -ui-param-startFilter=v:false<cr>",
        { mode: "n" },
      );
    },
    after: async (denops: Denops) => {
      // global settings.
      await denops.call("ddu#custom#patch_global", {
        ui: "ff",
        uiOptions: {
          filer: {
            toggle: false,
          },
        },
        uiParams: {
          ff: {
            prompt: "»",
            split: "floating",
            filterSplitDirection: "floating",
            floatingBorder: "single",
            previewFloating: true,
            previewFloatingBorder: "single",
            previewSplit: "no",
            highlights: {
              floating: "Normal",
              floatingBorder: "Special",
            },
            startFilter: true,
            updateTime: 0,
          },
          filer: {
            split: "vertical",
            sort: "filename",
            filterSplitDirection: "botleft",
            sortTreesFirst: true,
            previewSplit: "no",
            toggle: true,
            winWidth: 40,
          },
        },
        sourceOptions: {
          _: {
            ignoreCase: true,
            matchers: ["merge"],
            converters: ["converter_devicon"],
          },
        },
        sourceParams: {
          file_external: {
            cmd: ["git", "ls-files", "-co", "--exclude-standard"],
          },
          file_rg: {
            cmd: [
              "rg",
              "--files",
              "--glob",
              "!.git",
              "--color",
              "never",
              "--no-messages",
              "--json",
            ],
            updateItems: 50000,
          },
          rg: {
            args: [
              "--ignore-case",
              "--column",
              "--no-heading",
              "--color",
              "never",
              "--json",
            ],
            inputType: "regex",
          },
        },
        kindOptions: {
          action: { defaultAction: "do" },
          command_history: { defaultAction: "edit" },
          file: { defaultAction: "open" },
          help: { defaultAction: "open" },
          readme_viewer: { defaultAction: "open" },
          source: { defaultAction: "execute" },
          ui_select: { defaultAction: "select" },
          url: { defaultAction: "browse" },
          word: { defaultAction: "append" },
        },
        actionOptions: {
          narrow: {
            quit: false,
          },
          tabopen: {
            quit: false,
          },
        },
        filterParams: {
          matcher_fuse: {
            highlightMatched: "Search",
          },
          matcher_kensaku: {
            highlightMatched: "Search",
          },
          merge: {
            highlightMatched: "Search",
            filters: [
              {
                name: "matcher_kensaku",
                weight: 2.0,
              },
              "matcher_fuse",
            ],
          },
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
