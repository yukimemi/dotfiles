
vim.keymap.set("c", "<space>", function()
	return vim.fn["ambicmd#expand"]("<space>")
end, { expr = true })
vim.keymap.set("c", "<cr>", function()
	return vim.fn["ambicmd#expand"]("<cr>")
end, { expr = true })

  vim.keymap.set("c", "<c-f>", function()
	  return vim.fn["ambicmd#expand"]("<right>")
  end, { expr = true })

  vim.api.nvim_create_autocmd("CmdwinEnter", {
	  group = "MyAutoCmd",
	  callback = function()
		  vim.keymap.set("i", "<space>", function()
			  return vim.fn["ambicmd#expand"]("<space>")
		  end, { buffer = true, expr = true })
		  vim.keymap.set("i", "<cr>", function()
			  return vim.fn["ambicmd#expand"]("<cr>")
		  end, { buffer = true, expr = true })
	  end,
  })

