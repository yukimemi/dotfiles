// =============================================================================
// File        : fern.ts
// Author      : yukimemi
// Last Change : 2023/08/05 23:16:14.
// =============================================================================

import type { Plug } from "https://deno.land/x/dvpm@3.0.2/mod.ts";

import * as autocmd from "https://deno.land/x/denops_std@v5.0.1/autocmd/mod.ts";
import * as fn from "https://deno.land/x/denops_std@v5.0.1/function/mod.ts";
import * as lambda from "https://deno.land/x/denops_std@v5.0.1/lambda/mod.ts";
import * as mapping from "https://deno.land/x/denops_std@v5.0.1/mapping/mod.ts";
import { globals } from "https://deno.land/x/denops_std@v5.0.1/variable/variable.ts";
import { pluginStatus } from "../main.ts";

export const fern: Plug[] = [
  {
    url: "lambdalisue/fern.vim",
    enabled: !pluginStatus.vscode && pluginStatus.fern,
    dependencies: [
      {
        url: "lambdalisue/fern-hijack.vim",
        dependencies: [{ url: "lambdalisue/fern.vim" }],
      },
      {
        url: "lambdalisue/fern-git-status.vim",
        dependencies: [{ url: "lambdalisue/fern.vim" }],
      },
      {
        url: "lambdalisue/fern-git.vim",
        dependencies: [{ url: "lambdalisue/fern.vim" }],
      },
      {
        url: "lambdalisue/fern-mapping-git.vim",
        dependencies: [{ url: "lambdalisue/fern.vim" }],
      },
      {
        url: "lambdalisue/fern-bookmark.vim",
        dependencies: [{ url: "lambdalisue/fern.vim" }],
      },
      {
        url: "lambdalisue/fern-comparator-lexical.vim",
        dependencies: [{ url: "lambdalisue/fern.vim" }],
      },
      {
        url: "lambdalisue/fern-renderer-nerdfont.vim",
        dependencies: [
          { url: "lambdalisue/glyph-palette.vim" },
          { url: "lambdalisue/nerdfont.vim" },
          { url: "lambdalisue/fern.vim" },
        ],
      },
      {
        url: "hrsh7th/fern-mapping-collapse-or-leave.vim",
        dependencies: [{ url: "lambdalisue/fern.vim" }],
      },
    ],
    before: async ({ denops }) => {
      await globals.set(denops, "loaded_netrwPlugin", 1);
      await globals.set(denops, "fern#default_hidden", 1);
      await globals.set(denops, "fern#renderer", "nerdfont");
      await globals.set(denops, "fern#renderer#nerdfont#indent_makers", 1);

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
        )} -reveal=${await fn
          .expand(denops, "%:t")} -drawer -width=40<cr>`,
        { mode: "n" },
      );

      await autocmd.group(denops, "MyFernConfig", (helper) => {
        helper.remove("*");
        helper.define(
          "FileType",
          "fern",
          `call <SID>${denops.name}_notify("${
            lambda.register(denops, async () => {
              await mapping.map(
                denops,
                "o",
                `<cmd>call fern#smart#leaf("<Plug>(fern-action-open)", "<Plug>(fern-action-expand)", "<Plug>(fern-action-collapse)")`,
                { mode: "n", buffer: true },
              );
              await mapping.map(
                denops,
                "<c-l>",
                `<c-w>l`,
                { mode: "n", buffer: true },
              );
              await mapping.map(
                denops,
                "S",
                `<Plug>(fern-action-open:select)`,
                { mode: "n", buffer: true },
              );
              await mapping.map(
                denops,
                "n",
                `n`,
                { mode: "n", buffer: true },
              );
              await mapping.map(
                denops,
                "N",
                `N`,
                { mode: "n", buffer: true },
              );
              await mapping.map(
                denops,
                "a",
                `<Plug>(fern-action-new-file)`,
                { mode: "n", buffer: true },
              );
              await mapping.map(
                denops,
                "<tab>",
                `<Plug>(fern-action-choice)`,
                { mode: "n", buffer: true },
              );
              await mapping.map(
                denops,
                "s",
                `<Nop>`,
                { mode: "n", buffer: true },
              );
            })
          }", [])`,
        );
      });
    },
  },
];
