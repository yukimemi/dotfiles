// =============================================================================
// File        : ddu.ts
// Author      : yukimemi
// Last Change : 2023/08/26 10:00:19.
// =============================================================================

import type { Plug } from "https://deno.land/x/dvpm@3.0.8/mod.ts";

import * as autocmd from "https://deno.land/x/denops_std@v5.0.1/autocmd/mod.ts";
import * as fn from "https://deno.land/x/denops_std@v5.0.1/function/mod.ts";
import * as lambda from "https://deno.land/x/denops_std@v5.0.1/lambda/mod.ts";
import * as mapping from "https://deno.land/x/denops_std@v5.0.1/mapping/mod.ts";
import * as op from "https://deno.land/x/denops_std@v5.0.1/option/mod.ts";
import { batch } from "https://deno.land/x/denops_std@v5.0.1/batch/mod.ts";
import { ensure, is } from "https://deno.land/x/unknownutil@v3.6.0/mod.ts";
import { pluginStatus } from "../main.ts";

export const ddu: Plug[] = [
  {
    url: "Shougo/ddu.vim",
    enabled: pluginStatus.ddu && !pluginStatus.vscode,
    cache: { enabled: false },
    dependencies: [
      { url: "4513ECHO/ddu-kind-url" },
      { url: "4513ECHO/ddu-source-emoji" },
      { url: "4513ECHO/ddu-source-source" },
      { url: "4513ECHO/vim-readme-viewer" },
      { url: "Shougo/ddu-column-filename" },
      { url: "Shougo/ddu-commands.vim" },
      { url: "Shougo/ddu-kind-file" },
      { url: "Shougo/ddu-kind-word" },
      { url: "Shougo/ddu-source-action" },
      { url: "Shougo/ddu-source-dummy" },
      { url: "Shougo/ddu-source-file" },
      { url: "Shougo/ddu-source-file_old" },
      { url: "Shougo/ddu-source-file_point" },
      { url: "Shougo/ddu-source-file_rec" },
      { url: "Shougo/ddu-source-line" },
      { url: "Shougo/ddu-source-path_history" },
      { url: "Shougo/ddu-source-register" },
      { url: "Shougo/ddu-ui-ff" },
      { url: "Shougo/ddu-ui-filer" },
      { url: "Shougo/junkfile.vim" },
      { url: "kamecha/ddu-source-jumplist" },
      { url: "kuuote/ddu-filter-fuse" },
      { url: "kuuote/ddu-source-git_status" },
      { url: "kyoh86/ddu-filter-converter_hl_dir" },
      { url: "kyoh86/ddu-source-command" },
      { url: "matsui54/ddu-source-command_history" },
      { url: "matsui54/ddu-source-file_external" },
      { url: "matsui54/ddu-source-help" },
      { url: "shun/ddu-source-buffer" },
      { url: "shun/ddu-source-rg" },
      { url: "uga-rosa/ddu-filter-converter_devicon" },
      { url: "uga-rosa/ddu-source-lsp" },
      { url: "uga-rosa/ddu-source-search_history" },
      { url: "yuki-yano/ddu-filter-fzf" },
      { url: "yuki-yano/ddu-source-nvim-notify" },
      { url: "Milly/ddu-filter-merge" },
      {
        url: "Milly/ddu-filter-kensaku",
        dependencies: [{ url: "lambdalisue/kensaku.vim" }],
      },
      {
        url: "matsui54/ddu-vim-ui-select",
        // deno-lint-ignore require-await
        enabled: async ({ denops }) => denops.meta.host === "nvim" && false,
      },
      {
        url: "yukimemi/ddu-source-chronicle",
        dst: "~/src/github.com/yukimemi/ddu-source-chronicle",
      },
    ],
    before: async ({ denops }) => {
      await mapping.map(denops, "q:", "<cmd>Ddu command_history<cr>", {
        mode: "n",
      });
      await mapping.map(denops, "q/", "<cmd>Ddu search_history<cr>", {
        mode: "n",
      });
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
        "<leader>df",
        `<cmd>Ddu -name=files file_rec<cr>`,
        { mode: "n" },
      );
      await mapping.map(
        denops,
        "<leader>cr",
        `<cmd>Ddu -name=chronicle-read chronicle -source-param-chronicle-kind='read'<cr>`,
        {
          mode: "n",
        },
      );
      await mapping.map(
        denops,
        "<leader>cw",
        `<cmd>Ddu -name=chronicle-write chronicle -source-param-chronicle-kind='write'<cr>`,
        {
          mode: "n",
        },
      );
      await mapping.map(denops, "<leader>dh", `<cmd>Ddu -name=help help<cr>`, {
        mode: "n",
      });
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
        "<leader>dg",
        `<cmd>call <SID>${denops.name}_notify("${
          lambda.register(
            denops,
            async () => {
              await denops.call("ddu#start", {
                sources: [
                  {
                    name: "git_status",
                    options: {
                      path: await fn.fnamemodify(
                        denops,
                        await fn.expand(denops, "%"),
                        ":p",
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
          lambda.register(
            denops,
            async () => {
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
                        ensure(await fn.expand(denops, "<cword>"), is.String),
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
        "<leader>dr",
        "<cmd>Ddu -name=search -resume -ui-param-startFilter=v:false<cr>",
        { mode: "n" },
      );
    },
    after: async ({ denops }) => {
      // global settings.
      await autocmd.group(denops, "MyDduSettings", (helper) => {
        helper.remove("*");
        helper.define(
          ["VimResized", "VimEnter"],
          "*",
          `call <SID>${denops.name}_notify("${
            lambda.register(
              denops,
              async () => {
                const lines = await op.lines.get(denops);
                const [height, row] = [
                  Math.floor(lines * 0.85),
                  Math.floor(lines * 0.075),
                ];
                const columns = await op.columns.get(denops);
                const [width, col] = [
                  Math.floor(columns * 0.85),
                  Math.floor(columns * 0.075),
                ];
                await denops.call("ddu#custom#patch_global", {
                  ui: "ff",
                  uiOptions: {
                    filer: {
                      toggle: false,
                    },
                  },
                  uiParams: {
                    ff: {
                      filterFloatingPosition: "top",
                      filterSplitDirection: "floating",
                      floatingBorder: "single",
                      ignoreEmpty: true,
                      previewFloating: true,
                      previewFloatingBorder: "single",
                      previewFloatingTitle: "Preview",
                      previewSplit: "vertical",
                      previewHeight: height,
                      previewWidth: Math.floor(width / 2),
                      prompt: "»",
                      split: "floating",
                      startAutoAction: true,
                      startFilter: true,
                      winCol: col,
                      winHeight: height,
                      winRow: row,
                      winWidth: width,
                      highlights: {
                        floating: "Normal",
                        floatingBorder: "Normal",
                      },
                      autoAction: {
                        name: "preview",
                      },
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
                    file_rec: {
                      converters: ["converter_devicon", "converter_hl_dir"],
                    },
                    chronicle: {
                      converters: ["converter_devicon", "converter_hl_dir"],
                    },
                  },
                  sourceParams: {
                    file_rec: {
                      chunkSize: 50,
                    },
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
                    command: { defaultAction: "edit" },
                    command_history: { defaultAction: "edit" },
                    search_history: { defaultAction: "edit" },
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
                    matcher_fzf: {
                      highlightMatched: "Search",
                    },
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
                        "matcher_fzf",
                      ],
                    },
                  },
                });
              },
            )
          }", [])`,
        );
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
                    "<esc><cmd>call ddu#ui#do_action('itemAction')<cr>",
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

      // Initialize ddu
      await denops.call(`ddu#load`, "ui", ["ff"]);
      denops.call(`ddu#start`, {
        ui: "ff",
        uiParams: {
          ff: {
            ignoreEmpty: true,
          },
        },
      });
    },
  },
];
