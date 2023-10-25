// =============================================================================
// File        : cache.ts
// Author      : yukimemi
// Last Change : 2023/08/25 22:15:10.
// =============================================================================

export function cacheVim() {
  return {
    script: `
      augroup MyAutoCmd | autocmd! | augroup END
      if !v:vim_did_enter && has('reltime')
        let s:startuptime = reltime()
        au MyAutoCmd VimEnter * ++once let s:startuptime = reltime(s:startuptime) | redraw
              \\ | echomsg 'startuptime: ' .. reltimestr(s:startuptime)
      endif
      au MyAutoCmd SwapExists * let v:swapchoice = 'o'
    `,
    path: "~/.config/nvim/plugin/dvpm_cache.vim",
  };
}

export function cacheLua() {
  return {
    script: `
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
    `,
    path: "~/.config/nvim/plugin/dvpm_cache.lua",
  };
}
