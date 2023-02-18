return {
  "monaqa/modesearch.nvim",

  enabled = false,

  dependencies = {
    "vim-denops/denops.vim",
    "lambdalisue/kensaku.vim",
  },

  event = "VeryLazy",

  config = function()
    require("modesearch").setup({
      modes = {
        rawstr = {
          prompt = "[rawstr]/",
          converter = function(query)
            return [[\V]] .. vim.fn.escape(query, [[/\]])
          end,
        },
        regexp = {
          prompt = "[regexp]/",
          converter = function(query)
            return [[\v]] .. vim.fn.escape(query, [[/]])
          end,
        },
        migemo = {
          prompt = "[migemo]/",
          converter = function(query)
            return [[\v]] .. vim.fn["kensaku#query"](query)
          end,
        },
      },
    })

    vim.keymap.set("n", "/", function()
      return require("modesearch").keymap.prompt.show("rawstr")
    end, { expr = true })

    vim.keymap.set("c", "<c-x>", function()
      return require("modesearch").keymap.mode.cycle({ "rawstr", "migemo", "regexp" })
    end, { expr = true })
  end,
}
