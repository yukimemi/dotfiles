import type { Denops } from "https://deno.land/x/denops_std@v4.3.3/mod.ts";
import type { Plug } from "https://deno.land/x/dvpm@0.2.3/mod.ts";

import * as mapping from "https://deno.land/x/denops_std@v4.3.3/mapping/mod.ts";
import * as lambda from "https://deno.land/x/denops_std@v4.3.3/lambda/mod.ts";
import {
  globals,
  options,
} from "https://deno.land/x/denops_std@v4.3.3/variable/mod.ts";
import * as fn from "https://deno.land/x/denops_std@v4.3.3/function/mod.ts";
import { notify } from "../util.ts";

export const coc: Plug[] = [
  {
    url: "neoclide/coc.nvim",
    enabled: async (denops: Denops) => await fn.has(denops, "nvim"),
    branch: "release",
    before: async (denops: Denops) => {
      await globals.set(denops, "coc_global_extensions", [
        "coc-deno",
        "coc-diagnostic",
        "coc-explorer",
        "coc-highlight",
        "coc-json",
        "coc-prettier",
        "coc-lists",
        "coc-lua",
        "coc-marketplace",
        "coc-nav",
        "coc-powershell",
        "coc-rust-analyzer",
        "coc-stylua",
        "coc-tsdetect",
        "coc-tsserver",
        "coc-vimlsp",
        "coc-xml",
      ]);
    },
    after: async (denops: Denops) => {
      await options.set(denops, "signcolumn", "yes");

      await mapping.map(
        denops,
        "<cr>",
        `coc#pum#visible() ? coc#pum#confirm() : '\<c-g>u\<cr>\<c-r>=coc#on_enter()\<cr>'`,
        { mode: "i" }
      );

      // Use <c-j> to trigger snippets
      await mapping.map(denops, "<c-j>", "<Plug>(coc-snippets-expand-jump)", {
        mode: "i",
      });
      // Use <c-space> to trigger completion
      await mapping.map(denops, "<c-space>", "coc#refresh()", {
        silent: true,
        expr: true,
        mode: "i",
      });
      await mapping.map(denops, "[d", "<Plug>(coc-diagnostic-prev)", {
        silent: true,
        mode: "n",
      });
      await mapping.map(denops, "]d", "<Plug>(coc-diagnostic-next)", {
        silent: true,
        mode: "n",
      });

      // GoTo code navigation
      await mapping.map(denops, "gd", "<Plug>(coc-definition)", {
        silent: true,
        mode: "n",
      });
      await mapping.map(denops, "gy", "<Plug>(coc-type-definition)", {
        silent: true,
        mode: "n",
      });
      await mapping.map(denops, "gi", "<Plug>(coc-implementation)", {
        silent: true,
        mode: "n",
      });
      await mapping.map(denops, "gr", "<Plug>(coc-references)", {
        silent: true,
        mode: "n",
      });

      // coc-lists.
      await mapping.map(denops, "<leader>cc", "<cmd>CocList<cr>", {
        mode: "n",
      });
      await mapping.map(
        denops,
        "<leader>co",
        "<cmd>CocList --auto-preview mru -A<cr>",
        {
          mode: "n",
        }
      );
      await mapping.map(
        denops,
        "<leader>cu",
        "<cmd>CocList --auto-preview mru<cr>",
        {
          mode: "n",
        }
      );
      await mapping.map(
        denops,
        "<leader>cb",
        "<cmd>CocList --auto-preview buffers<cr>",
        {
          mode: "n",
        }
      );

      // coc-explorer.
      await mapping.map(denops, "<space>e", "<cmd>CocCommand explorer<cr>", {
        mode: "n",
      });

      await notify(denops, "coc.nvim loaded !");
    },
  },
];
