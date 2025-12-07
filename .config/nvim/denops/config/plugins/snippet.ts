// =============================================================================
// File        : snippet.ts
// Author      : yukimemi
// Last Change : 2025/12/07 21:47:50.
// =============================================================================

import * as fn from "@denops/std/function";
import * as mapping from "@denops/std/mapping";
import * as vars from "@denops/std/variable";
import type { Plug } from "@yukimemi/dvpm";
import { z } from "zod";
import { pluginStatus } from "../pluginstatus.ts";

export const snippet: Plug[] = [
  {
    url: "https://github.com/rafamadriz/friendly-snippets",
    profiles: ["snippet"],
  },
  {
    url: "https://github.com/microsoft/vscode",
    enabled: false,
    profiles: ["snippet"],
    clone: true,
    dst: "~/.cache/vscode",
    depth: 1,
  },
  {
    url: "https://github.com/PowerShell/vscode-powershell",
    enabled: false,
    profiles: ["snippet"],
    clone: true,
    dst: "~/.cache/vscode-powershell",
    depth: 1,
  },
  {
    url: "https://github.com/uga-rosa/ddc-source-vsnip",
    enabled: pluginStatus.vsnip && pluginStatus.ddc,
    profiles: ["snippet", "completion"],
  },
  {
    url: "https://github.com/hrsh7th/vim-vsnip-integ",
    enabled: pluginStatus.vsnip,
    profiles: ["snippet"],
  },
  {
    url: "https://github.com/hrsh7th/vim-vsnip",
    enabled: pluginStatus.vsnip,
    profiles: ["snippet"],
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
    enabled: pluginStatus.denippet,
    profiles: ["snippet"],
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
        await fn.expand(
          denops,
          "~/.cache/vscode/extensions/html/snippets/html.code-snippets",
        ),
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
  {
    url: "https://github.com/chrisgrieser/nvim-scissors",
    profiles: ["snippet"],
    afterFile: "~/.config/nvim/rc/after/nvim-scissors.lua",
  },
];
