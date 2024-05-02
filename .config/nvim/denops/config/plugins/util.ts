// =============================================================================
// File        : util.ts
// Author      : yukimemi
// Last Change : 2024/05/02 20:36:39.
// =============================================================================

import type { Plug } from "https://deno.land/x/dvpm@3.10.2/mod.ts";

import * as fn from "https://deno.land/x/denops_std@v6.4.0/function/mod.ts";
import * as mapping from "https://deno.land/x/denops_std@v6.4.0/mapping/mod.ts";
import * as vars from "https://deno.land/x/denops_std@v6.4.0/variable/mod.ts";

import { pluginStatus } from "../pluginstatus.ts";

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
    afterFile: "~/.config/nvim/rc/after/size-matters.lua",
  },
  {
    url: "https://github.com/gaoDean/autolist.nvim",
    enabled: false,
    afterFile: "~/.config/nvim/rc/after/autolist.lua",
  },
  {
    url: "https://github.com/thinca/vim-winenv",
    enabled: Deno.build.os === "windows",
  },
  {
    url: "https://github.com/folke/todo-comments.nvim",
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
    enabled: false,
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
    enabled: false,
    afterFile: "~/.config/nvim/rc/after/other.lua",
  },
  {
    url: "https://github.com/kuuote/jsonyaml.vim",
    afterFile: "~/.config/nvim/rc/after/jsonyaml.vim",
  },
  {
    url: "https://github.com/yukimemi/jsontoml.vim",
    dst: "~/src/github.com/yukimemi/jsontoml.vim",
    afterFile: "~/.config/nvim/rc/after/jsontoml.vim",
  },
  {
    url: "https://github.com/bennypowers/nvim-regexplainer",
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
    enabled: Deno.build.os !== "windows",
    clone: false,
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("zone").setup(_A)`, {
        after: 180,
      });
    },
  },
  {
    url: "https://github.com/stefanlogue/hydrate.nvim",
    enabled: false,
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("hydrate").setup()`);
    },
  },
  {
    url: "https://github.com/kevinhwang91/nvim-bqf",
    enabled: !pluginStatus.vscode,
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("bqf").setup()`);
    },
  },
  { url: "https://github.com/thinca/vim-prettyprint" },
  { url: "https://github.com/skanehira/denops-silicon.vim" },
  {
    url: "https://github.com/VidocqH/data-viewer.nvim",
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
  {
    url: "https://github.com/atusy/treemonkey.nvim",
    afterFile: "~/.config/nvim/rc/after/treemonkey.lua",
  },
  {
    url: "https://github.com/ariel-frischer/bmessages.nvim",
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("bmessages").setup()`);
    },
  },
  {
    url: "https://github.com/m00qek/baleia.nvim",
    afterFile: "~/.config/nvim/rc/after/baleia.vim",
  },
  {
    url: "https://github.com/bloznelis/before.nvim",
    afterFile: "~/.config/nvim/rc/after/before.lua",
  },
  {
    url: "https://github.com/lambdalisue/suda.vim",
  },
  {
    url: "https://github.com/mistricky/codesnap.nvim",
    clone: Deno.build.os !== "windows",
    afterFile: "~/.config/nvim/rc/after/codesnap.lua",
    build: async ({ info }) => {
      const output = await (new Deno.Command("make", {
        args: [],
        cwd: info.dst,
      })).output();
      if (output.stdout.length) {
        console.log(new TextDecoder().decode(output.stdout));
      }
      if (output.stderr.length) {
        console.log(new TextDecoder().decode(output.stderr));
      }
    },
  },
  {
    url: "https://github.com/tani/dmacro.nvim",
    afterFile: "~/.config/nvim/rc/after/dmacro.lua",
  },
  { url: "https://github.com/tweekmonster/helpful.vim" },
  {
    url: "https://github.com/fabridamicelli/cronex.nvim",
    enabled: false,
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("cronex").setup()`);
    },
  },
  {
    url: "https://github.com/Diogo-ss/licenser.nvim",
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("licenser").setup()`);
    },
  },
  {
    url: "https://github.com/tomasky/bookmarks.nvim",
    afterFile: `~/.config/nvim/rc/after/bookmarks.lua`,
  },
  {
    url: "https://github.com/itchyny/calendar.vim",
    enabled: false,
    after: async ({ denops }) => {
      await mapping.map(
        denops,
        "mc",
        "<cmd>Calendar -view=year -split=vertical -position=right -width=27<cr>",
        { mode: "n" },
      );
    },
  },
];
