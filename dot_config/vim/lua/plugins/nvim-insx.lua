return {
  "hrsh7th/nvim-insx",

  event = "InsertEnter",

  enabled = true,

  config = function()
    require('insx.preset.standard').setup()
  end,
}
