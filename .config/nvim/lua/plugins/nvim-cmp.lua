local M = {
  "hrsh7th/nvim-cmp",

  enabled = vim.g.plugin_use_cmp,

  event = "InsertEnter",

  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-emoji",
    "hrsh7th/cmp-cmdline",
    "dmitmel/cmp-cmdline-history",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-vsnip",
    "hrsh7th/vim-vsnip",
    "hrsh7th/vim-vsnip-integ",
    "rafamadriz/friendly-snippets",
    "onsails/lspkind.nvim",
    {
      "hrsh7th/cmp-nvim-lsp-signature-help",
      enabled = true,
    },
  },
}

function M.config()
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
      { name = "path" },
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

  -- Use buffer source for `/` and `?`
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

  -- Use cmdline & path source for ':'
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
end

return M
