require("nvim-treesitter.configs").setup({
  yati = {
    enable = true,
    -- Disable by languages
    disable = {},

    -- Whether to enable lazy mode (recommend to enable this if bad indent happens frequently)
    default_lazy = true,

    -- Determine the fallback method used when we cannot calculate indent by tree-sitter
    --   "auto": fallback to vim auto indent
    --   "asis": use current indent as-is
    --   "cindent": see ':h cindent()'
    default_fallback = "auto"
  },
  indent = {
    enable = false           -- disable builtin indent module
  }
})
