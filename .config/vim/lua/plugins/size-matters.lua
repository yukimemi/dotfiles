return {
  "tenxsoydev/size-matters.nvim",

  enabled = true,

  event = "VeryLazy",

  config = function()
    require("size-matters").setup({
      default_mappings = true,
      -- font resize step size
      step_size = 1,
      notifications = {
        -- default value is true if notify is installed else false
        enable = false,
        -- ms how long a notifiation will be shown
        timeout = 150,
        -- depending on the client and if using multigrid, the time it takes for the client to re-render
        -- after a font size change can affect the position of the notification. Displaying it with a delay remedies this.
        delay = 200,
      },
      reset_font = vim.api.nvim_get_option("guifont"), -- Font loaded when using the reset cmd / shortcut
    })
  end,

}
