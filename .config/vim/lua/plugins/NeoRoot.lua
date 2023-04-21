return {
  "nyngwang/NeoRoot.lua",

  enabled = false,

  event = "BufEnter",

  init = function()
    vim.api.nvim_create_autocmd("BufEnter", {
      group = "MyAutoCmd",
      pattern = "*",
      command = "NeoRoot",
    })
  end,

  config = function()
    require("neo-root").setup({
      CUR_MODE = 2 -- 1 for file/buffer mode, 2 for proj-mode
    })
  end,
}
