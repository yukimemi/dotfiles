return {
  "sidebar-nvim/sidebar.nvim",

  event = "VeryLazy",

  config = function()
    require("sidebar-nvim").setup({
      open = true,
      side = "left",
      initial_width = 35,
      hide_statusline = false,
      update_interval = 1000,
      sections = { "git", "diagnostics", "buffers", "symbols" },
      section_separator = {"", "-----", ""},
      section_title_separator = {""},
      todos = { ignored_paths = { "~" } },
    })
  end,
}

