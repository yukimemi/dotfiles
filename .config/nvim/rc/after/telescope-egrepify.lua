-- =============================================================================
-- File        : telescope-egrepify.lua
-- Author      : yukimemi
-- Last Change : 2024/12/01 09:37:58.
-- =============================================================================

require("telescope").load_extension("egrepify")

vim.keymap.set("n", "<space>sg", "<cmd>Telescope egrepify<cr>", { desc = "Grep" })
vim.keymap.set("n", "<space>gi", function()
  local cwd = vim.fn.input("path: ", vim.fn.getcwd(), "dir")
  require("telescope").extensions.egrepify.egrepify({
    cwd = cwd,
  })
end, { desc = "Grep interactively" })

require("telescope").setup({
  extensions = {
    egrepify = {
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--trim",
        "--no-ignore",
        "--glob",
        "!**/node_modules/**",
        "--glob",
        "!**/.git/**",
      }
    }
  }
})