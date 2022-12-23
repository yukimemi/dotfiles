if vim.fn.has("nvim-0.9.0") == 1 then
  vim.opt.splitkeep = "screen"
end

local indent = 2

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

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

vim.o.formatoptions = "jcroqlnt" -- tcqj
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

-- don't load the plugins below
local builtins = {
  "gzip",
  "zip",
  "zipPlugin",
  "fzf",
  "tar",
  "tarPlugin",
  "getscript",
  "getscriptPlugin",
  "vimball",
  "vimballPlugin",
  "2html_plugin",
  "matchit",
  "matchparen",
  "logiPat",
  "rrhelper",
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
}

for _, plugin in ipairs(builtins) do
  vim.g["loaded_" .. plugin] = 1
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

vim.g.colorscheme = "pink-moon"

