if vim.fn.has("nvim-0.9.0") == 1 then
  vim.opt.splitkeep = "screen"
end

local indent = 2

vim.g.encoding = "utf-8"
vim.g.fileencodings = "ucs-bom,utf-8,iso-2022-jp,euc-jp,cp932,latin1"

vim.opt.spell = true
vim.opt.cmdheight = 0
vim.opt.autowrite = true
vim.opt.clipboard = "unnamedplus"
vim.opt.conceallevel = 3
vim.opt.confirm = true
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.backup = true
vim.opt.backupdir = vim.fn.stdpath("state") .. "/backup"

vim.opt.formatoptions = "jcroqlnt" -- tcqj
vim.opt.grepprg = "rg --vimgrep"
vim.opt.grepformat = "%f:%l:%c:%m"
vim.opt.hidden = true
vim.opt.ignorecase = true
vim.opt.inccommand = "nosplit"
vim.opt.joinspaces = false
vim.opt.list = true
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.pumblend = 10
vim.opt.pumheight = 30
vim.opt.relativenumber = true
vim.opt.scrolloff = 4
vim.opt.shiftround = true
vim.opt.shiftwidth = indent
vim.opt.laststatus = 0
vim.opt.showmode = false
vim.opt.sidescrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.smartcase = true
vim.opt.smartindent = true

vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.tabstop = indent
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.undolevels = 10000
vim.opt.wildmode = "longest:full,full"
vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.wrap = false
vim.opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }
vim.opt.fillchars = {
  --   horiz = "━",
  --   horizup = "┻",
  --   horizdown = "┳",
  --   vert = "┃",
  --   vertleft = "┫",
  --   vertright = "┣",
  --   verthoriz = "╋",im.o.fillchars = [[eob: ,
  -- fold = " ",
  foldopen = "",
  -- foldsep = " ",
  foldclose = "",
}
-- vim.o.shortmess = "IToOlxfitn"
-- vim.opt.shortmess:get()
if vim.fn.has("nvim-0.9") == 1 then
  vim.o.shortmess = "filnxtToOFWIcC"
end

-- Use proper syntax highlighting in code blocks
local fences = {
  "lua",
  "vim",
  "json",
  "typescript",
  "javascript",
  "js=javascript",
  "ts=typescript",
  "shell=sh",
  "python",
  "sh",
  "console=sh",
}
vim.g.markdown_fenced_languages = fences
vim.g.markdown_recommended_style = 0

vim.api.nvim_create_autocmd("UIEnter", {
  once = true,
  callback = function()
    if vim.fn.exists(":GuiFont") > 0 then
      vim.cmd([[GuiFont! HackGen Console NF:h10]])
    end
    if vim.fn.exists(':GuiTabline') > 0 then
      vim.cmd([[GuiTabline 0]])
    end
    if vim.fn.exists(':GuiPopupmenu') > 0 then
      vim.cmd([[GuiPopupmenu 0]])
    end
  end,
})

vim.cmd([[colorscheme pink-moon]])
