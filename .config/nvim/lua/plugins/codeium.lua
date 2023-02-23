return {
  "Exafunction/codeium.vim",

  enabled = true,

  event = "VeryLazy",

  cmd = "Codeium",

  init = function()
    vim.keymap.set("i", "<C-e>", function()
      return vim.fn["codeium#Accept"]()
    end, { expr = true, nowait = true })
    vim.keymap.set("i", "<c-j>", function()
      return vim.fn["codeium#CycleCompletions"](1)
    end, { expr = true })
    vim.keymap.set("i", "<c-k>", function()
      return vim.fn["codeium#CycleCompletions"](-1)
    end, { expr = true })
    vim.keymap.set("i", "<c-x>", function()
      return vim.fn["codeium#Clear"]()
    end, { expr = true })

    vim.api.nvim_create_autocmd("BufEnter", {
      pattern = "*",
      group = "MyAutoCmd",
      command = "stopinsert",
    })
  end,
}
