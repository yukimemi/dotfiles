require("theme_peeper").setup({
  picker = "snacks",
  persist = true,
  preview = {
    border = "rounded",
  },
})

vim.keymap.set("n", "<leader>tp", function()
  require("theme_peeper").select()
end, { desc = "Theme Peeper" })
