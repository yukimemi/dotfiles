return {
  "ahmedkhalf/project.nvim",

  enabled = true,

  event = "VeryLazy",

  config = function()
    require("project_nvim").setup({
      show_hidden = true,
      silent_chdir = true,
      scope_chdir = "tab",
      patterns = { "Cargo.toml", ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },
    })
  end,
}
