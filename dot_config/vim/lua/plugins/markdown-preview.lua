return {
  "iamcco/markdown-preview.nvim",

  ft = "markdown",

  init = function()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "markdown",
      callback = function()
        vim.keymap.set("n", "<c-s>", "<cmd>MarkdownPreviewToggle<cr>", { buffer = true })
      end,
    })
  end,

  build = "cd app && yarn install",
}
