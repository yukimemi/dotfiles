// =============================================================================
// File        : cache.ts
// Author      : yukimemi
// Last Change : 2025/01/19 18:26:55.
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

      " https://daisuzu.hatenablog.com/entry/2018/12/13/012608
      command! -bar ToScratch setlocal buftype=nofile bufhidden=hide noswapfile
      command! -nargs=1 -complete=command L <mods> new | ToScratch | call setline(1, split(execute(<q-args>), '\\n'))
      cnoremap <c-c> <home>L <cr>
    `,
    path: "~/.config/nvim/plugin/dvpm_cache.vim",
  };
}

export function cacheLua() {
  return {
    script: `
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

      vim.g.mapleader = " ";
      vim.g.maplocalleader = "\\\\";

      -- Move to window using the <ctrl> movement keys
      vim.keymap.set("n", "<C-h>", "<C-w>h", { silent = true, noremap = true })
      vim.keymap.set("n", "<C-j>", "<C-w>j", { silent = true, noremap = true })
      vim.keymap.set("n", "<C-k>", "<C-w>k", { silent = true, noremap = true })
      vim.keymap.set("n", "<C-l>", "<C-w>l", { silent = true, noremap = true })

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

      vim.keymap.set({"n", "x"}, "H", "H<Plug>(H)")
      vim.keymap.set({"n", "x"}, "L", "L<Plug>(L)")
      vim.keymap.set({"n", "x"}, "<Plug>(H)H", "<PageUp>H<Plug>(H)")
      vim.keymap.set({"n", "x"}, "<Plug>(L)L", "<PageDown>Lzb<Plug>(L)")

    `,
    path: "~/.config/nvim/plugin/dvpm_cache.lua",
  };
}
