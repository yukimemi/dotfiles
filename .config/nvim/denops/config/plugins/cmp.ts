// =============================================================================
// File        : cmp.ts
// Author      : yukimemi
// Last Change : 2023/09/02 17:09:09.
// =============================================================================

import type { Plug } from "https://deno.land/x/dvpm@3.8.1/mod.ts";
import { execute } from "https://deno.land/x/denops_std@v5.3.0/helper/execute.ts";
import { pluginStatus } from "../pluginstatus.ts";

export const cmp: Plug[] = [
  {
    url: "https://github.com/hrsh7th/nvim-cmp",
    enabled: pluginStatus.cmp && !pluginStatus.vscode,
    dependencies: [
      { url: "https://github.com/hrsh7th/cmp-nvim-lsp" },
      { url: "https://github.com/hrsh7th/cmp-buffer" },
      { url: "https://github.com/hrsh7th/cmp-emoji" },
      { url: "https://github.com/hrsh7th/cmp-cmdline" },
      { url: "https://github.com/dmitmel/cmp-cmdline-history" },
      { url: "https://github.com/hrsh7th/cmp-path" },
      { url: "https://github.com/hrsh7th/cmp-vsnip" },
      { url: "https://github.com/hrsh7th/vim-vsnip" },
      { url: "https://github.com/hrsh7th/vim-vsnip-integ" },
      { url: "https://github.com/lukas-reineke/cmp-rg" },
      { url: "https://github.com/ray-x/cmp-treesitter" },
      { url: "https://github.com/yutkat/cmp-mocword" },
      { url: "https://github.com/chrisgrieser/cmp-nerdfont" },
      { url: "https://github.com/rafamadriz/friendly-snippets" },
      { url: "https://github.com/onsails/lspkind.nvim" },
      {
        url: "https://github.com/hrsh7th/cmp-nvim-lsp-signature-help",
        enabled: false,
      },
      {
        url: "https://github.com/KentoOgata/cmp-tsnip",
        dependencies: [
          { url: "https://github.com/yuki-yano/tsnip.nvim" },
          { url: "https://github.com/hrsh7th/nvim-cmp" },
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
