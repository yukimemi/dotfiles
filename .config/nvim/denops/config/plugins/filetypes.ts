// =============================================================================
// File        : filetypes.ts
// Author      : yukimemi
// Last Change : 2023/09/01 22:09:04.
// =============================================================================

import type { Plug } from "https://deno.land/x/dvpm@3.3.2/mod.ts";

import * as autocmd from "https://deno.land/x/denops_std@v5.0.1/autocmd/mod.ts";
import * as fn from "https://deno.land/x/denops_std@v5.0.1/function/mod.ts";
import * as lambda from "https://deno.land/x/denops_std@v5.0.1/lambda/mod.ts";
import * as mapping from "https://deno.land/x/denops_std@v5.0.1/mapping/mod.ts";
import { globals } from "https://deno.land/x/denops_std@v5.0.1/variable/mod.ts";
import { pluginStatus } from "../main.ts";

export const filetypes: Plug[] = [
  // all filetypes
  {
    url: "uga-rosa/scorpeon.vim",
    enabled: !pluginStatus.vscode && false,
    before: async ({ denops }) => {
      await globals.set(denops, "scorpeon_extensions_path", [
        await fn.expand(denops, "~/.cache/vscode/extensions"),
        await fn.expand(denops, "~/.cache/scorpeon"),
      ]);
      await globals.set(denops, "scorpeon_highlight", {
        enable: ["log", "toml", "nim"],
      });
      await autocmd.group(denops, "MyScorpeon", (helper) => {
        helper.remove("*");
        helper.define(["BufNewFile", "BufRead"], "*.log", "setl ft=log");
        helper.define(["BufNewFile", "BufRead"], "*.nim", "setl ft=nim");
        helper.define(["BufNewFile", "BufRead"], "*.toml", "setl ft=toml");
      });
    },
    dependencies: [
      {
        url: "microsoft/vscode",
        dst: "~/.cache/vscode",
        enabled: false,
      },
      {
        url: "saem/vscode-nim",
        dst: "~/.cache/scorpeon/nim",
        enabled: false,
      },
      {
        url: "oovm/vscode-toml",
        dst: "~/.cache/scorpeon/toml",
        enabled: false,
      },
      {
        url: "emilast/vscode-logfile-highlighter",
        dst: "~/.cache/scorpeon/log",
        enabled: false,
      },
    ],
  },
  // plantuml
  {
    url: "aklt/plantuml-syntax",
    enabled: !pluginStatus.vscode,
    before: async ({ denops }) => {
      await autocmd.group(denops, "MyPlantUml", (helper) => {
        helper.remove("*");
        helper.define(
          ["BufNewFile", "BufRead"],
          ["*.uml", "*.plantuml"],
          "setl ft=plantuml",
        );
      });
    },
  },
  // markdown
  {
    url: "tani/glance-vim",
    enabled: false,
    dependencies: [{ url: "tani/podium" }],
    before: async ({ denops }) => {
      await globals.set(denops, "glance#markdown_breaks", true);
      await globals.set(denops, "glance#markdown_html", true);
      await globals.set(denops, "glance#plugins", [
        "https://esm.sh/markdown-it-emoji",
        "https://esm.sh/markdown-it-highlightjs",
      ]);

      // await globals.set(
      //   denops,
      //   "glance#config",
      //   `file:///${await fn.expand(denops, "~/.config/glance/init.ts")}`,
      // );
    },
  },
  {
    url: "iamcco/markdown-preview.nvim",
    enabled: false,
    build: async ({ denops }) => {
      await denops.call("mkdp#util#install");
    },
    before: async ({ denops }) => {
      await globals.set(denops, "mkdp_auto_close", 0);
      await globals.set(denops, "mkdp_refresh_slow ", 0);
      // await globals.set(denops, "mkdp_theme ", "dark");
    },
  },
  {
    url: "previm/previm",
    enabled: !pluginStatus.vscode,
    dependencies: [
      { url: "tyru/open-browser.vim" },
    ],
    before: async ({ denops }) => {
      await globals.set(denops, "previm_enable_realtime", 1);
      await globals.set(denops, "previm_show_header", 0);
      await globals.set(denops, "previm_extra_libraries", [
        {
          name: "githubcss",
          files: [
            {
              type: "css",
              path: "_/css/extra/github.css",
              url: "https://cdn.jsdelivr.net/npm/github-markdown-css/github-markdown.min.css",
            },
          ],
        },
      ]);
    },
  },
  { url: "dhruvasagar/vim-table-mode" },
  // vim
  { url: "machakann/vim-vimhelplint" },
  {
    url: "4513ECHO/vim-vimhelp-hoptag",
    enabled: !pluginStatus.vscode,
    after: async ({ denops }) => {
      await autocmd.group(denops, "MyVimHelpHopTag", (helper) => {
        helper.remove("*");
        helper.define(
          "FileType",
          "help",
          `call <SID>${denops.name}_notify("${
            lambda.register(
              denops,
              async () => {
                await mapping.map(
                  denops,
                  "<c-n>",
                  `<Plug>(hoptag-next)`,
                  { mode: "n", buffer: true, silent: true, noremap: false },
                );
                await mapping.map(
                  denops,
                  "<c-p>",
                  `<Plug>(hoptag-prev)`,
                  { mode: "n", buffer: true, silent: true, noremap: false },
                );
              },
            )
          }", [])`,
        );
      });
    },
  },
  // Rust
  {
    url: "Saecki/crates.nvim",
    enabled: !pluginStatus.vscode,
    after: async ({ denops }) => {
      await autocmd.group(denops, "MyRustSettings", (helper) => {
        helper.remove("*");
        helper.define(
          ["BufNewFile", "BufRead"],
          "*.rs,*.toml",
          `lua require("crates").setup()`,
        );
      });
    },
  },
  // kdl
  {
    url: "imsnif/kdl.vim",
    before: async ({ denops }) => {
      await autocmd.group(denops, "MyKdl", (helper) => {
        helper.remove("*");
        helper.define(
          ["BufNewFile", "BufRead"],
          ["*.kdl"],
          "setl ft=kdl",
        );
      });
    },
  },
];
