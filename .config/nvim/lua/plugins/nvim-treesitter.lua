local M = {
  "nvim-treesitter/nvim-treesitter",

  enabled = true,
  build = ":TSUpdate",
  event = "BufReadPost",

  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    "RRethy/nvim-treesitter-textsubjects",
    "nvim-treesitter/nvim-treesitter-refactor",
    "mfussenegger/nvim-treehopper",
    { "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },
    {
      "nvim-treesitter/nvim-treesitter-context",
      event = "BufReadPre",
      config = function()
        require("treesitter-context").setup()
      end,
    }
  },
}

function M.init()
  vim.cmd([[
  omap     <silent> m :<C-U>lua require('tsht').nodes()<CR>
  xnoremap <silent> m :lua require('tsht').nodes()<CR>
  ]])
end

function M.config()
  require("nvim-treesitter.configs").setup({
    ensure_installed = {
      "lua",
      "markdown",
    },
    sync_install = false,
    auto_install = false,
    highlight = {
      enable = true,
      disable = function(lang)
        local ok = pcall(function()
          vim.treesitter.get_query(lang, 'highlights')
        end)
        return not ok
      end,
    },
    indent = { enable = false },
    context_commentstring = { enable = true, enable_autocmd = false },
    playground = {
      enable = true,
      disable = {},
      updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
      persist_queries = true, -- Whether the query persists across vim sessions
      keybindings = {
        toggle_query_editor = "o",
        toggle_hl_groups = "i",
        toggle_injected_languages = "t",
        toggle_anonymous_nodes = "a",
        toggle_language_display = "I",
        focus_language = "f",
        unfocus_language = "F",
        update = "R",
        goto_node = "<cr>",
        show_help = "?",
      },
    },
    textobjects = {
      select = {
        enable = false,
        lookahead = true,
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
        },
      },
      move = {
        enable = false,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
        goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer" },
        goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
        goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer" },
      },
      lsp_interop = {
        enable = false,
        peek_definition_code = {
          ["gD"] = "@function.outer",
        },
      },
    },
  })
  local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
  parser_config.markdown.filetype_to_parsername = "octo"
end

return M
