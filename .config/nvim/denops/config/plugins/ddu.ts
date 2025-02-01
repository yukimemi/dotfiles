// =============================================================================
// File        : ddu.ts
// Author      : yukimemi
// Last Change : 2025/02/01 13:35:49.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@6.2.2";

import * as autocmd from "jsr:@denops/std@7.4.0/autocmd";
import * as fn from "jsr:@denops/std@7.4.0/function";
import * as lambda from "jsr:@denops/std@7.4.0/lambda";
import * as mapping from "jsr:@denops/std@7.4.0/mapping";
import * as op from "jsr:@denops/std@7.4.0/option";
import { batch } from "jsr:@denops/std@7.4.0/batch";
import { z } from "npm:zod@3.24.1";
import { notify } from "../util.ts";
import { pluginStatus } from "../pluginstatus.ts";

export const ddu: Plug[] = [
  {
    url: "https://github.com/Shougo/ddu-ui-filer",
    after: async ({ denops }) => {
      if (pluginStatus.ddufiler) {
        await mapping.map(
          denops,
          "<space>e",
          "<Cmd>Ddu -name=filer-`win_getid()` -ui=filer -resume -sync file -source-option-file-path=`t:->get('ddu_ui_filer_path', getcwd())` -source-option-file-columns=filename<CR>",
        );
      }
    },
  },
  {
    url: "https://github.com/Milly/ddu-filter-kensaku",
    dependencies: ["https://github.com/lambdalisue/vim-kensaku"],
  },
  { url: "https://github.com/4513ECHO/ddu-kind-url" },
  { url: "https://github.com/4513ECHO/ddu-source-source" },
  { url: "https://github.com/4513ECHO/vim-readme-viewer" },
  { url: "https://github.com/Milly/ddu-filter-merge" },
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
  { url: "https://github.com/yukimemi/ddu-source-chronicle" },
  {
    url: "https://github.com/Shougo/ddu.vim",
    cache: {
      enabled: true,
      afterFile: `~/.config/nvim/rc/after/ddu.vim`,
    },
    dependencies: [
      "https://github.com/4513ECHO/ddu-kind-url",
      "https://github.com/4513ECHO/ddu-source-source",
      "https://github.com/4513ECHO/vim-readme-viewer",
      "https://github.com/Milly/ddu-filter-kensaku",
      "https://github.com/Milly/ddu-filter-merge",
      "https://github.com/Shougo/ddu-column-filename",
      "https://github.com/Shougo/ddu-commands.vim",
      "https://github.com/Shougo/ddu-kind-file",
      "https://github.com/Shougo/ddu-kind-word",
      "https://github.com/Shougo/ddu-source-action",
      "https://github.com/Shougo/ddu-source-dummy",
      "https://github.com/Shougo/ddu-source-file",
      "https://github.com/Shougo/ddu-source-file_old",
      "https://github.com/Shougo/ddu-source-file_point",
      "https://github.com/Shougo/ddu-source-file_rec",
      "https://github.com/Shougo/ddu-source-line",
      "https://github.com/Shougo/ddu-source-path_history",
      "https://github.com/Shougo/ddu-source-register",
      "https://github.com/Shougo/ddu-ui-ff",
      "https://github.com/Shougo/ddu-ui-filer",
      "https://github.com/Shougo/junkfile.vim",
      "https://github.com/kamecha/ddu-source-jumplist",
      "https://github.com/kuuote/ddu-filter-fuse",
      "https://github.com/kuuote/ddu-source-git_status",
      "https://github.com/kyoh86/ddu-filter-converter_hl_dir",
      "https://github.com/kyoh86/ddu-source-command",
      "https://github.com/matsui54/ddu-source-command_history",
      "https://github.com/matsui54/ddu-source-file_external",
      "https://github.com/matsui54/ddu-source-help",
      "https://github.com/shun/ddu-source-buffer",
      "https://github.com/shun/ddu-source-rg",
      "https://github.com/uga-rosa/ddu-filter-converter_devicon",
      "https://github.com/uga-rosa/ddu-source-lsp",
      "https://github.com/uga-rosa/ddu-source-search_history",
      "https://github.com/yuki-yano/ddu-filter-fzf",
      "https://github.com/yuki-yano/ddu-source-nvim-notify",
      "https://github.com/yukimemi/ddu-source-chronicle",
    ],
    before: async ({ denops }) => {
      await mapping.map(
        denops,
        "<leader>db",
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
                        z.string().parse(await fn.expand(denops, "<cword>")),
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
        "<cmd>Ddu -name=search -resume<cr>",
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
      await denops.call("ddu#custom#patch_global", {
        ui: "ff",
        uiOptions: {
          filer: {
            toggle: true,
          },
        },
        uiParams: {
          ff: {
            ignoreEmpty: true,
            prompt: "» ",
            // split: "floating",
            split: "horizontal",
            floatingBorder: "rounded",
            startAutoAction: true,
            // autoAction: {
            //   name: "preview",
            // },
            // filterSplitDirection: "floating",
            filterSplitDirection: "split",
            filterFloatingPosition: "bottom",
            highlights: {
              floating: "Normal",
              floatingBorder: "Normal",
            },
            winRow: "(&lines - min([70, &lines - 8]) - 3) / 2",
            previewRow: "(&lines - min([70, &lines - 8]) - 3) / 2",
            winHeight: "min([70, &lines - 8])",
            previewHeight: "min([70, &lines - 8])",
            winCol: "&columns / 10",
            previewCol: "&columns / 2",
            winWidth: "&columns * 4 / 10 - 2",
            previewWidth: "&columns * 4 / 10 - 2",
            previewFloating: true,
            previewFloatingBorder: "rounded",
            previewSplit: "vertical",
            previewWindowOptions: [
              ["&signcolumn", "no"],
              ["&foldcolumn", 0],
              ["&foldenable", 0],
              ["&number", 0],
              ["&wrap", 0],
              ["&scrolloff", 0],
            ],
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
                  await op.signcolumn.setLocal(denops, "auto");
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
          "User",
          "Ddu:ui:ff:openFilterWindow",
          `call <SID>${denops.name}_notify("${
            lambda.register(
              denops,
              async () => {
                await batch(denops, async (denops) => {
                  await denops.call(`ddu#ui#ff#save_cmaps`, ["<cr>", "<esc>", "<c-j>", "<c-k>"]);
                  await mapping.map(
                    denops,
                    "<cr>",
                    "<esc><cmd>call ddu#ui#do_action('itemAction')<cr>",
                    { mode: "c", silent: true, noremap: true },
                  );
                  await mapping.map(
                    denops,
                    "<esc>",
                    "<cr><esc>",
                    { mode: "c", silent: true, noremap: true, nowait: true },
                  );
                  await mapping.map(
                    denops,
                    "<c-j>",
                    `<cmd>call ddu#ui#do_action('cursorNext')<cr>`,
                    { mode: "c", silent: true, noremap: true },
                  );
                  await mapping.map(
                    denops,
                    "<c-k>",
                    `<cmd>call ddu#ui#do_action('cursorPrevious')<cr>`,
                    { mode: "c", silent: true, noremap: true },
                  );
                });
              },
            )
          }", [])`,
        );
        helper.define(
          "User",
          "Ddu:ui:ff:closeFilterWindow",
          `call <SID>${denops.name}_notify("${
            lambda.register(
              denops,
              async () => {
                await denops.call(`ddu#ui#ff#restore_cmaps`);
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
    build: async ({ denops, info }) => {
      if (!info.isLoad) {
        return;
      }
      await notify(denops, `call ddu#set_static_import_path()`);
      await denops.call(`ddu#set_static_import_path`);
    },
  },
];
