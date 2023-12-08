// =============================================================================
// File        : ddu.ts
// Author      : yukimemi
// Last Change : 2023/12/08 23:46:52.
// =============================================================================

import type { Plug } from "https://deno.land/x/dvpm@3.6.0/mod.ts";

import * as autocmd from "https://deno.land/x/denops_std@v5.1.0/autocmd/mod.ts";
import * as fn from "https://deno.land/x/denops_std@v5.1.0/function/mod.ts";
import * as lambda from "https://deno.land/x/denops_std@v5.1.0/lambda/mod.ts";
import * as mapping from "https://deno.land/x/denops_std@v5.1.0/mapping/mod.ts";
import * as op from "https://deno.land/x/denops_std@v5.1.0/option/mod.ts";
import { batch } from "https://deno.land/x/denops_std@v5.1.0/batch/mod.ts";
import { ensure, is } from "https://deno.land/x/unknownutil@v3.11.0/mod.ts";
import { pluginStatus } from "../main.ts";

export const ddu: Plug[] = [
  {
    url: "https://github.com/Shougo/ddu.vim",
    enabled: pluginStatus.ddu && !pluginStatus.vscode,
    cache: { enabled: false },
    dependencies: [
      { url: "https://github.com/4513ECHO/ddu-kind-url" },
      { url: "https://github.com/4513ECHO/ddu-source-emoji" },
      { url: "https://github.com/4513ECHO/ddu-source-source" },
      { url: "https://github.com/4513ECHO/vim-readme-viewer" },
      { url: "https://github.com/Shougo/ddu-column-filename" },
      { url: "https://github.com/Shougo/ddu-commands.vim" },
      { url: "https://github.com/Shougo/ddu-kind-file" },
      { url: "https://github.com/Shougo/ddu-kind-word" },
      { url: "https://github.com/Shougo/ddu-source-action" },
      { url: "https://github.com/Shougo/ddu-source-dummy" },
      { url: "https://github.com/Shougo/ddu-source-file" },
      { url: "https://github.com/Shougo/ddu-source-file_old" },
      { url: "https://github.com/Shougo/ddu-source-file_point" },
      { url: "https://github.com/Shougo/ddu-source-file_rec" },
      { url: "https://github.com/Shougo/ddu-source-line" },
      { url: "https://github.com/Shougo/ddu-source-path_history" },
      { url: "https://github.com/Shougo/ddu-source-register" },
      { url: "https://github.com/Shougo/ddu-ui-ff" },
      { url: "https://github.com/Shougo/ddu-ui-filer" },
      { url: "https://github.com/Shougo/junkfile.vim" },
      { url: "https://github.com/kamecha/ddu-source-jumplist" },
      { url: "https://github.com/kuuote/ddu-filter-fuse" },
      { url: "https://github.com/kuuote/ddu-source-git_status" },
      { url: "https://github.com/kyoh86/ddu-filter-converter_hl_dir" },
      { url: "https://github.com/kyoh86/ddu-source-command" },
      { url: "https://github.com/matsui54/ddu-source-command_history" },
      { url: "https://github.com/matsui54/ddu-source-file_external" },
      { url: "https://github.com/matsui54/ddu-source-help" },
      { url: "https://github.com/shun/ddu-source-buffer" },
      { url: "https://github.com/shun/ddu-source-rg" },
      { url: "https://github.com/uga-rosa/ddu-filter-converter_devicon" },
      { url: "https://github.com/uga-rosa/ddu-source-lsp" },
      { url: "https://github.com/uga-rosa/ddu-source-search_history" },
      { url: "https://github.com/yuki-yano/ddu-filter-fzf" },
      { url: "https://github.com/yuki-yano/ddu-source-nvim-notify" },
      { url: "https://github.com/Milly/ddu-filter-merge" },
      {
        url: "https://github.com/Milly/ddu-filter-kensaku",
        dependencies: [{ url: "https://github.com/lambdalisue/kensaku.vim" }],
      },
      {
        url: "https://github.com/matsui54/ddu-vim-ui-select",
        // deno-lint-ignore require-await
        enabled: async ({ denops }) => denops.meta.host === "nvim" && false,
      },
      {
        url: "https://github.com/yukimemi/ddu-source-chronicle",
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
        "<leader>dO",
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
        `<cmd>Ddu -name=files external_fd<cr>`,
        { mode: "n" },
      );
      await mapping.map(
        denops,
        "<leader>do",
        `<cmd>Ddu -name=chronicle-read chronicle -source-param-chronicle-kind='read'<cr>`,
        {
          mode: "n",
        },
      );
      await mapping.map(
        denops,
        "<leader>dw",
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
        "<cmd>Ddu -name=search -resume -ui-param-ff-startFilter=v:false<cr>",
        { mode: "n" },
      );
    },
    after: async ({ denops }) => {
      // aliases.
      await denops.call(
        "ddu#custom#alias",
        "source",
        "external_fd",
        "file_external",
      );
      await denops.call(
        "ddu#custom#alias",
        "source",
        "external_git",
        "file_external",
      );

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
                const height = Math.floor(lines * 0.5);
                await denops.call("ddu#custom#patch_global", {
                  ui: "ff",
                  uiOptions: {
                    filer: {
                      toggle: false,
                    },
                  },
                  uiParams: {
                    ff: {
                      ignoreEmpty: true,
                      prompt: "»",
                      split: "horizontal",
                      startAutoAction: true,
                      startFilter: true,
                      filterSplitDirection: "floating",
                      filterFloatingPosition: "bottom",
                      previewHeight: height,
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
                    external_git: {
                      cmd: ["git", "ls-files", "-co", "--exclude-standard"],
                    },
                    external_fd: {
                      cmd: [
                        "fd",
                        "--hidden",
                        "--no-ignore",
                        "--exclude",
                        "node_modules",
                        "--exclude",
                        ".git",
                      ],
                      updateItems: 50000,
                    },
                    rg: {
                      args: [
                        "--hidden",
                        "--ignore-case",
                        "--column",
                        "--no-heading",
                        "--color",
                        "never",
                        "--json",
                        "--glob",
                        "!node_modules/**",
                        "--glob",
                        "!**/.git/**",
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
      denops.call(`ddu#load`, "ui", ["ff"]);
      denops.call(`ddu#load`, "source", [
        "chronicle",
        "external_fd",
        "external_git",
        "file",
        "file_external",
        "file_point",
        "file_rec",
        "rg",
      ]);
      denops.call(`ddu#load`, "filter", [
        "matcher_kensaku",
        "mather_fzf",
        "merge",
      ]);
      denops.call(`ddu#load`, "kind", ["file"]);
    },
    build: async ({ denops }) => {
      await denops.call(`ddu#set_static_import_path`);
    },
  },
];
