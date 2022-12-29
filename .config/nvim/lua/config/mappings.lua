local util = require("util")

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Move to window using the <ctrl> movement keys
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- Resize window using <ctrl> arrow keys
vim.keymap.set("n", "<S-Up>", "<cmd>resize +2<CR>")
vim.keymap.set("n", "<S-Down>", "<cmd>resize -2<CR>")
vim.keymap.set("n", "<S-Left>", "<cmd>vertical resize -2<CR>")
vim.keymap.set("n", "<S-Right>", "<cmd>vertical resize +2<CR>")

-- Move Lines
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==")
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi")
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==")
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv")
vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi")

-- Switch buffers with tab
vim.keymap.set("n", "<C-Left>", "<cmd>bprevious<cr>")
vim.keymap.set("n", "<C-Right>", "<cmd>bnext<cr>")

-- Clear search with <esc>
vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>")

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
vim.keymap.set({ "n", "x", "o" }, "n", "'Nn'[v:searchforward]", { expr = true })
vim.keymap.set({ "n", "x", "o" }, "N", "'nN'[v:searchforward]", { expr = true })

vim.keymap.set("n", "<space><space>", "<cmd>update<cr>")
vim.keymap.set("n", "<tab>", "%")
vim.keymap.set("i", "<c-l>", "<C-g>U<Right>")

vim.keymap.set({ "n", "x" }, "gh", "^")
vim.keymap.set({ "n", "x" }, "gl", "$")

vim.keymap.set("n", "s", "<Nop>")
vim.keymap.set("n", "s0", "<cmd>only<cr>")
vim.keymap.set("n", "s=", "<c-w>=")
vim.keymap.set("n", "sH", "<c-w>H")
vim.keymap.set("n", "sJ", "<c-w>J")
vim.keymap.set("n", "sK", "<c-w>K")
vim.keymap.set("n", "sL", "<c-w>L")
vim.keymap.set("n", "sO", "<cmd>tabonly<cr>")
vim.keymap.set("n", "sQ", "<cmd>qa<cr>")
vim.keymap.set("n", "sbk", "<cmd>bd!<cr>")
vim.keymap.set("n", "sbq", "<cmd>q!<cr>")
vim.keymap.set("n", "sn", "<cmd>bn<cr>")
vim.keymap.set("n", "so", "<c-w>_<c-w>|")
vim.keymap.set("n", "sp", "<cmd>bp<cr>")
vim.keymap.set("n", "sq", "<cmd>q<cr>")
vim.keymap.set("n", "sr", "<c-w>r")
vim.keymap.set("n", "ss", "<cmd>sp<cr>")
vim.keymap.set("n", "st", "<cmd>tabnew<cr>")
vim.keymap.set("n", "sv", "<cmd>vs<cr>")
vim.keymap.set("n", "sw", "<c-w>w")

vim.keymap.set("n", "<space>l", "<cmd>Lazy<cr>")

