return {
  "tani/glance-vim",

  enabled = false,

  lazy = false,

  dependencies = {
    "vim-denops/denops.vim",
  },
  init = function()
    vim.g["glance#markdown_breaks"] = true
    vim.g["glance#markdown_html"] = true
    -- vim.g["glance#markdown_plugins"] = {
    --   "npm:@wekanteam/markdown-it-mermaid",
    -- }

    vim.g["glance#config"] = "file:///" .. vim.fn.expand("~/.config/glance/init.ts")

    vim.api.nvim_create_autocmd("User", {
      group = "MyAutoCmd",
      pattern = "DenopsPluginPost:glance",
      callback = function()
        vim.notify("glance-vim loaded !")
      end,
    })
  end,
}
