// =============================================================================
// File        : git.ts
// Author      : yukimemi
// Last Change : 2023/12/30 20:54:01.
// =============================================================================

import type { Plug } from "https://deno.land/x/dvpm@3.8.1/mod.ts";

import * as autocmd from "https://deno.land/x/denops_std@v6.1.0/autocmd/mod.ts";
import * as lambda from "https://deno.land/x/denops_std@v6.1.0/lambda/mod.ts";
import * as mapping from "https://deno.land/x/denops_std@v6.1.0/mapping/mod.ts";
import { pluginStatus } from "../pluginstatus.ts";

export const git: Plug[] = [
  {
    url: "https://github.com/lewis6991/gitsigns.nvim",
    // deno-lint-ignore require-await
    enabled: async ({ denops }) => denops.meta.host === "nvim" && !pluginStatus.vscode,
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("gitsigns").setup(_A)`, {
        signcolumn: true,
        numhl: false,
        linehl: false,
        word_diff: false,
        watch_gitdir: {
          follow_files: true,
        },
        attach_to_untracked: true,
        current_line_blame: true,
        current_line_blame_opts: {
          virt_text: true,
          virt_text_pos: "eol",
          delay: 1000,
          ignore_whitespace: true,
          virt_text_priority: 100,
        },
        current_line_blame_formatter: "<author>, <author_time:%Y-%m-%d> - <summary>",
        sign_priority: 6,
        update_debounce: 100,
        status_formatter: null,
        max_file_length: 40000,
        preview_config: {
          border: "single",
          style: "minimal",
          relative: "cursor",
          row: 0,
          col: 1,
        },
        yadm: {
          enable: false,
        },
      });
      await mapping.map(
        denops,
        "]g",
        `<cmd>lua require("gitsigns").next_hunk()<cr>`,
        {
          mode: "n",
        },
      );
      await mapping.map(
        denops,
        "[g",
        `<cmd>lua require("gitsigns").prev_hunk()<cr>`,
        {
          mode: "n",
        },
      );
    },
  },
  {
    url: "https://github.com/lambdalisue/gin.vim",
    enabled: !pluginStatus.vscode,
    dependencies: [
      { url: "https://github.com/lambdalisue/askpass.vim" },
      { url: "https://github.com/lambdalisue/guise.vim" },
    ],
    before: async ({ denops }) => {
      await mapping.map(denops, "<space>gs", "<cmd>GinStatus<cr>", {
        mode: "n",
      });
      await mapping.map(denops, "<space>gc", "<cmd>Gin commit -v<cr>", {
        mode: "n",
      });
      await mapping.map(denops, "<space>gb", "<cmd>GinBranch<cr>", {
        mode: "n",
      });
      await mapping.map(denops, "<space>gg", "<cmd>Gin grep<cr>", {
        mode: "n",
      });
      await mapping.map(denops, "<space>gd", "<cmd>GinDiff<cr>", { mode: "n" });
      await mapping.map(denops, "<space>gl", "<cmd>GinLog<cr>", { mode: "n" });
      await mapping.map(denops, "<space>gL", "<cmd>GinLog -p -- %<cr>", {
        mode: "n",
      });
      await mapping.map(denops, "<space>gp", "<cmd>Gin push<cr>", {
        mode: "n",
      });

      await autocmd.group(denops, "MyGin", (helper) => {
        helper.remove("*");
        helper.define(
          "FileType",
          ["gin-diff", "gin-log", "gin-status"],
          `call <SID>${denops.name}_notify("${
            lambda.register(
              denops,
              async () => {
                await mapping.map(denops, "c", "<cmd>Gin commit -v<cr>", {
                  mode: "n",
                  buffer: true,
                });
                await mapping.map(denops, "s", "<cmd>GinStatus<cr>", {
                  mode: "n",
                  buffer: true,
                });
                await mapping.map(denops, "L", "<cmd>GinLog --graph --oneline<cr>", {
                  mode: "n",
                  buffer: true,
                });
                await mapping.map(denops, "d", "<cmd>GinDiff --cached<cr>", {
                  mode: "n",
                  buffer: true,
                });
                await mapping.map(denops, "p", "<cmd>Gin push<cr>", {
                  mode: "n",
                  buffer: true,
                });
                await mapping.map(denops, "P", "<cmd>Gin pull<cr>", {
                  mode: "n",
                  buffer: true,
                });
              },
            )
          }", [])`,
        );
        helper.define(
          "FileType",
          "gin-status",
          `call <SID>${denops.name}_notify("${
            lambda.register(
              denops,
              async () => {
                await mapping.map(denops, "h", "<Plug>(gin-action-stage)", {
                  mode: ["n", "x"],
                  buffer: true,
                });
                await mapping.map(denops, "l", "<Plug>(gin-action-unstage)", {
                  mode: ["n", "x"],
                  buffer: true,
                });
              },
            )
          }", [])`,
        );
      });
    },
  },
  {
    url: "https://github.com/skanehira/denops-gh.vim",
    enabled: false,
  },
];
