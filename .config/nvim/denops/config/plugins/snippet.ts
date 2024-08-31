// =============================================================================
// File        : snippet.ts
// Author      : yukimemi
// Last Change : 2024/08/31 14:25:44.
// =============================================================================

import * as fn from "jsr:@denops/std@7.1.1/function";
import * as mapping from "jsr:@denops/std@7.1.1/mapping";
import * as vars from "jsr:@denops/std@7.1.1/variable";
import type { Plug } from "jsr:@yukimemi/dvpm@4.0.2";
import { pluginStatus } from "../pluginstatus.ts";
import { z } from "npm:zod@3.23.8";

export const snippet: Plug[] = [
  {
    url: "https://github.com/hrsh7th/vim-vsnip",
    enabled: pluginStatus.vsnip,
    dependencies: [
      { url: "https://github.com/hrsh7th/vim-vsnip-integ" },
      {
        url: "https://github.com/uga-rosa/ddc-source-vsnip",
        enabled: pluginStatus.vsnip && pluginStatus.ddc,
      },
      { url: "https://github.com/rafamadriz/friendly-snippets" },
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
    enabled: pluginStatus.denippet,
    dependencies: [
      {
        url: "https://github.com/microsoft/vscode",
        dst: "~/.cache/vscode",
        depth: 1,
        enabled: false,
      },
      {
        url: "https://github.com/PowerShell/vscode-powershell",
        dst: "~/.cache/vscode-powershell",
        enabled: false,
      },
      { url: "https://github.com/rafamadriz/friendly-snippets" },
    ],
    after: async ({ denops }) => {
      await mapping.map(denops, "<c-j>", "<Plug>(denippet-expand-or-jump)", {
        mode: "i",
        noremap: true,
      });
      await mapping.map(denops, "<c-j>", "<Plug>(denippet-jump-next)", {
        mode: ["i", "s"],
        noremap: true,
      });
      await mapping.map(denops, "<c-k>", "<Plug>(denippet-jump-prev)", {
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
      const powershell = z.string().parse(
        await fn.expand(
          denops,
          "~/.cache/vscode-powershell/snippets/PowerShell.json",
        ),
      );
      await denops.call(`denippet#load`, powershell, "ps1");

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
