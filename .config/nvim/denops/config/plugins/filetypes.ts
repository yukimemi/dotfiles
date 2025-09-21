// =============================================================================
// File        : filetypes.ts
// Author      : yukimemi
// Last Change : 2025/09/21 17:14:19.
// =============================================================================

import type { Plug } from "@yukimemi/dvpm";

import * as autocmd from "@denops/std/autocmd";
import * as lambda from "@denops/std/lambda";
import * as mapping from "@denops/std/mapping";
import * as vars from "@denops/std/variable";

export const filetypes: Plug[] = [
  // all filetypes
  { url: "https://github.com/sheerun/vim-polyglot" },
  // plantuml
  {
    url: "https://github.com/aklt/plantuml-syntax",
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
  { url: "https://github.com/tani/podium" },
  {
    url: "https://github.com/tani/glance-vim",
    profiles: ["markdown"],
    enabled: true,
    dependencies: ["https://github.com/tani/podium"],
    // before: async ({ denops }) => {
    // await vars.g.set(denops, "glance#markdown_breaks", true);
    // await vars.g.set(denops, "glance#markdown_html", true);
    // await vars.g.set(denops, "glance#plugins", [
    //   "https://esm.sh/markdown-it-emoji",
    //   "https://esm.sh/markdown-it-highlightjs",
    //   "https://esm.sh/markdown-it-mermaid-plugin",
    //   "https://esm.sh/markdown-it-plantuml",
    // ]);

    // await vars.g.set(
    //   denops,
    //   "glance#config",
    //   `file:///${await fn.expand(denops, "~/.config/glance/init.ts")}`,
    // );
    // },
  },
  {
    url: "https://github.com/iamcco/markdown-preview.nvim",
    enabled: false,
    build: async ({ denops, info }) => {
      if (info.isUpdate && info.isLoad) {
        await denops.call("mkdp#util#install");
      }
    },
    before: async ({ denops }) => {
      await vars.g.set(denops, "mkdp_auto_close", 0);
      await vars.g.set(denops, "mkdp_refresh_slow ", 0);
      // await vars.g.set(denops, "mkdp_theme ", "dark");
    },
  },
  {
    url: "https://github.com/previm/previm",
    profiles: ["markdown"],
    enabled: false,
    dependencies: ["https://github.com/tyru/open-browser.vim"],
    before: async ({ denops }) => {
      await vars.g.set(denops, "previm_enable_realtime", 1);
      await vars.g.set(denops, "previm_show_header", 0);
      await vars.g.set(denops, "previm_extra_libraries", [
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
  {
    url: "https://github.com/OXY2DEV/markview.nvim",
    dependencies: ["https://github.com/nvim-treesitter/nvim-treesitter"],
    profiles: ["markdown"],
    enabled: true,
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require('markview').setup(_A)`, {
        experimental: {
          check_rtp_message: false,
        },
      });
    },
  },
  {
    url: "https://github.com/dhruvasagar/vim-table-mode",
    profiles: ["markdown"],
  },
  { url: "https://github.com/ixru/nvim-markdown" },
  {
    url: "https://github.com/MeanderingProgrammer/render-markdown.nvim",
    profiles: ["markdown"],
    enabled: false,
    dependencies: ["https://github.com/nvim-treesitter/nvim-treesitter"],
    afterFile: "~/.config/nvim/rc/after/render-markdown.lua",
  },
  {
    url: "https://github.com/tree-sitter-grammars/tree-sitter-markdown",
    profiles: ["full"],
  },
  {
    url: "https://github.com/tadmccorkle/markdown.nvim",
    enabled: false,
    dependencies: [
      "https://github.com/nvim-treesitter/nvim-treesitter",
      "https://github.com/tree-sitter-grammars/tree-sitter-markdown",
    ],
    afterFile: "~/.config/nvim/rc/after/markdown.lua",
  },
  {
    url: "https://github.com/roodolv/markdown-toggle.nvim",
    profiles: ["markdown"],
    afterFile: "~/.config/nvim/rc/after/markdown-toggle.lua",
  },
  // vim
  { url: "https://github.com/machakann/vim-vimhelplint" },
  {
    url: "https://github.com/4513ECHO/vim-vimhelp-hoptag",
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
    url: "https://github.com/Saecki/crates.nvim",
    profiles: ["rust"],
    after: async ({ denops }) => {
      await autocmd.group(denops, "MyRustSettings", (helper) => {
        helper.remove("*");
        helper.define(
          ["BufNewFile", "BufRead"],
          "*.rs,*.toml",
          `lua require("crates").setup()`,
        );
        helper.define(
          ["BufNewFile", "BufRead"],
          "Cargo.toml",
          `call <SID>${denops.name}_notify("${
            lambda.register(
              denops,
              async () => {
                await mapping.map(
                  denops,
                  "<leader>ct",
                  "<cmd>lua require('crates').toggle()<cr>",
                  { mode: "n", buffer: true, silent: true, noremap: true },
                );
                await mapping.map(
                  denops,
                  "<leader>cr",
                  "<cmd>lua require('crates').reload()<cr>",
                  { mode: "n", buffer: true, silent: true, noremap: true },
                );
                await mapping.map(
                  denops,
                  "<leader>cv",
                  "<cmd>lua require('crates').show_versions_popup()<cr>",
                  { mode: "n", buffer: true, silent: true, noremap: true },
                );
                await mapping.map(
                  denops,
                  "<leader>cf",
                  "<cmd>lua require('crates').show_features_popup()<cr>",
                  { mode: "n", buffer: true, silent: true, noremap: true },
                );
                await mapping.map(
                  denops,
                  "<leader>cd",
                  "<cmd>lua require('crates').show_dependencies_popup()<cr>",
                  { mode: "n", buffer: true, silent: true, noremap: true },
                );

                await mapping.map(
                  denops,
                  "<leader>cu",
                  "<cmd>lua require('crates').update_crate()<cr>",
                  { mode: "n", buffer: true, silent: true, noremap: true },
                );
                await mapping.map(
                  denops,
                  "<leader>cu",
                  "<cmd>lua require('crates').update_crates()<cr>",
                  { mode: "n", buffer: true, silent: true, noremap: true },
                );
                await mapping.map(
                  denops,
                  "<leader>ca",
                  "<cmd>lua require('crates').update_all_crates()<cr>",
                  { mode: "n", buffer: true, silent: true, noremap: true },
                );
                await mapping.map(
                  denops,
                  "<leader>cU",
                  "<cmd>lua require('crates').upgrade_crate()<cr>",
                  { mode: "n", buffer: true, silent: true, noremap: true },
                );
                await mapping.map(
                  denops,
                  "<leader>cU",
                  "<cmd>lua require('crates').upgrade_crates()<cr>",
                  { mode: "n", buffer: true, silent: true, noremap: true },
                );
                await mapping.map(
                  denops,
                  "<leader>cA",
                  "<cmd>lua require('crates').upgrade_all_crates()<cr>",
                  { mode: "n", buffer: true, silent: true, noremap: true },
                );

                await mapping.map(
                  denops,
                  "<leader>cx",
                  "<cmd>lua require('crates').expand_plain_crate_to_inline_table()<cr>",
                  { mode: "n", buffer: true, silent: true, noremap: true },
                );
                await mapping.map(
                  denops,
                  "<leader>cX",
                  "<cmd>lua require('crates').extract_crate_into_table()<cr>",
                  { mode: "n", buffer: true, silent: true, noremap: true },
                );

                await mapping.map(
                  denops,
                  "<leader>cH",
                  "<cmd>lua require('crates').open_homepage()<cr>",
                  { mode: "n", buffer: true, silent: true, noremap: true },
                );
                await mapping.map(
                  denops,
                  "<leader>cR",
                  "<cmd>lua require('crates').open_repository()<cr>",
                  { mode: "n", buffer: true, silent: true, noremap: true },
                );
                await mapping.map(
                  denops,
                  "<leader>cD",
                  "<cmd>lua require('crates').open_documentation()<cr>",
                  { mode: "n", buffer: true, silent: true, noremap: true },
                );
                await mapping.map(
                  denops,
                  "<leader>cC",
                  "<cmd>lua require('crates').open_crates_io()<cr>",
                  { mode: "n", buffer: true, silent: true, noremap: true },
                );
              },
            )
          }", [])`,
        );
      });
    },
  },
  // cargo-make
  { url: "https://github.com/nastevens/vim-cargo-make" },
  // kdl
  {
    url: "https://github.com/imsnif/kdl.vim",
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
  // deno
  {
    url: "https://github.com/lambdalisue/vim-deno-cache",
    profiles: ["full"],
  },
  // nushell
  {
    url: "https://github.com/LhKipp/nvim-nu",
    enabled: false,
    build: async ({ denops, info }) => {
      if (info.isUpdate && info.isLoad) {
        await denops.cmd("TSUpdate nu");
      }
    },
    dependencies: [
      "https://github.com/nvim-treesitter/nvim-treesitter",
      "https://github.com/nvimtools/none-ls.nvim",
    ],
    beforeFile: "~/.config/nvim/rc/after/nvim-nu.lua",
  },
  // log
  {
    url: "https://github.com/fei6409/log-highlight.nvim",
    profiles: ["log"],
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require('log-highlight').setup({})`);
    },
  },
];
