-- =============================================================================
-- File        : persistence.lua
-- Author      : yukimemi
-- Last Change : 2025/11/24 23:57:46
-- =============================================================================

require('persistence').setup()

-- load the session for the current directory
vim.keymap.set("n", "<space>qs", function() require("persistence").load() end)

-- select a session to load
vim.keymap.set("n", "<space>qS", function() require("persistence").select() end)

-- load the last session
vim.keymap.set("n", "<space>ql", function() require("persistence").load({ last = true }) end)

-- stop Persistence => session won't be saved on exit
vim.keymap.set("n", "<space>qd", function() require("persistence").stop() end)
