-- Startup time
local startup_start_time = vim.fn.reltime()
local startup_timer_augroup = vim.api.nvim_create_augroup("MyStartupTime", { clear = true })
vim.api.nvim_create_autocmd("VimEnter", {
	group = startup_timer_augroup,
	once = true,
	callback = function()
		local elapsed_time = vim.fn.reltime(startup_start_time)
		local time_str = vim.fn.reltimestr(elapsed_time)
		vim.notify('🚀  Neovim startup time:' .. time_str, vim.log.levels.INFO, { title = "Startup Timer" })
	end,
})

-- augroup MyAutoCmd
local myautocmd = vim.api.nvim_create_augroup("MyAutoCmd", { clear = true })

-- SwapExists
vim.api.nvim_create_autocmd("SwapExists", {
	group = myautocmd,
	pattern = "*",
	callback = function()
		vim.v.swapchoice = "o"
	end,
})

-- :ToScratch
vim.api.nvim_create_user_command("ToScratch", function()
	vim.bo.buftype = "nofile"
	vim.bo.bufhidden = "hide"
	vim.bo.swapfile = false
end, { bar = true })

-- :L {command}
vim.api.nvim_create_user_command("L", function(opts)
	vim.cmd(opts.smods.split .. " new")
	vim.cmd("ToScratch")
	local output = vim.split(vim.api.nvim_exec2(opts.args, { output = true }).output, "\n")
	vim.api.nvim_buf_set_lines(0, 0, -1, false, output)
end, { nargs = 1, complete = "command" })

-- cnoremap <C-c> <Home>L <CR>
vim.keymap.set("c", "<C-c>", "<Home>L <CR>")

-- nnoremap <expr>l  foldclosed('.') != -1 ? 'zo' : 'l'
vim.keymap.set("n", "l", function()
	if vim.fn.foldclosed(".") ~= -1 then
		return "zo"
	else
		return "l"
	end
end, { expr = true })

-- nnoremap <silent>z- zMzvzc
vim.keymap.set("n", "z-", "zMzvzc", { silent = true })

-- nnoremap <silent>z0
vim.keymap.set("n", "z0", function()
	vim.wo.foldlevel = vim.fn.foldlevel(".")
end, { silent = true })

-- nnoremap <silent>- smart_foldcloser
vim.keymap.set("n", "-", function()
	if vim.fn.foldlevel(".") == 0 then
		vim.cmd("normal! zM")
		return
	end
	local foldc_lnum = vim.fn.foldclosed(".")
	vim.cmd("normal! zc")
	if foldc_lnum == -1 then
		return
	end
	if vim.fn.foldclosed(".") ~= foldc_lnum then
		return
	end
	vim.cmd("normal! zM")
end, { silent = true })

-- Monkeypatch for vim.lsp.util.make_position_params
local orig_make_position_params = vim.lsp.util.make_position_params
vim.lsp.util.make_position_params = function(win, encoding)
	return orig_make_position_params(win, encoding or "utf-16")
end

-- Disable default plugins
vim.g.loaded_2html_plugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_man = 1
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_remote_plugins = 1
vim.g.loaded_shada_plugin = 1
vim.g.loaded_spellfile_plugin = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_tutor_mode_plugin = 1
vim.g.loaded_zipPlugin = 1

-- options.
vim.o.fileencodings = "ucs-bom,utf-8,iso-2022-jp,euc-jp,cp932,latin1"
vim.o.fileformats = "unix,dos,mac"
vim.o.clipboard = "unnamedplus";
if vim.fn.has("win32") == 1 then
	vim.g.clipboard = {
		name = 'win32yank',
		copy = {
			['+'] = 'win32yank.exe -i --crlf',
			['*'] = 'win32yank.exe -i --crlf',
		},
		paste = {
			['+'] = 'win32yank.exe -o --lf',
			['*'] = 'win32yank.exe -o --lf',
		},
		cache_enabled = 0,
	}
end
vim.o.ignorecase = true
vim.o.smartcase = true
if vim.fn.has("win32") == 1 then
	vim.o.shell = "pwsh.exe"
	vim.o.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
	vim.o.shellredir = "2>&1 | Out-File -Encoding UTF8 %s; if ($?) { exit 0 } else { exit 1 }"
	vim.o.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; if ($?) { exit 0 } else { exit 1 }"
	vim.o.shellquote = ""
	vim.o.shellxquote = ""
else
	vim.o.shell = "pwsh"
end

vim.g.mapleader = " ";
vim.g.maplocalleader = "\\";

