-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Move to window using the <ctrl> movement keys
vim.keymap.set("n", "<C-h>", "<C-w>h", { silent = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { silent = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { silent = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { silent = true })

-- Resize window using <shift> arrow keys
vim.keymap.set("n", "<S-Up>", "<cmd>resize +2<CR>", { silent = true })
vim.keymap.set("n", "<S-Down>", "<cmd>resize -2<CR>", { silent = true })
vim.keymap.set("n", "<S-Left>", "<cmd>vertical resize -2<CR>", { silent = true })
vim.keymap.set("n", "<S-Right>", "<cmd>vertical resize +2<CR>", { silent = true })

-- Move Lines
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { silent = true })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi", { silent = true })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { silent = true })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { silent = true })
vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi", { silent = true })

-- Switch buffers with tab
vim.keymap.set("n", "<C-Left>", "<cmd>bprevious<cr>", { silent = true })
vim.keymap.set("n", "<C-Right>", "<cmd>bnext<cr>", { silent = true })

-- Clear search with <esc>
vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { silent = true })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
vim.keymap.set({ "n", "x", "o" }, "n", "'Nn'[v:searchforward]", { expr = true, noremap = true })
vim.keymap.set({ "n", "x", "o" }, "N", "'nN'[v:searchforward]", { expr = true, noremap = true })

vim.keymap.set("n", "<space><space>", "<cmd>update<cr>", { silent = true })
vim.keymap.set("n", "<tab>", "%", { silent = true })
vim.keymap.set("i", "<c-l>", "<C-g>U<Right>", { silent = true })

vim.keymap.set({ "n", "x" }, "gh", "^", { silent = true })
vim.keymap.set({ "n", "x" }, "gl", "$", { silent = true })

vim.keymap.set("c", "<c-b>", "<Left>", { silent = true })
vim.keymap.set("c", "<c-f>", "<Right>", { silent = true })
vim.keymap.set("c", "<c-a>", "<Home>", { silent = true })
vim.keymap.set("c", "<c-e>", "<End>", { silent = true })
vim.keymap.set("c", "<c-d>", "<Del>", { silent = true })
vim.keymap.set("c", "<c-y>", "<c-r>", { silent = true })
vim.keymap.set("c", "<c-p>", "<Up>", { silent = true })
vim.keymap.set("c", "<c-n>", "<Down>", { silent = true })

-- `s` prefix mappings
vim.keymap.set("n", "s", "<Nop>", { silent = true })
vim.keymap.set("n", "s0", "<cmd>only<cr>", { silent = true })
vim.keymap.set("n", "s=", "<c-w>=", { silent = true })
vim.keymap.set("n", "sH", "<c-w>H", { silent = true })
vim.keymap.set("n", "sJ", "<c-w>J", { silent = true })
vim.keymap.set("n", "sK", "<c-w>K", { silent = true })
vim.keymap.set("n", "sL", "<c-w>L", { silent = true })
vim.keymap.set("n", "sO", "<cmd>tabonly<cr>", { silent = true })
vim.keymap.set("n", "sQ", "<cmd>qa<cr>", { silent = true })
vim.keymap.set("n", "sbk", "<cmd>bd!<cr>", { silent = true })
vim.keymap.set("n", "sbq", "<cmd>q!<cr>", { silent = true })
vim.keymap.set("n", "sn", "<cmd>bn<cr>", { silent = true })
vim.keymap.set("n", "so", "<c-w>_<c-w>|", { silent = true })
vim.keymap.set("n", "sp", "<cmd>bp<cr>", { silent = true })
vim.keymap.set("n", "sq", "<cmd>q<cr>", { silent = true })
vim.keymap.set("n", "sr", "<c-w>r", { silent = true })
vim.keymap.set("n", "sh", "<cmd>sp<cr>", { silent = true })
vim.keymap.set("n", "st", "<cmd>tabnew<cr>", { silent = true })
vim.keymap.set("n", "sv", "<cmd>vs<cr>", { silent = true })
vim.keymap.set("n", "sw", "<c-w>w", { silent = true })

-- lazy.nvim
vim.keymap.set("n", "<space>l", "<cmd>Lazy<cr>", { silent = true })
