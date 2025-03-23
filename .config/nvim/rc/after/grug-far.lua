-- =============================================================================
-- File        : grug-far.lua
-- Author      : yukimemi
-- Last Change : 2025/03/24 01:16:31.
-- =============================================================================

require("grug-far").setup({
  engines = {
    ripgrep = {
      extraArgs = '-i --hidden --no-ignore --glob "!**/node_modules/**" --glob "!**/.git/**"',
    },
  }
})

