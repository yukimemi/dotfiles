// =============================================================================
// File        : fern.ts
// Author      : yukimemi
// Last Change : 2024/10/02 00:31:04.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@5.0.7";

import * as autocmd from "jsr:@denops/std@7.2.0/autocmd";
import * as fn from "jsr:@denops/std@7.2.0/function";
import * as lambda from "jsr:@denops/std@7.2.0/lambda";
import * as mapping from "jsr:@denops/std@7.2.0/mapping";
import * as vars from "jsr:@denops/std@7.2.0/variable";

export const fern: Plug[] = [
  {
    url: "https://github.com/lambdalisue/vim-fern-hijack",
    dependencies: ["https://github.com/lambdalisue/vim-fern"],
  },
  {
    url: "https://github.com/lambdalisue/vim-fern-git-status",
    dependencies: ["https://github.com/lambdalisue/vim-fern"],
  },
  {
    url: "https://github.com/lambdalisue/vim-fern-mapping-git",
    dependencies: ["https://github.com/lambdalisue/vim-fern"],
  },
  {
    url: "https://github.com/lambdalisue/vim-fern-bookmark",
    dependencies: ["https://github.com/lambdalisue/vim-fern"],
  },
  {
    url: "https://github.com/lambdalisue/vim-fern-comparator-lexical",
    dependencies: ["https://github.com/lambdalisue/vim-fern"],
  },
  { url: "https://github.com/lambdalisue/vim-glyph-palette" },
  { url: "https://github.com/lambdalisue/vim-nerdfont" },
  { url: "https://github.com/lambdalisue/vim-fern" },
  {
    url: "https://github.com/lambdalisue/vim-fern-renderer-nerdfont",
    dependencies: [
      "https://github.com/lambdalisue/vim-glyph-palette",
      "https://github.com/lambdalisue/vim-nerdfont",
      "https://github.com/lambdalisue/vim-fern",
    ],
  },
  {
    url: "https://github.com/hrsh7th/fern-mapping-collapse-or-leave.vim",
    dependencies: ["https://github.com/lambdalisue/vim-fern"],
  },
  {
    url: "https://github.com/lambdalisue/vim-fern",
    dependencies: [
      "https://github.com/lambdalisue/vim-fern-hijack",
      "https://github.com/lambdalisue/vim-fern-git-status",
      "https://github.com/lambdalisue/vim-fern-mapping-git",
      "https://github.com/lambdalisue/vim-fern-bookmark",
      "https://github.com/lambdalisue/vim-fern-comparator-lexical",
      "https://github.com/lambdalisue/vim-fern-renderer-nerdfont",
      "https://github.com/hrsh7th/fern-mapping-collapse-or-leave.vim",
    ],
    before: async ({ denops }) => {
      await vars.g.set(denops, "loaded_netrwPlugin", 1);
      await vars.g.set(denops, "fern#default_hidden", 1);
      await vars.g.set(denops, "fern#renderer", "nerdfont");
      await vars.g.set(denops, "fern#renderer#nerdfont#indent_makers", 1);

      await mapping.map(
        denops,
        "<leader>e",
        `<cmd>Fern . -reveal=% -drawer -width=40<cr>`,
        { mode: "n" },
      );
      await mapping.map(
        denops,
        "<leader>E",
        `<cmd>Fern file:///${await fn.expand(
          denops,
          "%:p:h",
        )} -reveal=${await fn.expand(denops, "%:t")} -drawer -width=40<cr>`,
        { mode: "n" },
      );

      await autocmd.group(denops, "MyFernConfig", (helper) => {
        helper.remove("*");
        helper.define(
          "FileType",
          "fern",
          `call <SID>${denops.name}_notify("${
            lambda.register(
              denops,
              async () => {
                await mapping.map(
                  denops,
                  "o",
                  `<cmd>call fern#smart#leaf("<Plug>(fern-action-open)", "<Plug>(fern-action-expand)", "<Plug>(fern-action-collapse)")`,
                  { mode: "n", buffer: true },
                );
                await mapping.map(denops, "<c-l>", `<c-w>l`, {
                  mode: "n",
                  buffer: true,
                });
                await mapping.map(
                  denops,
                  "S",
                  `<Plug>(fern-action-open:select)`,
                  { mode: "n", buffer: true },
                );
                await mapping.map(denops, "n", `n`, { mode: "n", buffer: true });
                await mapping.map(denops, "N", `N`, { mode: "n", buffer: true });
                await mapping.map(denops, "a", `<Plug>(fern-action-new-file)`, {
                  mode: "n",
                  buffer: true,
                });
                await mapping.map(denops, "<tab>", `<Plug>(fern-action-choice)`, {
                  mode: "n",
                  buffer: true,
                });
                await mapping.map(denops, "s", `<Nop>`, {
                  mode: "n",
                  buffer: true,
                });
              },
            )
          }", [])`,
        );
      });
    },
  },
];
