-- =============================================================================
-- File        : hitori.lua
-- Author      : yukimemi
-- Last Change : 2026/01/11 16:10:04.
-- =============================================================================

vim.g.hitori_debug = false
vim.g.hitori_wsl = true
vim.g.hitori_opener = "edit"
vim.g.hitori_ignore_patterns = {
  ".tmp$",
  ".diff$",
  ".dump$",
  ".jjdescription$",
  "(COMMIT_EDIT|TAG_EDIT|MERGE_|SQUASH_)MSG$",
  "editprompt.md$",
  "gemini-edit-",
}
