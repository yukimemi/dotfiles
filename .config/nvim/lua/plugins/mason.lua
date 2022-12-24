return {
  "williamboman/mason.nvim",

  enabled = true,

  cmd = "Mason",

  config = function()
    require("mason").setup()
  end,
}

