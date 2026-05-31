-- =============================================================================
-- File        : after.lua
-- Author      : yukimemi
-- Last Change : 2026/05/31 00:00:00.
-- =============================================================================

require("chronicle").setup({
  notify = true,
  -- Keep the existing history location so prior entries (and
  -- snacks-source-chronicle) carry over unchanged.
  read_path = "~/.cache/chronicle/read",
  write_path = "~/.cache/chronicle/write",
})
