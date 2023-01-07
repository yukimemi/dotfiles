local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.g.plugin_use_cmp = true
vim.g.plugin_use_ddc = false

vim.g.plugin_use_ddu = true
vim.g.plugin_use_ctrlp = true

vim.api.nvim_create_augroup("MyAutoCmd", { clear = true })

require("lazy").setup("plugins", {
  defaults = { lazy = true },
  checker = {
    enabled = false,
    frequency = 86400,
  },
  concurrency = (function()
    if jit.os:find("Windows") then
      return nil
    else
      return 13
    end
  end)(),
  install = {
    colorscheme = { "pink-moon" }
  },
  dev = {
    path = "~/src/github.com/yukimemi",
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
  debug = false,
})

require("config.options")

vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    require("config.commands")
    require("config.mappings")
  end,
})
