import type { Denops } from "https://deno.land/x/denops_std@v5.0.0/mod.ts";
import type { Plug } from "https://deno.land/x/dvpm@0.3.6/mod.ts";

import * as fn from "https://deno.land/x/denops_std@v5.0.0/function/mod.ts";
import * as mapping from "https://deno.land/x/denops_std@v5.0.0/mapping/mod.ts";
import { expand } from "https://deno.land/x/denops_std@v5.0.0/function/mod.ts";
import { globals } from "https://deno.land/x/denops_std@v5.0.0/variable/mod.ts";

export const util: Plug[] = [
  { url: "tyru/capture.vim" },
  { url: "dstein64/vim-startuptime" },
  {
    url: "thinca/vim-partedit",
    before: async (denops: Denops) => {
      await globals.set(denops, "partedit#opener", "vsplit");
    },
  },
  {
    url: "glidenote/memolist.vim",
    before: async (denops: Denops) => {
      await globals.set(
        denops,
        "memolist_path",
        await expand(denops, "~/.memolist"),
      );
      await globals.set(denops, "memolist_memo_suffix", "md");
      await globals.set(denops, "memolist_prompt_tags", 1);

      await mapping.map(denops, "<leader>mn", "<cmd>MemoNew<cr>", {
        mode: "n",
      });
      await mapping.map(denops, "<leader>ml", "<cmd>MemoList<cr>", {
        mode: "n",
      });
    },
  },
  {
    url: "ahmedkhalf/project.nvim",
    enabled: async (denops: Denops) => await fn.has(denops, "nvim"),
    after: async (denops: Denops) => {
      await denops.call(`luaeval`, `require("project_nvim").setup(_A.param)`, {
        param: {
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
        },
      });
    },
  },
  {
    url: "uga-rosa/ccc.nvim",
    after: async (denops: Denops) => {
      await denops.call(`luaeval`, `require("ccc").setup(_A.param)`, {
        param: {
          highlighter: {
            auto_enable: true,
            lsp: true,
          },
        },
      });
    },
  },
  {
    url: "junegunn/vim-easy-align",
    before: async (denops: Denops) => {
      await mapping.map(denops, "<enter>", "<Plug>(EasyAlign)", { mode: "v" });
      await globals.set(denops, "easy_align_delimiters", {
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
    url: "thinca/vim-ambicmd",
    after: async (denops: Denops) => {
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
    url: "stevearc/stickybuf.nvim",
    enabled: async (denops: Denops) => await fn.has(denops, "nvim"),
    after: async (denops: Denops) => {
      await denops.cmd(`lua require("stickybuf").setup()`);
    },
  },
  { url: "tani/glance-vim" },
  { url: "ryoppippi/bad-apple.vim" },
];
