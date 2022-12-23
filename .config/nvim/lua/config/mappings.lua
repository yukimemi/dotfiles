local wk = require("which-key")
local util = require("util")

wk.setup({
  show_help = false,
  triggers = "auto",
  plugins = { spelling = true },
  key_labels = { ["<leader>"] = "SPC" },
})

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
vim.keymap.set("n", "n", "'Nn'[v:searchforward]", { expr = true })
vim.keymap.set("x", "n", "'Nn'[v:searchforward]", { expr = true })
vim.keymap.set("o", "n", "'Nn'[v:searchforward]", { expr = true })
vim.keymap.set("n", "N", "'nN'[v:searchforward]", { expr = true })
vim.keymap.set("x", "N", "'nN'[v:searchforward]", { expr = true })
vim.keymap.set("o", "N", "'nN'[v:searchforward]", { expr = true })

vim.keymap.set("n", "<space><space>", "<cmd>update<cr>")
vim.keymap.set("n", "<tab>", "%")
vim.keymap.set("i", "<c-l>", "<C-g>U<Right>")

vim.keymap.set("n", "gh", "^")
vim.keymap.set("n", "gl", "$")

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

local leader = {
  ["w"] = {
    name = "+windows",
    ["w"] = { "<C-W>p", "other-window" },
    ["-"] = { "<C-W>s", "split-window-below" },
    ["|"] = { "<C-W>v", "split-window-right" },
    ["2"] = { "<C-W>v", "layout-double-columns" },
    ["h"] = { "<C-W>h", "window-left" },
    ["j"] = { "<C-W>j", "window-below" },
    ["l"] = { "<C-W>l", "window-right" },
    ["k"] = { "<C-W>k", "window-up" },
    ["H"] = { "<C-W>5<", "expand-window-left" },
    ["J"] = { "<cmd>resize +5<cr>", "expand-window-below" },
    ["L"] = { "<C-W>5>", "expand-window-right" },
    ["K"] = { "<cmd>resize -5<cr>", "expand-window-up" },
    ["="] = { "<C-W>=", "balance-window" },
    ["s"] = { "<C-W>s", "split-window-below" },
    ["v"] = { "<C-W>v", "split-window-right" },
  },
  c = {
    name = "+code",
  },
  b = {
    name = "+buffer",
    ["b"] = { "<cmd>e #<cr>", "Switch to Other Buffer" },
    ["p"] = { "<cmd>BufferLineCyclePrev<CR>", "Previous Buffer" },
    ["["] = { "<cmd>BufferLineCyclePrev<CR>", "Previous Buffer" },
    ["n"] = { "<cmd>BufferLineCycleNext<CR>", "Next Buffer" },
    ["]"] = { "<cmd>BufferLineCycleNext<CR>", "Next Buffer" },
  },
  g = {
    name = "+git",
    c = { "<Cmd>Telescope git_commits<CR>", "commits" },
    b = { "<Cmd>Telescope git_branches<CR>", "branches" },
    s = { "<Cmd>Telescope git_status<CR>", "status" },
    d = { "<cmd>DiffviewOpen<cr>", "DiffView" },
    h = { name = "+hunk" },
  },
  ["h"] = {
    name = "+help",
    t = { "<cmd>Telescope builtin<cr>", "Telescope" },
    c = { "<cmd>Telescope commands<cr>", "Commands" },
    h = { "<cmd>Telescope help_tags<cr>", "Help Pages" },
    m = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
    k = { "<cmd>Telescope keymaps<cr>", "Key Maps" },
    s = { "<cmd>Telescope highlights<cr>", "Search Highlight Groups" },
    l = { vim.show_pos, "Highlight Groups at cursor" },
    f = { "<cmd>Telescope filetypes<cr>", "File Types" },
    o = { "<cmd>Telescope vim_options<cr>", "Options" },
    a = { "<cmd>Telescope autocommands<cr>", "Auto Commands" },
    p = {
      name = "+packer",
      p = { "<cmd>PackerSync<cr>", "Sync" },
      s = { "<cmd>PackerStatus<cr>", "Status" },
      i = { "<cmd>PackerInstall<cr>", "Install" },
      c = { "<cmd>PackerCompile<cr>", "Compile" },
    },
  },
  s = {
    name = "+search",
    g = { "<cmd>Telescope live_grep<cr>", "Grep" },
    b = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Buffer" },
    h = { "<cmd>Telescope command_history<cr>", "Command History" },
    m = { "<cmd>Telescope marks<cr>", "Jump to Mark" },
    r = { "<cmd>lua require('spectre').open()<CR>", "Replace (Spectre)" },
  },
  f = {
    name = "+file",
    t = { "<cmd>Neotree toggle<cr>", "NeoTree" },
    f = { "<cmd>Telescope find_files<cr>", "Find File" },
    r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
    n = { "<cmd>enew<cr>", "New File" },
    z = "Zoxide",
    d = "Dot Files",
  },
  o = {
    name = "+open",
    p = { "<cmd>Peek<cr>", "Peek (Markdown Preview)" },
    g = { "<cmd>Glow<cr>", "Markdown Glow" },
    n = { "<cmd>lua require('github-notifications.menu').notifications()<cr>", "GitHub Notifications" },
  },
  p = {
    name = "+project",
    p = "Open Project",
    b = { ":Telescope file_browser cwd=~/projects<CR>", "Browse ~/projects" },
  },
  t = {
    name = "toggle",
    s = {
      function()
        util.toggle("spell")
      end,
      "Spelling",
    },
    w = {
      function()
        util.toggle("wrap")
      end,
      "Word Wrap",
    },
    n = {
      function()
        util.toggle("relativenumber", true)
        util.toggle("number")
      end,
      "Line Numbers",
    },
  },
  ["<tab>"] = {
    name = "tabs",
    ["<tab>"] = { "<cmd>tabnew<CR>", "New Tab" },
    n = { "<cmd>tabnext<CR>", "Next" },
    d = { "<cmd>tabclose<CR>", "Close" },
    p = { "<cmd>tabprevious<CR>", "Previous" },
    ["]"] = { "<cmd>tabnext<CR>", "Next" },
    ["["] = { "<cmd>tabprevious<CR>", "Previous" },
    f = { "<cmd>tabfirst<CR>", "First" },
    l = { "<cmd>tablast<CR>", "Last" },
  },
  ["`"] = { "<cmd>:e #<cr>", "Switch to Other Buffer" },
  [" "] = "Find File",
  ["."] = { ":Telescope file_browser<CR>", "Browse Files" },
  [","] = { "<cmd>Telescope buffers show_all_buffers=true<cr>", "Switch Buffer" },
  ["/"] = { "<cmd>Telescope live_grep<cr>", "Search" },
  [":"] = { "<cmd>Telescope command_history<cr>", "Command History" },
  ["C"] = {
    function()
      util.clipman()
    end,
    "Paste from Clipman",
  },
  q = {
    name = "+quit/session",
    q = { "<cmd>qa<cr>", "Quit" },
    ["!"] = { "<cmd>:qa!<cr>", "Quit without saving" },
    s = { [[<cmd>lua require("persistence").load()<cr>]], "Restore Session" },
    l = { [[<cmd>lua require("persistence").load({last=true})<cr>]], "Restore Last Session" },
    d = { [[<cmd>lua require("persistence").stop()<cr>]], "Stop Current Session" },
  },
  x = {
    name = "+errors",
    x = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Trouble" },
    t = { "<cmd>TodoTrouble<cr>", "Todo Trouble" },
    tt = { "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", "Todo Trouble" },
    T = { "<cmd>TodoTelescope<cr>", "Todo Telescope" },
    l = { "<cmd>lopen<cr>", "Open Location List" },
    q = { "<cmd>copen<cr>", "Open Quickfix List" },
  },
  z = { [[<cmd>ZenMode<cr>]], "Zen Mode" },
  T = {
    function()
      util.test(true)
    end,
    "Plenary Test File",
  },
  D = {
    function()
      util.test()
    end,
    "Plenary Test Directory",
  },
}

for i = 0, 10 do
  leader[tostring(i)] = "which_key_ignore"
end

wk.register(leader, { prefix = "<leader>" })

wk.register({ g = { name = "+goto" } })
