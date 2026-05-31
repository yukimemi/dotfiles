-- =============================================================================
-- File        : after.lua
-- Author      : yukimemi
-- Last Change : 2026/05/31 00:00:00.
-- =============================================================================

local from_vscode = require("luasnip.loaders.from_vscode")

-- friendly-snippets (and any other VSCode-format snippets on the runtimepath).
from_vscode.lazy_load()

-- Personal snippets, converted from the old denippet .toml/.json into valid
-- VSCode JSON (see ~/.config/nvim/snippets/package.json).
from_vscode.lazy_load({ paths = { vim.fn.stdpath("config") .. "/snippets" } })