-- Move to window using the <ctrl> movement keys
local function tmux_move(direction)
	local winnr = vim.api.nvim_get_current_win()
	vim.cmd("wincmd " .. direction)
	if winnr == vim.api.nvim_get_current_win() then
		if vim.env.ZELLIJ or vim.env.ZELLIJ_PANE_ID then
			local zellij_direction = ""
			if direction == "h" then zellij_direction = "left" end
			if direction == "j" then zellij_direction = "down" end
			if direction == "k" then zellij_direction = "up" end
			if direction == "l" then zellij_direction = "right" end
			local cmd = "zellij"
			if vim.fn.executable(cmd) == 0 and vim.fn.executable(cmd .. ".exe") == 1 then
				cmd = cmd .. ".exe"
			end
			local output = vim.fn.system(cmd .. " action move-focus " .. zellij_direction)
			if vim.v.shell_error ~= 0 then
				vim.notify("Zellij move failed: " .. output, vim.log.levels.ERROR)
			end
		else
			local tmux_pane_direction = ""
			if direction == "h" then tmux_pane_direction = "-L" end
			if direction == "j" then tmux_pane_direction = "-D" end
			if direction == "k" then tmux_pane_direction = "-U" end
			if direction == "l" then tmux_pane_direction = "-R" end
			if tmux_pane_direction ~= "" then
				local cmd = vim.env.PSMUX or vim.env.TMUX
				if cmd then
					local tmux_cmd = vim.env.PSMUX and "psmux" or "tmux"
					vim.fn.system(tmux_cmd .. " select-pane " .. tmux_pane_direction)
				end
			end
		end
	end
end

vim.keymap.set({"n", "t"}, "<C-h>", function() tmux_move("h") end, { silent = true, noremap = true })
vim.keymap.set({"n", "t"}, "<C-j>", function() tmux_move("j") end, { silent = true, noremap = true })
vim.keymap.set({"n", "t"}, "<C-k>", function() tmux_move("k") end, { silent = true, noremap = true })
vim.keymap.set({"n", "t"}, "<C-l>", function() tmux_move("l") end, { silent = true, noremap = true })

vim.keymap.set("n", "<space><space>", "<cmd>update<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<tab>", "%", { silent = true, noremap = true })
vim.keymap.set("i", "<c-l>", "<C-g>U<Right>", { silent = true, noremap = true })

vim.keymap.set({ "n", "x" }, "gh", "^", { silent = true, noremap = true })
vim.keymap.set({ "n", "x" }, "gl", "$", { silent = true, noremap = true })

vim.keymap.set("c", "<c-b>", "<Left>", { silent = true, noremap = true })
vim.keymap.set("c", "<c-f>", "<Right>", { silent = true, noremap = true })
vim.keymap.set("c", "<c-a>", "<Home>", { silent = true, noremap = true })
vim.keymap.set("c", "<c-e>", "<End>", { silent = true, noremap = true })
vim.keymap.set("c", "<c-d>", "<Del>", { silent = true, noremap = true })
vim.keymap.set("c", "<c-y>", "<c-r>", { silent = true, noremap = true })
vim.keymap.set("c", "<c-p>", "<Up>", { silent = true, noremap = true })
vim.keymap.set("c", "<c-n>", "<Down>", { silent = true, noremap = true })

-- s prefix mappings
vim.keymap.set("n", "s", "<Nop>", { silent = true, noremap = true })
vim.keymap.set("n", "s0", "<cmd>only<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "s=", "<c-w>=", { silent = true, noremap = true })
vim.keymap.set("n", "sH", "<c-w>H", { silent = true, noremap = true })
vim.keymap.set("n", "sJ", "<c-w>J", { silent = true, noremap = true })
vim.keymap.set("n", "sK", "<c-w>K", { silent = true, noremap = true })
vim.keymap.set("n", "sL", "<c-w>L", { silent = true, noremap = true })
vim.keymap.set("n", "sO", "<cmd>tabonly<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "sQ", "<cmd>qa<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "sbk", "<cmd>bd!<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "sbq", "<cmd>q!<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "sn", "<cmd>bn<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "so", "<c-w>_<c-w>|", { silent = true, noremap = true })
vim.keymap.set("n", "sp", "<cmd>bp<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "sq", "<cmd>q<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "sr", "<c-w>r", { silent = true, noremap = true })
vim.keymap.set("n", "sh", "<cmd>sp<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "st", "<cmd>tabnew<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "sv", "<cmd>vs<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "sw", "<c-w>w", { silent = true, noremap = true })

local ok, extui = pcall(require, 'vim._extui')
if ok and extui then
	-- Disable extui. use noice.nvim
	-- pcall(extui.enable, {})
end
