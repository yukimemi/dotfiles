// =============================================================================
// File        : cache.ts
// Author      : yukimemi
// Last Change : 2024/05/03 08:53:56.
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
    path: "~/.cache/nvim/dvpm/cache/plugin/dvpm_cache.vim",
  };
}

export function cacheLua() {
  return {
    script: `
      -- options.
      vim.o.fileencodings = "ucs-bom,utf-8,iso-2022-jp,euc-jp,cp932,latin1"
      vim.o.fileformats = "unix,dos,mac"
      vim.o.clipboard = "unnamedplus";

      -- Move to window using the <ctrl> movement keys
      vim.keymap.set("n", "<C-h>", "<C-w>h", { silent = true })
      vim.keymap.set("n", "<C-j>", "<C-w>j", { silent = true })
      vim.keymap.set("n", "<C-k>", "<C-w>k", { silent = true })
      vim.keymap.set("n", "<C-l>", "<C-w>l", { silent = true })

      vim.keymap.set("n", "<space><space>", "<cmd>update<cr>", { silent = true })
      vim.keymap.set("n", "<tab>", "%", { silent = true })
      vim.keymap.set("i", "<c-l>", "<C-g>U<Right>", { silent = true })

      vim.keymap.set({ "n", "x" }, "gh", "^", { silent = true })
      vim.keymap.set({ "n", "x" }, "gl", "$", { silent = true })

      vim.keymap.set("c", "<c-b>", "<Left>", { silent = true })
      vim.keymap.set("c", "<c-f>", "<Right>", { silent = true })
      vim.keymap.set("c", "<c-a>", "<Home>", { silent = true })
      vim.keymap.set("c", "<c-e>", "<End>", { silent = true })
      vim.keymap.set("c", "<c-d>", "<Del>", { silent = true })
      vim.keymap.set("c", "<c-y>", "<c-r>", { silent = true })
      vim.keymap.set("c", "<c-p>", "<Up>", { silent = true })
      vim.keymap.set("c", "<c-n>", "<Down>", { silent = true })

      -- s prefix mappings
      vim.keymap.set("n", "s", "<Nop>", { silent = true })
      vim.keymap.set("n", "s0", "<cmd>only<cr>", { silent = true })
      vim.keymap.set("n", "s=", "<c-w>=", { silent = true })
      vim.keymap.set("n", "sH", "<c-w>H", { silent = true })
      vim.keymap.set("n", "sJ", "<c-w>J", { silent = true })
      vim.keymap.set("n", "sK", "<c-w>K", { silent = true })
      vim.keymap.set("n", "sL", "<c-w>L", { silent = true })
      vim.keymap.set("n", "sO", "<cmd>tabonly<cr>", { silent = true })
      vim.keymap.set("n", "sQ", "<cmd>qa<cr>", { silent = true })
      vim.keymap.set("n", "sbk", "<cmd>bd!<cr>", { silent = true })
      vim.keymap.set("n", "sbq", "<cmd>q!<cr>", { silent = true })
      vim.keymap.set("n", "sn", "<cmd>bn<cr>", { silent = true })
      vim.keymap.set("n", "so", "<c-w>_<c-w>|", { silent = true })
      vim.keymap.set("n", "sp", "<cmd>bp<cr>", { silent = true })
      vim.keymap.set("n", "sq", "<cmd>q<cr>", { silent = true })
      vim.keymap.set("n", "sr", "<c-w>r", { silent = true })
      vim.keymap.set("n", "sh", "<cmd>sp<cr>", { silent = true })
      vim.keymap.set("n", "st", "<cmd>tabnew<cr>", { silent = true })
      vim.keymap.set("n", "sv", "<cmd>vs<cr>", { silent = true })
      vim.keymap.set("n", "sw", "<c-w>w", { silent = true })

    `,
    path: "~/.cache/nvim/dvpm/cache/plugin/dvpm_cache.lua",
  };
}
