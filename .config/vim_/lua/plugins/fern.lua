return {
  "lambdalisue/fern.vim",

  enabled = vim.g.plugin_use_fern,

  keys = {
    { "ge", "<cmd>Fern . -reveal=% -drawer -width=30<cr>", mode = "n" },
    {
      "gE",
      function()
        vim.cmd(
          string.format("Fern file:///%s -reveal=%s -drawer -width=30", vim.fn.expand("%:p:h"), vim.fn.expand("%:t"))
        )
      end,
      mode = "n",
    },
  },

  dependencies = {
    "lambdalisue/fern-hijack.vim",
    "lambdalisue/fern-git-status.vim",
    "lambdalisue/fern-git.vim",
    "lambdalisue/fern-mapping-git.vim",
    "lambdalisue/fern-bookmark.vim",
    "lambdalisue/fern-comparator-lexical.vim",
    {
      "lambdalisue/fern-renderer-nerdfont.vim",
      dependencies = {
        "lambdalisue/glyph-palette.vim",
        "lambdalisue/nerdfont.vim",
      },
    },
  },

  init = function()
    vim.g.loaded_netrwPlugin = 1
    vim.g["fern#default_hidden"] = 1
    vim.g["fern#renderer"] = "nerdfont"
    vim.g["fern#renderer#nerdfont#indent_makers"] = 1

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "fern",
      callback = function()
        vim.keymap.set("n", "o", function()
          vim.fn["fern#smart#leaf"](
            "<Plug>(fern-action-open)",
            "<Plug>(fern-action-expand)",
            "<Plug>(fern-action-collapse)"
          )
        end, { buffer = true })

        vim.keymap.set("n", "<c-l>", "<c-w>l", { buffer = true })
        vim.keymap.set("n", "S", "<Plug>(fern-action-open:select)", { buffer = true })
        vim.keymap.set("n", "h", "<Plug>(fern-action-leave)", { buffer = true })
        vim.keymap.set("n", "n", "<Nop>", { buffer = true })
        vim.keymap.set("n", "s", "<Nop>", { buffer = true })
      end,
    })
  end,
}
