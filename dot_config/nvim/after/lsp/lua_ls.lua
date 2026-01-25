-- =============================================================================
-- File        : lua_ls.lua
-- Author      : yukimemi
-- Last Change : 2025/05/05 20:40:58.
-- =============================================================================

---@type vim.lsp.Config
return {
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
    },
  },
}
