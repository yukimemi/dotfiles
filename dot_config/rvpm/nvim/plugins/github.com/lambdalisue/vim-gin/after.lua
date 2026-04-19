local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map("n", "<space>gs", "<cmd>GinStatus<cr>", opts)
map("n", "<space>gc", "<cmd>Gin commit -v<cr>", opts)
-- map("n", "<space>gb", "<cmd>GinBranch<cr>", opts)
-- map("n", "<space>gd", "<cmd>GinDiff<cr>", opts)
-- map("n", "<space>gl", "<cmd>GinLog<cr>", opts)
map("n", "<space>gL", "<cmd>GinLog -p -- %<cr>", opts)
map("n", "<space>gp", "<cmd>Gin push<cr>", opts)
-- map("n", "<space>gg", ":<c-u>Gin grep ", opts)

local function run_gin_lcd(buf)
  if buf and vim.bo[buf].buftype ~= "" then return end
  pcall(vim.cmd, "GinLcd")
end

local function setup_gin_lcd()
  vim.api.nvim_create_autocmd({ 'BufRead', 'BufNew' }, {
    group = vim.api.nvim_create_augroup("MyGinCd", { clear = true }),
    pattern = "*",
    callback = function(args)
      run_gin_lcd(args.buf)
    end,
  })
  run_gin_lcd(vim.api.nvim_get_current_buf())
end

if vim.fn.exists("*denops#plugin#is_loaded") == 1
    and vim.fn["denops#plugin#is_loaded"]("gin") == 1 then
  setup_gin_lcd()
else
  vim.api.nvim_create_autocmd("User", {
    pattern = "DenopsPluginPost:gin",
    once = true,
    callback = setup_gin_lcd,
  })
end
