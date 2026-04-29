// =============================================================================
// File        : fern.ts
// Author      : yukimemi
// Last Change : 2026/02/23 11:13:39.
// =============================================================================

import type { Plug } from "@yukimemi/dvpm";

import * as autocmd from "@denops/std/autocmd";
import * as fn from "@denops/std/function";
import * as lambda from "@denops/std/lambda";
import * as mapping from "@denops/std/mapping";
import * as vars from "@denops/std/variable";
import { selections } from "../pluginstatus.ts";

export const fern: Plug[] = [
  {
    url: "https://github.com/lambdalisue/vim-fern-hijack",
    enabled: selections.filer === "fern",
    profiles: ["filer"],
    dependencies: ["https://github.com/lambdalisue/vim-fern"],
  },
  {
    url: "https://github.com/lambdalisue/vim-fern-git-status",
    enabled: selections.filer === "fern",
    profiles: ["filer"],
    dependencies: ["https://github.com/lambdalisue/vim-fern"],
  },
  {
    url: "https://github.com/lambdalisue/vim-fern-mapping-git",
    enabled: selections.filer === "fern",
    profiles: ["filer"],
    dependencies: ["https://github.com/lambdalisue/vim-fern"],
  },
  {
    url: "https://github.com/lambdalisue/vim-fern-bookmark",
    enabled: selections.filer === "fern",
    profiles: ["filer"],
    dependencies: ["https://github.com/lambdalisue/vim-fern"],
  },
  {
    url: "https://github.com/lambdalisue/vim-fern-comparator-lexical",
    enabled: selections.filer === "fern",
    profiles: ["filer"],
    dependencies: ["https://github.com/lambdalisue/vim-fern"],
  },
  {
    url: "https://github.com/lambdalisue/vim-glyph-palette",
    enabled: selections.filer === "fern",
    profiles: ["filer"],
  },
  {
    url: "https://github.com/lambdalisue/vim-nerdfont",
    enabled: selections.filer === "fern",
    profiles: ["filer"],
  },
  {
    url: "https://github.com/lambdalisue/vim-fern-renderer-nerdfont",
    enabled: selections.filer === "fern",
    profiles: ["filer"],
    dependencies: [
      "https://github.com/lambdalisue/vim-glyph-palette",
      "https://github.com/lambdalisue/vim-nerdfont",
      "https://github.com/lambdalisue/vim-fern",
    ],
  },
  {
    url: "https://github.com/hrsh7th/fern-mapping-collapse-or-leave.vim",
    enabled: selections.filer === "fern",
    profiles: ["filer"],
    dependencies: ["https://github.com/lambdalisue/vim-fern"],
  },
  {
    url: "https://github.com/lambdalisue/vim-fern",
    enabled: selections.filer === "fern",
    profiles: ["filer"],
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
                await mapping.map(denops, "n", `n`, {
                  mode: "n",
                  buffer: true,
                });
                await mapping.map(denops, "N", `N`, {
                  mode: "n",
                  buffer: true,
                });
                await mapping.map(denops, "a", `<Plug>(fern-action-new-file)`, {
                  mode: "n",
                  buffer: true,
                });
                await mapping.map(
                  denops,
                  "<tab>",
                  `<Plug>(fern-action-choice)`,
                  {
                    mode: "n",
                    buffer: true,
                  },
                );
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
