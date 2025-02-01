// =============================================================================
// File        : snippet.ts
// Author      : yukimemi
// Last Change : 2025/02/01 09:37:20.
// =============================================================================

import * as fn from "jsr:@denops/std@7.4.0/function";
import * as mapping from "jsr:@denops/std@7.4.0/mapping";
import * as vars from "jsr:@denops/std@7.4.0/variable";
import type { Plug } from "jsr:@yukimemi/dvpm@6.2.0";
import { pluginStatus } from "../pluginstatus.ts";
import { z } from "npm:zod@3.24.1";

export const snippet: Plug[] = [
  {
    url: "https://github.com/rafamadriz/friendly-snippets",
    profiles: ["default"],
  },
  {
    url: "https://github.com/microsoft/vscode",
    dst: "~/.cache/vscode",
    depth: 1,
    enabled: false,
  },
  {
    url: "https://github.com/PowerShell/vscode-powershell",
    dst: "~/.cache/vscode-powershell",
    depth: 1,
    enabled: false,
  },
  {
    url: "https://github.com/uga-rosa/ddc-source-vsnip",
    enabled: pluginStatus.vsnip && pluginStatus.ddc,
  },
  {
    url: "https://github.com/hrsh7th/vim-vsnip-integ",
    profiles: ["default"],
    enabled: pluginStatus.vsnip,
  },
  {
    url: "https://github.com/hrsh7th/vim-vsnip",
    profiles: ["default"],
    enabled: pluginStatus.vsnip,
    dependencies: [
      "https://github.com/hrsh7th/vim-vsnip-integ",
      "https://github.com/uga-rosa/ddc-source-vsnip",
    ],
    before: async ({ denops }) => {
      await vars.g.set(
        denops,
        "vsnip_snippet_dir",
        await fn.expand(denops, "~/.config/nvim/snippets"),
      );
    },
    afterFile: "~/.config/nvim/rc/after/vim-vsnip.vim",
  },
  {
    url: "https://github.com/uga-rosa/denippet.vim",
    profiles: ["default"],
    enabled: pluginStatus.denippet,
    after: async ({ denops }) => {
      await mapping.map(denops, "<tab>", "<Plug>(denippet-expand-or-jump)", {
        mode: "i",
        noremap: true,
      });
      await mapping.map(denops, "<tab>", "<Plug>(denippet-jump-next)", {
        mode: ["i", "s"],
        noremap: true,
      });
      await mapping.map(denops, "<s-tab>", "<Plug>(denippet-jump-prev)", {
        mode: ["i", "s"],
        noremap: true,
      });
      const html = z.string().parse(
        await fn.expand(denops, "~/.cache/vscode/extensions/html/snippets/html.code-snippets"),
      );
      await denops.call(`denippet#load`, html, "html");
      const cs = z.string().parse(
        await fn.expand(
          denops,
          "~/.cache/vscode/extensions/csharp/snippets/csharp.code-snippets",
        ),
      );
      await denops.call(`denippet#load`, cs, "cs");
      // const powershell = z.string().parse(
      //   await fn.expand(
      //     denops,
      //     "~/.cache/vscode-powershell/snippets/PowerShell.json",
      //   ),
      // );
      // await denops.call(`denippet#load`, powershell, "ps1");

      const userSnippetsDir = z.string().parse(
        await fn.expand(denops, "~/.config/nvim/snippets"),
      );
      for await (
        const dirEntry of Deno.readDir(userSnippetsDir)
      ) {
        if (!dirEntry.name.endsWith(".toml")) {
          continue;
        }
        await denops.call(
          `denippet#load`,
          await fn.expand(denops, `${userSnippetsDir}/${dirEntry.name}`),
        );
      }
    },
  },
];
