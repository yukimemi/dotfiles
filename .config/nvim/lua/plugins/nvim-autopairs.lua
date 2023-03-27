return {
  "windwp/nvim-autopairs",

  enabled = not vim.g.plugin_use_ddc,

  dependencies = {
    "hrsh7th/nvim-cmp",
    enabled = vim.g.plugin_use_cmp,
  },

  event = "InsertEnter",

  config = function()
    require("nvim-autopairs").setup()
    -- If you want insert `(` after select function or method item
    if vim.g.plugin_use_cmp then
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local cmp = require('cmp')
      cmp.event:on(
        'confirm_done',
        cmp_autopairs.on_confirm_done()
      )
    end
  end,
}
