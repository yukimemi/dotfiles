// =============================================================================
// File        : cmp.ts
// Author      : yukimemi
// Last Change : 2023/07/22 14:30:27.
// =============================================================================

import type { Plug } from "https://deno.land/x/dvpm@3.1.0/mod.ts";
import { execute } from "https://deno.land/x/denops_std@v5.0.1/helper/execute.ts";
import { pluginStatus } from "../main.ts";

export const cmp: Plug[] = [
  {
    url: "hrsh7th/nvim-cmp",
    enabled: pluginStatus.cmp && !pluginStatus.vscode,
    dependencies: [
      { url: "hrsh7th/cmp-nvim-lsp" },
      { url: "hrsh7th/cmp-buffer" },
      { url: "hrsh7th/cmp-emoji" },
      { url: "hrsh7th/cmp-cmdline" },
      { url: "dmitmel/cmp-cmdline-history" },
      { url: "hrsh7th/cmp-path" },
      { url: "hrsh7th/cmp-vsnip" },
      { url: "hrsh7th/vim-vsnip" },
      { url: "hrsh7th/vim-vsnip-integ" },
      { url: "lukas-reineke/cmp-rg" },
      { url: "ray-x/cmp-treesitter" },
      { url: "yutkat/cmp-mocword" },
      { url: "chrisgrieser/cmp-nerdfont" },
      { url: "rafamadriz/friendly-snippets" },
      { url: "onsails/lspkind.nvim" },
      {
        url: "hrsh7th/cmp-nvim-lsp-signature-help",
        enabled: false,
      },
      {
        url: "KentoOgata/cmp-tsnip",
        dependencies: [
          { url: "yuki-yano/tsnip.nvim" },
          { url: "hrsh7th/nvim-cmp" },
        ],
      },
    ],
    after: async ({ denops }) => {
      await execute(
        denops,
        `
          lua << EOB
            local cmp = require("cmp")

            cmp.setup({
              snippet = {
                expand = function(args)
                  vim.fn["vsnip#anonymous"](args.body)
                end,
              },
              window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
              },
              mapping = cmp.mapping.preset.insert({
                ["<C-u>"] = cmp.mapping.scroll_docs(-4),
                ["<C-d>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-c>"] = cmp.mapping.abort(),
                ["<CR>"] = cmp.mapping.confirm({ select = false }),
                ["<C-e>"] = cmp.mapping.confirm({ select = true }),
                ["<C-k>"] = cmp.mapping.confirm({ select = false }),
                ["<C-j>"] = cmp.mapping.confirm({ select = false }),
                ["<C-f>"] = cmp.mapping(function(fallback)
                  if cmp.visible() then
                    return cmp.complete_common_string()
                  end
                  fallback()
                end, { "i", "c" }),
              }),
              sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "vsnip" },
                { name = "rg" },
                { name = 'mocword' },
                { name = 'tsnip' },
                { name = "treesitter" },
                { name = "path" },
                { name = "nerdfont" },
                { name = "emoji" },
              }, {
                { name = "buffer" },
              }, {
                { name = "nvim_lsp_signature_help" },
              }),
              -- experimental = {
              --   ghost_text = {
              --     hl_group = "LspCodeLens",
              --   },
              -- },
              formatting = {
                format = require("lspkind").cmp_format({
                  mode = "symbol",
                  maxwidth = 50,
                }),
              },
            })

            cmp.setup.cmdline({ "/", "?" }, {
              mapping = cmp.mapping.preset.cmdline({
                ["<C-n>"] = cmp.mapping(function(fallback)
                  fallback()
                end, { "c" }),
                ["<C-p>"] = cmp.mapping(function(fallback)
                  fallback()
                end, { "c" }),
              }),
              sources = {
                { name = "buffer" },
              },
            })

            cmp.setup.cmdline(":", {
              mapping = cmp.mapping.preset.cmdline({
                ["<C-n>"] = cmp.mapping(function(fallback)
                  fallback()
                end, { "c" }),
                ["<C-p>"] = cmp.mapping(function(fallback)
                  fallback()
                end, { "c" }),
              }),
              sources = cmp.config.sources({
                { name = "path" },
              }, {
                { name = "cmdline" },
              }),
            })
          EOB
        `,
      );
    },
  },
];
