// =============================================================================
// File        : coc.ts
// Author      : yukimemi
// Last Change : 2023/08/27 10:25:07.
// =============================================================================

import type { Plug } from "https://deno.land/x/dvpm@3.0.8/mod.ts";

import * as autocmd from "https://deno.land/x/denops_std@v5.0.1/autocmd/mod.ts";
import * as fn from "https://deno.land/x/denops_std@v5.0.1/function/mod.ts";
import * as lambda from "https://deno.land/x/denops_std@v5.0.1/lambda/mod.ts";
import * as mapping from "https://deno.land/x/denops_std@v5.0.1/mapping/mod.ts";
import * as op from "https://deno.land/x/denops_std@v5.0.1/option/mod.ts";
import { ensure, is } from "https://deno.land/x/unknownutil@v3.5.1/mod.ts";
import { execute } from "https://deno.land/x/denops_std@v5.0.1/helper/mod.ts";
import { globals } from "https://deno.land/x/denops_std@v5.0.1/variable/mod.ts";
import { pluginStatus } from "../main.ts";

export const coc: Plug[] = [
  {
    url: "neoclide/coc.nvim",
    enabled: pluginStatus.coc && !pluginStatus.vscode,
    dependencies: [
      { url: "weirongxu/coc-explorer" },
      {
        url: "gelguy/wilder.nvim",
        after: async ({ denops }) => {
          await execute(
            denops,
            `
              lua << EOB
                local wilder = require('wilder')
                wilder.setup({modes = {':', '/', '?'}})
                -- Disable Python remote plugin
                wilder.set_option('use_python_remote_plugin', 0)

                wilder.set_option('pipeline', {
                  wilder.branch(
                    wilder.cmdline_pipeline({
                      fuzzy = 1,
                    }),
                    wilder.vim_search_pipeline()
                  )
                })

                wilder.set_option('renderer', wilder.renderer_mux({
                  [':'] = wilder.popupmenu_renderer({
                    highlighter = wilder.basic_highlighter(),
                    left = {
                      ' ',
                      wilder.popupmenu_devicons()
                    },
                    right = {
                      ' ',
                      wilder.popupmenu_scrollbar()
                    },
                  }),
                  ['/'] = wilder.popupmenu_renderer({
                    highlighter = wilder.basic_highlighter(),
                  }),
                }))
              EOB
            `,
          );
        },
      },
    ],
    branch: "release",
    // branch: "master",
    // build: async ({ info }) => {
    //   const args = ["install", "--frozen-lockfile"];
    //   console.log(info?.dst);
    //   const cmd = new Deno.Command("yarn", { args, cwd: info?.dst });
    //   const output = await cmd.output();
    //   console.log(new TextDecoder().decode(output.stdout));
    // },
    before: async ({ denops }) => {
      await globals.set(denops, "coc_global_extensions", [
        "@yaegassy/coc-tailwindcss3",
        "coc-deno",
        "coc-diagnostic",
        "coc-explorer",
        "coc-highlight",
        "coc-json",
        "coc-lists",
        "coc-lua",
        "coc-marketplace",
        "coc-nav",
        "coc-powershell",
        "coc-prettier",
        "coc-rust-analyzer",
        "coc-stylua",
        "coc-tsdetect",
        "coc-tsserver",
        "coc-snippets",
        "coc-vimlsp",
        "coc-xml",
      ]);
    },
    after: async ({ denops }) => {
      await mapping.map(
        denops,
        "<cr>",
        `coc#pum#visible() ? coc#pum#confirm() : '<c-g>u<cr><c-r>=coc#on_enter()<cr>'`,
        { mode: "i", noremap: true, expr: true, silent: true },
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
                ensure(await denops.call(`coc#rpc#ready`), is.Number) === 1
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
      await mapping.map(denops, "<leader>ca", "<Plug>(coc-codeaction-cursor)", {
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
        { mode: "x", silent: true },
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
        { mode: ["n", "v"], silent: true, nowait: true, expr: true },
      );
      await mapping.map(
        denops,
        "<C-b>",
        'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"',
        { mode: ["n", "v"], silent: true, nowait: true, expr: true },
      );
      await mapping.map(
        denops,
        "<C-f>",
        'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"',
        { mode: "i", silent: true, nowait: true, expr: true },
      );
      await mapping.map(
        denops,
        "<C-b>",
        'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"',
        { mode: "i", silent: true, nowait: true, expr: true },
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
    },
  },
];
