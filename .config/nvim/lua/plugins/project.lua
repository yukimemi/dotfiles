return {
  "ahmedkhalf/project.nvim",

  event = "VeryLazy",

  config = function()
    require("project_nvim").setup({
      show_hidden = true,
      silent_chdir = false,
      scope_chdir = "tab",
    })
  end,
}
