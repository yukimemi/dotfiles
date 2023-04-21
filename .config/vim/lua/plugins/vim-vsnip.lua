return {
  "hrsh7th/vim-vsnip",

  dependencies = {
    "hrsh7th/vim-vsnip-integ",
    "rafamadriz/friendly-snippets",
  },

  config = function()
    vim.cmd([[
    " Expand or jump
    imap <expr> <C-k>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-k>'
    smap <expr> <C-k>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-k>'

    " Jump forward or backward
    imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
    smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
    imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
    smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
    ]])
  end,
}
