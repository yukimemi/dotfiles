-- =============================================================================
-- File        : nvim-cmp.lua
-- Author      : yukimemi
-- Last Change : 2024/08/31 14:42:16.
-- =============================================================================

local cmp = require("cmp")

cmp.setup({
  snippet = {
    expand = function(args)
      -- vim.fn["vsnip#anonymous"](args.body)
      vim.fn["denippet#anonymous"](args.body)
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
    ["<C-d>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-c>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = false }),
    ["<tab>"] = cmp.mapping.confirm({ select = true }),
    ["<C-k>"] = cmp.mapping.confirm({ select = false }),
    ["<C-j>"] = cmp.mapping.confirm({ select = false }),
    ["<C-f>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        return cmp.complete_common_string()
      end
      fallback()
    end, { "i", "c" }),
    ["<C-e>"] = cmp.mapping(function(fallback)
      fallback()
    end, { "i" }),
    ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
    ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    -- { name = "vsnip" },
    { name = "denippet" },
    { name = "rg" },
    -- { name = "mocword" },
    { name = "tsnip" },
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
    { name = "cmdline" },
  }),
})

cmp.setup.cmdline("@", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "cmdline-prompt" },
  }),
  sorting = {
    comparators = { cmp.config.compare.order },
  },
})

cmp.setup.filetype({ "clap_input" }, {
  completion = {
    autocomplete = false,
  },
})
