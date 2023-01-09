vim.opt.encoding = "utf-8"
vim.opt.fileencodings = "ucs-bom,utf-8,iso-2022-jp,euc-jp,cp932,latin1"

vim.opt.backup = true
vim.opt.backupdir = vim.fn.stdpath("state") .. "/backup"
vim.opt.clipboard = "unnamedplus"
vim.opt.cmdheight = 0
vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.confirm = true
vim.opt.expandtab = true
vim.opt.grepformat = "%f:%l:%c:%m"
vim.opt.grepprg = "rg --vimgrep"
vim.opt.hidden = true
vim.opt.ignorecase = true
vim.opt.inccommand = "nosplit"
vim.opt.laststatus = 0
vim.opt.list = true
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.pumblend = 10
vim.opt.pumheight = 30
vim.opt.relativenumber = true
vim.opt.scrolloff = 4
vim.opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }
vim.opt.shiftround = true
vim.opt.shiftwidth = 2
vim.opt.showmode = false
vim.opt.sidescrolloff = 4
vim.opt.signcolumn = "yes"
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.spell = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.tabstop = 2
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.undolevels = 10000
vim.opt.wildmode = "longest:full,full"
vim.opt.wrap = false

-- Use proper syntax highlighting in code blocks
vim.g.markdown_recommended_style = 0
vim.g.markdown_fenced_languages = {
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

