// =============================================================================
// File        : ddc.ts
// Author      : yukimemi
// Last Change : 2023/09/07 23:09:29.
// =============================================================================

import * as autocmd from "https://deno.land/x/denops_std@v5.0.1/autocmd/mod.ts";
import * as lambda from "https://deno.land/x/denops_std@v5.0.1/lambda/mod.ts";
import * as fn from "https://deno.land/x/denops_std@v5.0.1/function/mod.ts";
import * as mapping from "https://deno.land/x/denops_std@v5.0.1/mapping/mod.ts";
import * as vars from "https://deno.land/x/denops_std@v5.0.1/variable/mod.ts";
import type { Plug } from "https://deno.land/x/dvpm@3.5.0/mod.ts";
import { Denops } from "https://deno.land/x/denops_core@v5.0.0/mod.ts";
import { execute } from "https://deno.land/x/denops_std@v5.0.1/helper/execute.ts";
import { globals } from "https://deno.land/x/denops_std@v5.0.1/variable/mod.ts";
import { pluginStatus } from "../main.ts";

export const ddc: Plug[] = [
  {
    url: "Shougo/ddc.vim",
    enabled: pluginStatus.ddc && !pluginStatus.vscode,
    dependencies: [
      // matcher, sorter, converter
      { url: "tani/ddc-fuzzy" },
      { url: "Shougo/ddc-filter-matcher_head" },
      { url: "Shougo/ddc-filter-matcher_length" },
      { url: "Shougo/ddc-filter-matcher_vimregexp" },
      { url: "Shougo/ddc-filter-sorter_rank" },
      { url: "Shougo/ddc-filter-converter_remove_overlap" },
      { url: "Shougo/ddc-filter-converter_truncate_abbr" },

      // ui
      {
        url: "Shougo/pum.vim",
        after: async ({ denops }) => {
          await denops.call("pum#set_option", {
            use_complete: false,
            // item_orders: ["kind", "space", "abbr", "space", "menu"],
            scrollbar_char: "┃",
            offset_cmdrow: 0,
            offset_cmdcol: 0,
            padding: false,
            reversed: false,
            border: "none",
            preview: true,
            preview_border: "none",
            preview_width: 80,
          });
        },
      },
      { url: "Shougo/ddc-ui-pum" },
      { url: "Shougo/ddc-ui-inline" },

      // snippet
      {
        url: "hrsh7th/vim-vsnip",
        dependencies: [
          { url: "hrsh7th/vim-vsnip-integ", enabled: false },
          { url: "uga-rosa/ddc-source-vsnip" },
          { url: "rafamadriz/friendly-snippets" },
        ],
        before: async ({ denops }) => {
          await vars.g.set(
            denops,
            "vsnip_snippet_dir",
            await fn.expand(denops, "~/.config/nvim/vsnip"),
          );
        },
        after: async ({ denops }) => {
          await execute(
            denops,
            `
              " Expand or jump
              imap <expr> <C-j>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-j>'
              smap <expr> <C-j>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-j>'

              " Jump forward or backward
              imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
              smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
              imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
              smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
            `,
          );
        },
      },

      // sources
      { url: "LumaKernel/ddc-file" },
      { url: "LumaKernel/ddc-run" },
      { url: "Shougo/ddc-source-around" },
      { url: "Shougo/ddc-source-cmdline" },
      { url: "Shougo/ddc-source-cmdline-history" },
      { url: "Shougo/ddc-source-input" },
      { url: "Shougo/ddc-source-line" },
      { url: "Shougo/ddc-source-nvim-lsp" },
      { url: "Shougo/ddc-source-omni" },
      { url: "Shougo/ddc-source-rg" },
      { url: "delphinus/ddc-treesitter" },
      { url: "matsui54/ddc-buffer" },
      { url: "uga-rosa/ddc-source-nvim-lua" },

      {
        url: "uga-rosa/ddc-nvim-lsp-setup",
        dependencies: [
          { url: "neovim/nvim-lspconfig" },
        ],
        after: async ({ denops }) => {
          await denops.call(`luaeval`, `require("ddc_nvim_lsp_setup").setup()`);
        },
      },
      // popup, signature
      {
        url: "uga-rosa/ddc-previewer-floating",
        enabled: false,
        dependencies: [
          { url: "Shougo/pum.vim" },
        ],
        after: async ({ denops }) => {
          await denops.call(`luaeval`, `require("ddc_previewer_floating").setup(_A)`, {
            border: "none",
          });
        },
      },
      {
        url: "matsui54/denops-popup-preview.vim",
        enabled: false,
        before: async ({ denops }) => {
          await globals.set(denops, "popup_preview_config", {
            delay: 50,
            border: true,
            supportVsnip: true,
          });
        },
        after: async ({ denops }) => {
          await denops.call(`popup_preview#enable`);
        },
      },
      {
        url: "matsui54/denops-signature_help",
        enabled: false,
        after: async ({ denops }) => {
          await denops.call(`signature_help#enable`);
        },
      },
    ],
    after: async ({ denops }) => {
      // commandline settings.
      const cmdLinePre = async (denops: Denops, mode: string) => {
        const prevBufConfig = await denops.call("ddc#custom#get_buffer");
        if (prevBufConfig) {
          await vars.b.set(denops, "ddc_prev_buffer_config", prevBufConfig);
        }
        if (mode === ":") {
          await denops.call("ddc#custom#patch_buffer", "sourceOptions", {
            _: {
              keywordPattern: "[0-9a-zA-Z_:#-]*",
              minAutoCompleteLength: 0,
            },
          });
        }

        await autocmd.group(denops, "MyDDCCmdlineLeave", (helper) => {
          helper.remove("*");
          helper.define(
            "User",
            "DDCCmdlineLeave",
            `call <SID>${denops.name}_notify("${
              lambda.register(denops, async () => {
                // Restore config.
                if (await fn.exists(denops, "b:ddc_prev_buffer_config")) {
                  await denops.call(
                    "ddc#custom#set_buffer",
                    await vars.b.get(denops, "ddc_prev_buffer_config"),
                  );
                  await vars.b.remove(denops, "ddc_prev_buffer_config");
                }
              })
            }", [])`,
            { once: true },
          );
        });

        await denops.call("ddc#enable_cmdline_completion");
      };

      await mapping.map(
        denops,
        ":",
        `<cmd>call <SID>${denops.name}_notify("${
          lambda.register(denops, async () => await cmdLinePre(denops, ":"))
        }", [])<cr>:`,
        { mode: ["n", "x"], noremap: true },
      );
      await mapping.map(
        denops,
        "/",
        `<cmd>call <SID>${denops.name}_notify("${
          lambda.register(denops, async () => await cmdLinePre(denops, "/"))
        }", [])<cr>/`,
        { mode: "n", noremap: true },
      );
      await mapping.map(
        denops,
        "?",
        `<cmd>call <SID>${denops.name}_notify("${
          lambda.register(denops, async () => await cmdLinePre(denops, "?"))
        }", [])<cr>?`,
        { mode: "n", noremap: true },
      );

      // global settings.
      await denops.call("ddc#custom#patch_global", {
        ui: "pum",
        autoCompleteEvents: [
          "InsertEnter",
          "TextChangedI",
          "TextChangedP",
          "CmdlineEnter",
          "CmdlineChanged",
          "TextChangedT",
        ],
        backspaceCompletion: true,
        sources: ["nvim-lsp", "around", "vsnip", "file", "rg"],
        cmdlineSources: {
          ":": ["cmdline", "cmdline-history", "around"],
          "@": ["input", "cmdline-history", "file", "around"],
          ">": ["input", "cmdline-history", "file", "around"],
          "/": ["around"],
          "?": ["around"],
          "-": ["around"],
          "=": ["input"],
        },
        sourceOptions: {
          _: {
            minAutoCompleteLength: 1,
            ignoreCase: true,
            matchers: ["matcher_fuzzy"],
            sorters: ["sorter_fuzzy"],
            converters: ["converter_fuzzy"],
            timeout: 1000,
          },
          around: { mark: "󱂚" },
          buffer: { mark: "" },
          line: { mark: "" },
          vsnip: { mark: "" },
          file: {
            mark: "",
            isVolatile: true,
            "forceCompletionPattern": "\\S/\\S*",
          },
          rg: {
            mark: "",
            minAutoCompleteLength: 5,
          },
          "nvim-lsp": {
            mark: "󱐋",
            forceCompletionPattern: "\\.\\w*|::\\w*|->\\w*",
            dup: "force",
            converters: ["converter_fuzzy", "converter_lsp-kind"],
          },
          "nvim-lua": {
            mark: "󰢱",
            forceCompletionPattern: "\\.\\w*",
          },
          cmdline: {
            mark: "",
            forceCompletionPattern: "\\S/\\S*|\\.\\w*",
            converters: ["converter_fuzzy", "converter_cmdline"],
          },
          "cmdline-history": {
            mark: "",
            sorters: [],
          },
        },
        sourceParams: {
          buffer: {
            requireSameFiletype: false,
            limitBytes: 50000,
            fromAltBuf: true,
            forceCollect: true,
          },
          file: {
            filenameChars: "[:keyword:].",
          },
          "nvim-lsp": {
            enableResolveItem: true,
            enableAdditionalTextEdit: true,
          },
        },
      });

      await denops.call("ddc#custom#patch_filetype", "vim", {
        specialBufferCompletion: true,
      });

      // mappings.
      // for insert.
      await mapping.map(
        denops,
        "<c-n>",
        `<cmd>call pum#map#insert_relative(+1, "empty")<cr>`,
        { mode: "i" },
      );
      await mapping.map(
        denops,
        "<c-p>",
        `<cmd>call pum#map#insert_relative(-1, "empty")<cr>`,
        { mode: "i" },
      );
      await mapping.map(
        denops,
        "<c-space>",
        `<cmd>call ddc#map#manual_complete()<cr>`,
        { mode: "i" },
      );
      await mapping.map(denops, "<c-c>", `<cmd>call pum#close()<cr>`, {
        mode: "i",
      });
      // for commandline.
      await mapping.map(
        denops,
        "<tab>",
        `wildmenumode() ? &wildcharm->nr2char() : pum#visible() ? '<cmd>call pum#map#insert_relative(+1)<cr>' : ddc#map#manual_complete()`,
        {
          mode: "c",
          noremap: true,
          expr: true,
        },
      );
      await mapping.map(
        denops,
        "<s-tab>",
        `<cmd>call pum#map#insert_relative(-1)<cr>`,
        { mode: "c", noremap: true },
      );
      await mapping.map(
        denops,
        "<c-e>",
        `ddc#visible() ? '<Cmd>call ddc#hide()<CR>' : '<End>'`,
        {
          mode: "c",
          noremap: true,
          expr: true,
        },
      );

      if (denops.meta.host === "nvim") {
        await denops.call(`ddc#enable`, { context_filetype: "treesiters" });
        // await denops.cmd(`lua require("ddc_previewer_floating").enable()`);
      } else {
        await denops.call(`ddc#enable`, { context_filetype: "context_filetype" });
      }
    },
  },
];
