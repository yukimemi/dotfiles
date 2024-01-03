// =============================================================================
// File        : ddc.ts
// Author      : yukimemi
// Last Change : 2024/01/03 20:31:29.
// =============================================================================

import * as autocmd from "https://deno.land/x/denops_std@v5.2.0/autocmd/mod.ts";
import * as fn from "https://deno.land/x/denops_std@v5.2.0/function/mod.ts";
import * as lambda from "https://deno.land/x/denops_std@v5.2.0/lambda/mod.ts";
import * as mapping from "https://deno.land/x/denops_std@v5.2.0/mapping/mod.ts";
import * as vars from "https://deno.land/x/denops_std@v5.2.0/variable/mod.ts";
import type { Plug } from "https://deno.land/x/dvpm@3.7.0/mod.ts";
import { Denops } from "https://deno.land/x/denops_core@v5.0.0/mod.ts";
import { ensure, is } from "https://deno.land/x/unknownutil@v3.11.0/mod.ts";
import { exists } from "https://deno.land/std@0.210.0/fs/exists.ts";
import { pluginStatus } from "../pluginstatus.ts";

export const ddc: Plug[] = [
  {
    url: "https://github.com/Shougo/ddc.vim",
    enabled: pluginStatus.ddc && !pluginStatus.vscode,
    dependencies: [
      // matcher, sorter, converter
      { url: "https://github.com/tani/ddc-fuzzy" },
      { url: "https://github.com/Shougo/ddc-filter-matcher_head" },
      { url: "https://github.com/Shougo/ddc-filter-matcher_length" },
      { url: "https://github.com/Shougo/ddc-filter-matcher_vimregexp" },
      { url: "https://github.com/Shougo/ddc-filter-sorter_rank" },
      { url: "https://github.com/Shougo/ddc-filter-converter_remove_overlap" },
      { url: "https://github.com/Shougo/ddc-filter-converter_truncate_abbr" },

      // ui
      {
        url: "https://github.com/Shougo/pum.vim",
        after: async ({ denops }) => {
          await denops.call("pum#set_option", {
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
      { url: "https://github.com/Shougo/ddc-ui-pum" },
      { url: "https://github.com/Shougo/ddc-ui-inline" },

      // snippet
      {
        url: "https://github.com/hrsh7th/vim-vsnip",
        enabled: false,
        dependencies: [
          { url: "https://github.com/hrsh7th/vim-vsnip-integ", enabled: false },
          { url: "https://github.com/uga-rosa/ddc-source-vsnip", enabled: false },
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
        dependencies: [
          {
            url: "https://github.com/microsoft/vscode",
            dst: "~/.cache/vscode",
            enabled: false,
          },
          {
            url: "https://github.com/PowerShell/vscode-powershell",
            dst: "~/.cache/vscode-powershell",
            enabled: false,
          },
        ],
        after: async ({ denops }) => {
          await mapping.map(denops, "<c-j>", "<Plug>(denippet-expand-or-jump)", {
            mode: "i",
            noremap: true,
          });
          await mapping.map(denops, "<c-j>", "<Plug>(denippet-jump-next)", {
            mode: "s",
            noremap: true,
          });
          await mapping.map(denops, "<c-k>", "<Plug>(denippet-jump-prev)", {
            mode: "s",
            noremap: true,
          });
          const html = ensure(
            await fn.expand(denops, "~/.cache/vscode/extensions/html/snippets/html.code-snippets"),
            is.String,
          );
          await denops.call(`denippet#load`, html, "html");
          const cs = ensure(
            await fn.expand(
              denops,
              "~/.cache/vscode/extensions/csharp/snippets/csharp.code-snippets",
            ),
            is.String,
          );
          await denops.call(`denippet#load`, cs, "cs");
          const powershell = ensure(
            await fn.expand(
              denops,
              "~/.cache/vscode-powershell/snippets/PowerShell.json",
            ),
            is.String,
          );
          await denops.call(`denippet#load`, powershell, "ps1");

          const userSnippetsDir = ensure(
            await fn.expand(denops, "~/.config/nvim/snippets"),
            is.String,
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

      // sources
      { url: "https://github.com/LumaKernel/ddc-file" },
      { url: "https://github.com/LumaKernel/ddc-run" },
      { url: "https://github.com/Shougo/ddc-source-around" },
      {
        url: "https://github.com/Shougo/ddc-source-codeium",
        enabled: async ({ denops }) =>
          await exists(ensure(await fn.expand(denops, "~/.codeium"), is.String)),
      },
      { url: "https://github.com/Shougo/ddc-source-cmdline" },
      { url: "https://github.com/Shougo/ddc-source-cmdline-history" },
      { url: "https://github.com/Shougo/ddc-source-input" },
      { url: "https://github.com/Shougo/ddc-source-line" },
      { url: "https://github.com/Shougo/ddc-source-lsp" },
      { url: "https://github.com/Shougo/ddc-source-omni" },
      { url: "https://github.com/Shougo/ddc-source-rg" },
      { url: "https://github.com/delphinus/ddc-treesitter" },
      { url: "https://github.com/matsui54/ddc-buffer" },
      { url: "https://github.com/uga-rosa/ddc-source-nvim-lua" },
      {
        url: "https://github.com/uga-rosa/ddc-source-lsp-setup",
        dependencies: [
          { url: "https://github.com/neovim/nvim-lspconfig" },
        ],
        after: async ({ denops }) => {
          await denops.call(`luaeval`, `require("ddc_source_lsp_setup").setup()`);
        },
      },
      // popup, signature
      {
        url: "https://github.com/uga-rosa/ddc-previewer-floating",
        enabled: false,
        dependencies: [
          { url: "https://github.com/Shougo/pum.vim" },
        ],
        after: async ({ denops }) => {
          await denops.call(`luaeval`, `require("ddc_previewer_floating").setup(_A)`, {
            border: "none",
          });
        },
      },
      {
        url: "https://github.com/matsui54/denops-popup-preview.vim",
        enabled: false,
        before: async ({ denops }) => {
          await vars.g.set(denops, "popup_preview_config", {
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
        url: "https://github.com/matsui54/denops-signature_help",
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
        sources: await exists(ensure(await fn.expand(denops, "~/.codeium"), is.String))
          ? ["codeium", "lsp", "denippet", "around", "file", "rg"]
          : ["lsp", "denippet", "around", "file", "rg"],
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
          codeium: {
            mark: "",
            matchers: [],
            minAutoCompleteLength: 0,
            isVolatile: true,
          },
          denippet: { mark: "" },
          file: {
            mark: "",
            isVolatile: true,
            "forceCompletionPattern": "\\S/\\S*",
          },
          rg: {
            mark: "",
            minAutoCompleteLength: 5,
          },
          "lsp": {
            mark: "󱐋",
            forceCompletionPattern: "\\.\\w*|::\\w*|->\\w*",
            dup: "force",
            sorters: ["sorter_lsp-kind"],
            converters: ["converter_kind_labels"],
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
          "lsp": {
            enableResolveItem: true,
            enableAdditionalTextEdit: true,
          },
        },
        filterParams: {
          converter_kind_labels: {
            kindLabels: {
              Text: "",
              Method: "",
              Function: "",
              Constructor: "",
              Field: "",
              Variable: "",
              Class: "",
              Interface: "",
              Module: "",
              Property: "",
              Unit: "",
              Value: "",
              Enum: "",
              Keyword: "",
              Snippet: "",
              Color: "",
              File: "",
              Reference: "",
              Folder: "",
              EnumMember: "",
              Constant: "",
              Struct: "",
              Event: "",
              Operator: "",
              TypeParameter: "",
            },
            kindHlGroups: {
              Method: "Function",
              Function: "Function",
              Constructor: "Function",
              Field: "Identifier",
              Variable: "Identifier",
              Class: "Structure",
              Interface: "Structure",
            },
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
        `<cmd>call pum#map#select_relative(+1, "empty")<cr>`,
        { mode: "i", noremap: true },
      );
      await mapping.map(
        denops,
        "<c-p>",
        `<cmd>call pum#map#select_relative(-1, "empty")<cr>`,
        { mode: "i", noremap: true },
      );
      await mapping.map(
        denops,
        "<c-f>",
        `pum#map#confirm_word()`,
        { mode: "i", noremap: true, expr: true },
      );
      await mapping.map(
        denops,
        "<tab>",
        `pum#visible() ? '<cmd>call pum#map#confirm()<cr>' : '<tab>'`,
        { mode: "i", noremap: true, expr: true },
      );
      await mapping.map(
        denops,
        "<c-space>",
        `ddc#map#manual_complete()`,
        { mode: "i", noremap: true, expr: true },
      );
      await mapping.map(
        denops,
        "<c-c>",
        `pum#visible() ? '<cmd>call pum#map#cancel()<cr>' : '<c-c>'`,
        {
          mode: "i",
          noremap: true,
          expr: true,
        },
      );
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
    build: async ({ denops }) => {
      await denops.call(`ddc#set_static_import_path`);
    },
  },
];
