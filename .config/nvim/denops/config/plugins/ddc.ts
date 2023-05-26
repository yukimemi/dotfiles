import type { Denops } from "https://deno.land/x/denops_std@v5.0.0/mod.ts";
import type { Plug } from "https://deno.land/x/dvpm@0.3.5/mod.ts";

import * as mapping from "https://deno.land/x/denops_std@v5.0.0/mapping/mod.ts";
import { globals } from "https://deno.land/x/denops_std@v5.0.0/variable/mod.ts";
import { pluginStatus } from "../main.ts";

export const ddc: Plug[] = [
  {
    url: "Shougo/ddc.vim",
    enabled: pluginStatus.ddc,
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
        after: async (denops: Denops) => {
          await denops.call("pum#set_option", {
            use_complete: false,
            horizontal_menu: false,
            min_width: 3,
            max_width: 100,
            max_height: 30,
            use_setline: false,
            border: "single",
            scrollbar_char: "",
            padding: true,
          });
        },
      },
      { url: "Shougo/ddc-ui-pum" },
      { url: "Shougo/ddc-ui-inline" },

      // snippet
      { url: "hrsh7th/vim-vsnip" },

      // sources
      { url: "LumaKernel/ddc-file" },
      { url: "LumaKernel/ddc-run" },
      { url: "Shougo/ddc-source-around" },
      { url: "matsui54/ddc-buffer" },
      { url: "Shougo/ddc-source-omni" },
      { url: "Shougo/ddc-source-cmdline" },
      { url: "Shougo/ddc-source-input" },
      { url: "Shougo/ddc-source-cmdline-history" },
      { url: "Shougo/ddc-source-line" },
      { url: "Shougo/ddc-source-nvim-lua" },
      { url: "Shougo/ddc-source-rg" },
      { url: "Shougo/ddc-source-nvim-lsp" },
      { url: "delphinus/ddc-treesitter" },

      // popup, signature
      {
        url: "matsui54/denops-popup-preview.vim",
        before: async (denops: Denops) => {
          await globals.set(denops, "popup_preview_config", {
            delay: 50,
            border: true,
            supportVsnip: true,
          });
        },
        after: async (denops: Denops) => {
          await denops.call(`popup_preview#enable`);
        },
      },
      {
        url: "matsui54/denops-signature_help",
        enabled: true,
        after: async (denops: Denops) => {
          await denops.call(`signature_help#enable`);
        },
      },
    ],
    after: async (denops: Denops) => {
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
        sourceOptions: {
          _: {
            ignoreCase: true,
            matchers: ["matcher_fuzzy"],
            sorters: ["sorter_fuzzy"],
            converters: ["converter_fuzzy"],
          },
          around: { mark: "around" },
          buffer: { mark: "buffer" },
          line: { mark: "line" },
          "nvim-lsp": { mark: "lsp" },
          file: { mark: "file" },
          rg: { mark: "rg" },
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
        },
      });

      // mappings.
      await mapping.map(
        denops,
        "<c-n>",
        "<cmd>call pum#map#insert_relative(+1)<cr>",
        { mode: "i" },
      );
      await mapping.map(
        denops,
        "<c-p>",
        "<cmd>call pum#map#insert_relative(-1)<cr>",
        { mode: "i" },
      );
      await mapping.map(
        denops,
        "<c-space>",
        "<cmd>call ddc#map#manual_complete()<cr>",
        { mode: "i" },
      );

      await denops.call(`ddc#enable`);
    },
  },
];
