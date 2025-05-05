-- =============================================================================
-- File        : deno.lua
-- Author      : yukimemi
-- Last Change : 2025/05/05 20:39:26.
-- =============================================================================

---@type vim.lsp.Config
return {
  root_markers = {
    'deno.json',
    'deno.jsonc',
  },
  workspace_required = true,
  init_options = {
    lint = true,
    unstable = true,
  },
}
