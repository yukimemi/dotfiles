import type { Denops } from "https://deno.land/x/denops_std@v4.3.3/mod.ts";
import type { Plug } from "https://deno.land/x/dvpm@0.2.4/mod.ts";

import * as mapping from "https://deno.land/x/denops_std@v4.3.3/mapping/mod.ts";
import * as autocmd from "https://deno.land/x/denops_std@v4.3.3/autocmd/mod.ts";
import * as lambda from "https://deno.land/x/denops_std@v4.3.3/lambda/mod.ts";
import { globals } from "https://deno.land/x/denops_std@v4.3.3/variable/mod.ts";
import { ensureNumber } from "https://deno.land/x/unknownutil@v2.1.1/mod.ts";
import * as op from "https://deno.land/x/denops_std@v4.3.3/option/mod.ts";
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
      await mapping.map(
        denops,
        "<cr>",
        `coc#pum#visible() ? coc#pum#confirm() : '\<c-g>u\<cr>\<c-r>=coc#on_enter()\<cr>'`,
        { mode: "i" },
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

      await mapping.map(
        denops,
        "K",
        `<cmd>call <SID>${denops.name}_notify("${
          lambda.register(
            denops,
            async () => {
              const cw = await fn.expand(denops, "<cword>");
              const ft = await op.filetype.getLocal(denops);
              if (["vim", "help"].some((t) => t === ft)) {
                await denops.cmd(`silent! h ${cw}`);
              } else if (
                ensureNumber(await denops.call(`coc#rpc#ready`)) === 1
              ) {
                await denops.call("CocActionAsync", "doHover");
              } else {
                await denops.cmd(`!${await op.keywordprg.get(denops)} ${cw}`);
              }
            },
          )
        }", [])<cr>`,
        { mode: "n", silent: true },
      );

      await autocmd.group(denops, "CocGroup", (helper) => {
        helper.remove("*");
        // Highlight the symbol and its references on a CursorHold event(cursor is idle)
        helper.define(
          "CursorHold",
          "*",
          `silent call CocActionAsync('highlight')`,
        );
        // Setup formatexpr specified filetype(s)
        helper.define(
          "FileType",
          "typescript,json",
          `setl formatexpr=CocAction('formatSelected')`,
        );
        // Update signature help on jump placeholder
        helper.define(
          "User",
          "CocJumpPlaceholder",
          `call CocActionAsync('showSignatureHelp')`,
        );
      });

      // Symbol renaming
      await mapping.map(denops, "<leader>rn", "<Plug>(coc-rename)", {
        mode: "n",
        silent: true,
      });

      // Formatting selected code
      await mapping.map(denops, "<leader>f", "<Plug>(coc-format-selected)", {
        mode: "x",
        silent: true,
      });
      await mapping.map(denops, "<leader>f", "<Plug>(coc-format-selected)", {
        mode: "n",
        silent: true,
      });

      // Apply codeAction to the selected region
      // Example: `<leader>aap` for current paragraph
      await mapping.map(
        denops,
        "<leader>a",
        "<Plug>(coc-codeaction-selected)",
        { mode: ["n", "x"], silent: true },
      );

      // Remap keys for apply code actions at the cursor position.
      await mapping.map(denops, "<leader>ac", "<Plug>(coc-codeaction-cursor)", {
        mode: "n",
        silent: true,
      });
      // Remap keys for apply code actions affect whole buffer.
      await mapping.map(denops, "<leader>as", "<Plug>(coc-codeaction-source)", {
        mode: "n",
        silent: true,
      });
      // Remap keys for applying codeActions to the current buffer
      await mapping.map(denops, "<leader>ac", "<Plug>(coc-codeaction)", {
        mode: "n",
        silent: true,
      });
      // Apply the most preferred quickfix action on the current line.
      await mapping.map(denops, "<leader>qf", "<Plug>(coc-fix-current)", {
        mode: "n",
        silent: true,
      });

      // Remap keys for apply refactor code actions.
      await mapping.map(
        denops,
        "<leader>re",
        "<Plug>(coc-codeaction-refactor)",
        { mode: "n", silent: true },
      );
      await mapping.map(
        denops,
        "<leader>r",
        "<Plug>(coc-codeaction-refactor-selected)",
        { mode: ["n", "x"], silent: true },
      );

      // Run the Code Lens actions on the current line
      await mapping.map(denops, "<leader>cl", "<Plug>(coc-codelens-action)", {
        mode: "n",
        silent: true,
      });

      // Map function and class text objects
      // NOTE: Requires 'textDocument.documentSymbol' support from the language server
      await mapping.map(denops, "if", "<Plug>(coc-funcobj-i)", {
        mode: ["x", "o"],
        silent: true,
      });

      await mapping.map(denops, "af", "<Plug>(coc-funcobj-a)", {
        mode: ["x", "o"],
        silent: true,
      });

      await mapping.map(denops, "ic", "<Plug>(coc-classobj-i)", {
        mode: ["x", "o"],
        silent: true,
      });

      await mapping.map(denops, "ac", "<Plug>(coc-classobj-a)", {
        mode: ["x", "o"],
        silent: true,
      });

      // Remap <C-f> and <C-b> to scroll float windows/popups
      await mapping.map(
        denops,
        "<C-f>",
        'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"',
        { mode: ["n", "v"], silent: true, nowait: true },
      );
      await mapping.map(
        denops,
        "<C-b>",
        'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"',
        { mode: ["n", "v"], silent: true, nowait: true },
      );
      await mapping.map(
        denops,
        "<C-f>",
        'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"',
        { mode: "i", silent: true, nowait: true },
      );
      await mapping.map(
        denops,
        "<C-b>",
        'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"',
        { mode: "i", silent: true, nowait: true },
      );

      // Use CTRL-S for selections ranges
      // Requires 'textDocument/selectionRange' support of language server
      await mapping.map(denops, "<C-s>", "<Plug>(coc-range-select)", {
        mode: ["n", "x"],
        silent: true,
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
        },
      );
      await mapping.map(
        denops,
        "<leader>cu",
        "<cmd>CocList --auto-preview mru<cr>",
        {
          mode: "n",
        },
      );
      await mapping.map(
        denops,
        "<leader>cb",
        "<cmd>CocList --auto-preview buffers<cr>",
        {
          mode: "n",
        },
      );

      // coc-explorer.
      await mapping.map(denops, "<space>e", "<cmd>CocCommand explorer<cr>", {
        mode: "n",
      });

      await denops.cmd(`CocStart`);

      await notify(denops, "coc.nvim loaded !");
    },
  },
];
