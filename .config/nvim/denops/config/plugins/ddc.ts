// =============================================================================
// File        : ddc.ts
// Author      : yukimemi
// Last Change : 2026/01/17 22:37:02.
// =============================================================================

import { Denops } from "@denops/std";
import * as autocmd from "@denops/std/autocmd";
import * as fn from "@denops/std/function";
import * as lambda from "@denops/std/lambda";
import * as mapping from "@denops/std/mapping";
import * as vars from "@denops/std/variable";
import { exists } from "@std/fs/exists";
import type { Plug } from "@yukimemi/dvpm";
import { z } from "zod";
import { selections } from "../pluginstatus.ts";
import { notify } from "../util.ts";

export const ddc: Plug[] = [
  // ui
  {
    url: "https://github.com/Shougo/pum.vim",
    enabled: selections.completion === "ddc",
    profiles: ["completion"],
    after: async ({ denops }) => {
      await denops.call("pum#set_option", {
        auto_confirm_time: 0,
        auto_select: false,
        border: "none",
        follow_cursor: false,
        offset_cmdcol: 0,
        padding: false,
        scrollbar_char: "┃",
        use_setline: false,
        insert_preview: true,
      });
    },
  },
  {
    url: "https://github.com/Shougo/ddc-source-codeium",
    enabled: async ({ denops }) =>
      selections.completion === "ddc" &&
      await exists(z.string().parse(await fn.expand(denops, "~/.codeium"))),
    profiles: ["completion"],
  },
  {
    url: "https://github.com/uga-rosa/ddc-source-lsp-setup",
    enabled: selections.completion === "ddc",
    profiles: ["completion"],
    dependencies: [
      "https://github.com/neovim/nvim-lspconfig",
      "https://github.com/Shougo/ddc-source-lsp",
    ],
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("ddc_source_lsp_setup").setup()`);
    },
  },
  // popup, signature
  {
    url: "https://github.com/uga-rosa/ddc-previewer-floating",
    enabled: selections.completion === "ddc",
    profiles: ["completion"],
    dependencies: [
      "https://github.com/Shougo/pum.vim",
    ],
    after: async ({ denops }) => {
      await denops.call(
        `luaeval`,
        `require("ddc_previewer_floating").setup(_A)`,
        {
          border: "none",
        },
      );
    },
  },
  {
    url: "https://github.com/matsui54/denops-popup-preview.vim",
    enabled: selections.completion === "ddc",
    profiles: ["completion"],
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
    enabled: selections.completion === "ddc",
    profiles: ["completion"],
    after: async ({ denops }) => {
      await denops.call(`signature_help#enable`);
    },
  },
  {
    url: "https://github.com/LumaKernel/ddc-file",
    enabled: selections.completion === "ddc",
    profiles: ["completion"],
  },
  {
    url: "https://github.com/LumaKernel/ddc-run",
    enabled: selections.completion === "ddc",
    profiles: ["completion"],
  },
  {
    url: "https://github.com/Shougo/ddc-filter-converter_remove_overlap",
    enabled: selections.completion === "ddc",
    profiles: ["completion"],
  },
  {
    url: "https://github.com/Shougo/ddc-filter-converter_truncate_abbr",
    enabled: selections.completion === "ddc",
    profiles: ["completion"],
  },
  {
    url: "https://github.com/Shougo/ddc-filter-matcher_head",
    enabled: selections.completion === "ddc",
    profiles: ["completion"],
  },
  {
    url: "https://github.com/Shougo/ddc-filter-matcher_length",
    enabled: selections.completion === "ddc",
    profiles: ["completion"],
  },
  {
    url: "https://github.com/Shougo/ddc-filter-matcher_vimregexp",
    enabled: selections.completion === "ddc",
    profiles: ["completion"],
  },
  {
    url: "https://github.com/Shougo/ddc-filter-sorter_rank",
    enabled: selections.completion === "ddc",
    profiles: ["completion"],
  },
  {
    url: "https://github.com/Shougo/ddc-source-around",
    enabled: selections.completion === "ddc",
    profiles: ["completion"],
  },
  {
    url: "https://github.com/Shougo/ddc-source-cmdline",
    enabled: selections.completion === "ddc",
    profiles: ["completion"],
  },
  {
    url: "https://github.com/Shougo/ddc-source-cmdline-history",
    enabled: selections.completion === "ddc",
    profiles: ["completion"],
  },
  {
    url: "https://github.com/Shougo/ddc-source-input",
    enabled: selections.completion === "ddc",
    profiles: ["completion"],
  },
  {
    url: "https://github.com/Shougo/ddc-source-line",
    enabled: selections.completion === "ddc",
    profiles: ["completion"],
  },
  {
    url: "https://github.com/Shougo/ddc-source-lsp",
    enabled: selections.completion === "ddc",
    profiles: ["completion"],
  },
  {
    url: "https://github.com/Shougo/ddc-source-omni",
    enabled: selections.completion === "ddc",
    profiles: ["completion"],
  },
  {
    url: "https://github.com/Shougo/ddc-source-rg",
    enabled: selections.completion === "ddc",
    profiles: ["completion"],
  },
  {
    url: "https://github.com/Shougo/ddc-ui-inline",
    enabled: selections.completion === "ddc",
    profiles: ["completion"],
  },
  {
    url: "https://github.com/Shougo/ddc-ui-pum",
    enabled: selections.completion === "ddc",
    profiles: ["completion"],
  },
  {
    url: "https://github.com/delphinus/ddc-treesitter",
    enabled: selections.completion === "ddc",
    profiles: ["completion"],
  },
  {
    url: "https://github.com/matsui54/ddc-buffer",
    enabled: selections.completion === "ddc",
    profiles: ["completion"],
  },
  {
    url: "https://github.com/tani/ddc-fuzzy",
    enabled: selections.completion === "ddc",
    profiles: ["completion"],
  },
  {
    url: "https://github.com/uga-rosa/ddc-source-nvim-lua",
    enabled: selections.completion === "ddc",
    profiles: ["completion"],
  },
  {
    url: "https://github.com/Shougo/ddc.vim",
    enabled: selections.completion === "ddc",
    profiles: ["completion"],
    dependencies: [
      // matcher, sorter, converter
      "https://github.com/tani/ddc-fuzzy",
      "https://github.com/Shougo/ddc-filter-matcher_head",
      "https://github.com/Shougo/ddc-filter-matcher_length",
      "https://github.com/Shougo/ddc-filter-matcher_vimregexp",
      "https://github.com/Shougo/ddc-filter-sorter_rank",
      "https://github.com/Shougo/ddc-filter-converter_remove_overlap",
      "https://github.com/Shougo/ddc-filter-converter_truncate_abbr",

      "https://github.com/Shougo/pum.vim",
      "https://github.com/Shougo/ddc-ui-pum",
      "https://github.com/Shougo/ddc-ui-inline",

      // sources
      "https://github.com/LumaKernel/ddc-file",
      "https://github.com/LumaKernel/ddc-run",
      "https://github.com/Shougo/ddc-source-around",
      "https://github.com/Shougo/ddc-source-codeium",
      "https://github.com/Shougo/ddc-source-cmdline",
      "https://github.com/Shougo/ddc-source-cmdline-history",
      "https://github.com/Shougo/ddc-source-input",
      "https://github.com/Shougo/ddc-source-line",
      "https://github.com/Shougo/ddc-source-omni",
      "https://github.com/Shougo/ddc-source-rg",
      "https://github.com/delphinus/ddc-treesitter",
      "https://github.com/matsui54/ddc-buffer",
      "https://github.com/uga-rosa/ddc-source-nvim-lua",
      "https://github.com/uga-rosa/ddc-source-lsp-setup",
    ],
    build: async ({ denops, info }) => {
      if (!info.isLoaded) {
        return;
      }
      await notify(denops, `call ddc#set_static_import_path()`);
      await denops.call(`ddc#set_static_import_path`);
    },
    after: async ({ denops }) => {
      // commandline settings.
      const cmdLinePre = async (denops: Denops, mode: string) => {
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
        sources:
          await exists(z.string().parse(await fn.expand(denops, "~/.codeium")))
            ? ["codeium", "lsp", "denippet", "around", "file", "rg"]
            : ["lsp", "denippet", "around", "file", "rg"],
        cmdlineSources: {
          ":": ["cmdline", "cmdline_history", "around"],
          "@": ["input", "cmdline_history", "file", "around"],
          ">": ["input", "cmdline_history", "file", "around"],
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
          denippet: { mark: "" },
          codeium: {
            mark: "",
            matchers: [],
            minAutoCompleteLength: 0,
            isVolatile: true,
          },
          file: {
            mark: "",
            isVolatile: true,
            forceCompletionPattern: "\\S/\\S*",
          },
          rg: {
            mark: "",
            // minAutoCompleteLength: 1,
            // enabledIf: "finddir('.git', ';') != ''",
          },
          "lsp": {
            mark: "󱐋",
            forceCompletionPattern: "\\.\\w*|::\\w*|->\\w*",
            dup: "force",
            sorters: ["sorter_lsp_kind"],
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

      await denops.call(`ddc#enable`, { context_filetype: "treesiters" });
    },
  },
];
