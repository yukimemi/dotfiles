return {
  "neoclide/coc.nvim",

  branch = "release",
  event = "InsertEnter",

  init = function()
    vim.g.coc_global_extensions = {
      "coc-deno",
      "coc-diagnostic",
      "coc-explorer",
      "coc-json",
      "coc-lists",
      "coc-marketplace",
      "coc-powershell",
      "coc-rust-analyzer",
      "coc-snippets",
      "coc-spell-checker",
      "coc-translator",
      "coc-tsdetect",
      "coc-vimlsp",
    }
    vim.g.coc_disable_startup_warning = 1
    vim.g.coc_disable_uncaught_error = 1
  end,
}
