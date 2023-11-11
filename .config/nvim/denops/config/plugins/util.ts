// =============================================================================
// File        : util.ts
// Author      : yukimemi
// Last Change : 2023/11/11 22:29:13.
// =============================================================================

import type { Plug } from "https://deno.land/x/dvpm@3.5.0/mod.ts";

import * as fn from "https://deno.land/x/denops_std@v5.0.1/function/mod.ts";
import * as mapping from "https://deno.land/x/denops_std@v5.0.1/mapping/mod.ts";
import * as vars from "https://deno.land/x/denops_std@v5.0.1/variable/mod.ts";
import { execute } from "https://deno.land/x/denops_std@v5.0.1/helper/mod.ts";

import { pluginStatus } from "../main.ts";

export const util: Plug[] = [
  {
    url: "https://github.com/tyru/capture.vim",
    after: async ({ denops }) => {
      await mapping.map(denops, "<C-c>", "<home>Capture <cr>", { mode: "c" });
    },
  },
  { url: "https://github.com/dstein64/vim-startuptime" },
  {
    url: "https://github.com/thinca/vim-partedit",
    before: async ({ denops }) => {
      await vars.g.set(denops, "partedit#opener", "vsplit");
    },
  },
  {
    url: "https://github.com/ahmedkhalf/project.nvim",
    // deno-lint-ignore require-await
    enabled: async ({ denops }) => denops.meta.host === "nvim",
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("project_nvim").setup(_A)`, {
        // Manual mode doesn't automatically change your root directory, so you have
        // the option to manually do so using `:ProjectRoot` command.
        manual_mode: false,

        // Methods of detecting the root directory. **"lsp"** uses the native neovim
        // lsp, while **"pattern"** uses vim-rooter like glob pattern matching. Here
        // order matters: if one is not detected, the other is used as fallback. You
        // can also delete or rearangne the detection methods.
        detection_methods: ["lsp", "pattern"],

        // All the patterns used to detect root dir, when **"pattern"** is in
        // detection_methods
        patterns: [
          ".git",
          "_darcs",
          ".hg",
          ".bzr",
          ".svn",
          "Makefile",
          "package.json",
        ],

        // Table of lsp clients to ignore by name
        // eg: { "efm", ... }
        ignore_lsp: [],

        // Don't calculate root dir on specific directories
        // Ex: { "~/.cargo/*", ... }
        exclude_dirs: [],

        // Show hidden files in telescope
        show_hidden: false,

        // When set to false, you will get a message when project.nvim changes your
        // directory.
        silent_chdir: true,

        // What scope to change the directory, valid options are
        // * global (default)
        // * tab
        // * win
        scope_chdir: "global",
      });
    },
  },
  {
    url: "https://github.com/uga-rosa/ccc.nvim",
    // deno-lint-ignore require-await
    enabled: async ({ denops }) => denops.meta.host === "nvim",
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("ccc").setup(_A)`, {
        highlighter: {
          auto_enable: true,
          lsp: true,
        },
      });
    },
  },
  {
    url: "https://github.com/junegunn/vim-easy-align",
    before: async ({ denops }) => {
      await mapping.map(denops, "<enter>", "<Plug>(EasyAlign)", { mode: "v" });
      await vars.g.set(denops, "easy_align_delimiters", {
        ">": {
          "pattern": ">>\|=>\|>.\+",
          "right_margin": 0,
          "delimiter_align": "l",
        },
        "/": {
          "pattern": "//\+\|/\*\|\*/",
          "delimiter_align": "l",
          "ignore_groups": ["!Comment"],
        },
        ".": {
          "pattern": "/",
          "left_margin": 1,
          "right_margin": 1,
          "stick_to_left": 0,
          "ignore_groups": [],
        },
        "]": {
          "pattern": "[[\]]",
          "left_margin": 0,
          "right_margin": 0,
          "stick_to_left": 0,
        },
        ")": {
          "pattern": "[()]",
          "left_margin": 0,
          "right_margin": 0,
          "stick_to_left": 0,
        },
        "d": {
          "pattern": " \(\S\+\s*[;=]\)\@=",
          "left_margin": 0,
          "right_margin": 0,
        },
        "p": {
          "pattern": "pos=\|size=",
          "right_margin": 0,
        },
        "s": {
          "pattern": "sys=\|Trns=",
          "right_margin": 0,
        },
        "k": {
          "pattern": "key=\|cmt=",
          "right_margin": 0,
        },
        "c": {
          "pattern": "cmt=",
          "right_margin": 0,
        },
        ":": {
          "pattern": ":",
          "left_margin": 0,
          "right_margin": 1,
          "stick_to_left": 0,
          "ignore_groups": [],
        },
        "t": {
          "pattern": "\<tab>",
          "left_margin": 0,
          "right_margin": 0,
        },
        ";": {
          "pattern": ";",
          "left_margin": 1,
          "right_margin": 1,
          "stick_to_left": 0,
          "ignore_groups": [],
        },
        "|": {
          "pattern": "|",
          "left_margin": 1,
          "right_margin": 1,
          "stick_to_left": 0,
          "ignore_groups": [],
        },
      });
    },
  },
  {
    url: "https://github.com/thinca/vim-ambicmd",
    after: async ({ denops }) => {
      await mapping.map(denops, "<space>", `ambicmd#expand("<space>")`, {
        mode: "c",
        expr: true,
      });
      await mapping.map(denops, "<cr>", `ambicmd#expand("<cr>")`, {
        mode: "c",
        expr: true,
      });
      await mapping.map(denops, "<c-f>", `ambicmd#expand("<right>")`, {
        mode: "c",
        expr: true,
      });
    },
  },
  {
    url: "https://github.com/stevearc/stickybuf.nvim",
    // deno-lint-ignore require-await
    enabled: async ({ denops }) => denops.meta.host === "nvim",
    after: async ({ denops }) => {
      await denops.cmd(`lua require("stickybuf").setup()`);
    },
  },
  { url: "https://github.com/ryoppippi/bad-apple.vim" },
  { url: "https://github.com/vim-jp/vital.vim" },
  { url: "https://github.com/hrsh7th/vim-vital-vs" },
  { url: "https://github.com/chrisbra/Recover.vim" },
  {
    url: "https://github.com/anuvyklack/windows.nvim",
    enabled: true,
    dependencies: [
      { url: "https://github.com/anuvyklack/middleclass" },
      { url: "https://github.com/anuvyklack/animation.nvim" },
    ],
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("windows").setup(_A)`, {
        autowidth: {
          enable: true,
          winwidth: 5,
          filetype: {
            help: 2,
          },
        },
        ignore: {
          buftype: ["quickfix"],
          filetype: [
            "NvimTree",
            "neo-tree",
            "coc-explorer",
            "undotree",
            "gundo",
            "aerial",
            "ddu",
            "ddu-ff",
            "ddu-filter",
          ],
        },
        animation: {
          enable: true,
          duration: 300,
          fps: 30,
          easing: "in_out_sine",
        },
      });
      await mapping.map(denops, "sz", "<cmd>WindowsMaximize<cr>", {
        mode: "n",
      });
      await mapping.map(denops, "s_", "<cmd>WindowsMaximizeVertically<cr>", {
        mode: "n",
      });
      await mapping.map(
        denops,
        "s\\|",
        "<cmd>WindowsMaximizeHorizontally<cr>",
        {
          mode: "n",
        },
      );
      await mapping.map(denops, "s=", "<cmd>WindowsEqualize<cr>", {
        mode: "n",
      });
    },
  },
  {
    url: "https://github.com/simeji/winresizer",
    before: async ({ denops }) => {
      await vars.g.set(denops, "winresizer_gui_enable", 1);
    },
  },
  {
    url: "https://github.com/tenxsoydev/size-matters.nvim",
    // deno-lint-ignore require-await
    enabled: async ({ denops }) => denops.meta.host === "nvim",
    after: async ({ denops }) => {
      await mapping.map(denops, "+", "<cmd>FontSizeUp<cr>", { mode: "n" });
      await mapping.map(denops, "-", "<cmd>FontSizeDown<cr>", { mode: "n" });
      await execute(
        denops,
        `
        lua << EOB
          require("size-matters").setup({
            default_mappings = true,
            -- font resize step size
            step_size = 1,
            notifications = {
              -- default value is true if notify is installed else false
              enable = false,
              -- ms how long a notifiation will be shown
              timeout = 150,
              -- depending on the client and if using multigrid, the time it takes for the client to re-render
              -- after a font size change can affect the position of the notification. Displaying it with a delay remedies this.
              delay = 200,
            },
            reset_font = vim.api.nvim_get_option("guifont"), -- Font loaded when using the reset cmd / shortcut
          })
        EOB
        `,
      );
    },
  },
  {
    url: "https://github.com/gaoDean/autolist.nvim",
    // deno-lint-ignore require-await
    enabled: async ({ denops }) => denops.meta.host === "nvim" && false,
    after: async ({ denops }) => {
      await execute(
        denops,
        `
        lua << EOB
          local autolist = require("autolist")
          autolist.setup()
          autolist.create_mapping_hook("i", "<CR>", autolist.new)
          autolist.create_mapping_hook("i", "<Tab>", autolist.indent)
          autolist.create_mapping_hook("i", "<S-Tab>", autolist.indent, "<C-D>")
          autolist.create_mapping_hook("n", "o", autolist.new)
          autolist.create_mapping_hook("n", "O", autolist.new_before)
          autolist.create_mapping_hook("n", ">>", autolist.indent)
          autolist.create_mapping_hook("n", "<<", autolist.indent)
          autolist.create_mapping_hook("n", "<C-r>", autolist.force_recalculate)
          autolist.create_mapping_hook("n", "<leader>x", autolist.invert_entry, "")
        EOB
        `,
      );
    },
  },
  {
    url: "https://github.com/thinca/vim-winenv",
    enabled: Deno.build.os === "windows",
  },
  {
    url: "https://github.com/folke/todo-comments.nvim",
    // deno-lint-ignore require-await
    enabled: async ({ denops }) => denops.meta.host === "nvim",
    dependencies: [
      { url: "https://github.com/nvim-lua/plenary.nvim" },
    ],
    after: async ({ denops }) => {
      await denops.cmd(`lua require("todo-comments").setup()`);
    },
  },
  {
    url: "https://github.com/thinca/vim-singleton",
    enabled: async ({ denops }) => await fn.has(denops, "clientserver"),
    clone: async ({ denops }) => await fn.has(denops, "clientserver"),
    cache: {
      after: `call singleton#enable()`,
    },
  },
  { url: "https://github.com/skanehira/denops-translate.vim" },
  {
    url: "https://github.com/mattn/vim-sonictemplate",
    before: async ({ denops }) => {
      await vars.g.set(
        denops,
        "sonictemplate_vim_template_dir",
        await fn.expand(denops, "~/.config/nvim/template"),
      );
      await vars.g.set(
        denops,
        "sonictemplate_vim_vars",
        {
          "_": {
            "author": "yukimemi",
          },
        },
      );
    },
  },
  {
    url: "https://github.com/kevinhwang91/nvim-fundo",
    // deno-lint-ignore require-await
    enabled: async ({ denops }) => denops.meta.host === "nvim",
    dependencies: [
      { url: "https://github.com/kevinhwang91/promise-async" },
    ],
    build: async ({ denops }) => {
      await denops.cmd(`lua require("fundo").install()`);
    },
    after: async ({ denops }) => {
      await vars.o.set(denops, "undofile", true);
      await denops.cmd(`lua require("fundo").setup()`);
    },
  },
  {
    url: "https://github.com/m4xshen/hardtime.nvim",
    // deno-lint-ignore require-await
    enabled: async ({ denops }) => denops.meta.host === "nvim" && false,
    dependencies: [
      { url: "https://github.com/nvim-lua/plenary.nvim" },
      { url: "https://github.com/MunifTanjim/nui.nvim" },
    ],
    after: async ({ denops }) => {
      await denops.cmd(`lua require("hardtime").setup()`);
    },
  },
  {
    url: "https://github.com/rgroli/other.nvim",
    // deno-lint-ignore require-await
    enabled: async ({ denops }) => denops.meta.host === "nvim" && false,
    after: async ({ denops }) => {
      await denops.cmd(`lua require("other-nvim").setup(_A)`, {
        mappings: [
          "livewire",
          "angular",
          "laravel",
          "rails",
          "golang",
        ],
      });
    },
  },
  {
    url: "https://github.com/kuuote/jsonyaml.vim",
    after: async ({ denops }) => {
      await execute(
        denops,
        `
          command! -range=% JY call denops#request('jsonyaml', 'jsonYAML', [<line1>, <line2>])
          command! -range=% YJ call denops#request('jsonyaml', 'yamlJSON', [<line1>, <line2>])
        `,
      );
    },
  },
  {
    url: "https://github.com/yukimemi/jsontoml.vim",
    dst: "~/src/github.com/yukimemi/jsontoml.vim",
    after: async ({ denops }) => {
      await execute(
        denops,
        `
          command! -range=% JT call denops#request('jsontoml', 'jsonTOML', [<line1>, <line2>])
          command! -range=% TJ call denops#request('jsontoml', 'tomlJSON', [<line1>, <line2>])
        `,
      );
    },
  },
  {
    url: "https://github.com/bennypowers/nvim-regexplainer",
    // deno-lint-ignore require-await
    enabled: async ({ denops }) => denops.meta.host === "nvim",
    dependencies: [
      { url: "https://github.com/nvim-treesitter/nvim-treesitter" },
      { url: "https://github.com/MunifTanjim/nui.nvim" },
    ],
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("regexplainer").setup(_A)`, {
        mode: "narrative",
        // automatically show the explainer when the cursor enters a regexp
        auto: false,

        // filetypes (i.e. extensions) in which to run the autocommand
        filetypes: ["html", "js", "cjs", "mjs", "ts", "jsx", "tsx", "cjsx", "mjsx"],

        // Whether to log debug messages
        debug: false,

        // 'split', 'popup'
        display: "popup",

        mappings: {
          toggle: "gR",
          // examples, not defaults:
          // show = 'gS',
          // hide = 'gH',
          // show_split = 'gP',
          // show_popup = 'gU',
        },

        narrative: {
          separator: "\n",
        },
      });
    },
  },
  {
    url: "https://github.com/tamton-aquib/zone.nvim",
    // deno-lint-ignore require-await
    enabled: async ({ denops }) => denops.meta.host === "nvim" && Deno.build.os !== "windows",
    clone: false,
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("zone").setup(_A)`, {
        after: 180,
      });
    },
  },
  {
    url: "https://github.com/stefanlogue/hydrate.nvim",
    // deno-lint-ignore require-await
    enabled: async ({ denops }) => denops.meta.host === "nvim" && false,
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("hydrate").setup()`);
    },
  },
  {
    url: "https://github.com/kevinhwang91/nvim-bqf",
    // deno-lint-ignore require-await
    enabled: async ({ denops }) => denops.meta.host === "nvim" && !pluginStatus.vscode,
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("bqf").setup()`);
    },
  },
  { url: "https://github.com/thinca/vim-prettyprint" },
  {
    url: "https://github.com/skanehira/denops-silicon.vim",
  },
  {
    url: "https://github.com/VidocqH/data-viewer.nvim",
    // deno-lint-ignore require-await
    enabled: async ({ denops }) => denops.meta.host === "nvim",
    dependencies: [
      { url: "https://github.com/nvim-lua/plenary.nvim" },
      {
        url: "https://github.com/kkharji/sqlite.lua",
        enabled: Deno.build.os !== "windows",
      },
    ],
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("data-viewer").setup()`);
    },
  },
];
