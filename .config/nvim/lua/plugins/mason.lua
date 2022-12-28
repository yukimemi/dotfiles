return {
  "williamboman/mason.nvim",

  enabled = true,

  cmd = "Mason",

  config = function()
    require("mason").setup({
      providers = {
        "mason.providers.client",
        "mason.providers.registry-api",
      }
    })
  end,
}
