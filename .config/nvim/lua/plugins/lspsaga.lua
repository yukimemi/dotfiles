return {
  "glepnir/lspsaga.nvim",
  branch = "main",

  enabled = true,

  event = "BufReadPre",

  dependencies = {
    "neovim/nvim-lspconfig",
  },

  config = function()
    local saga = require('lspsaga')
    saga.init_lsp_saga()

    -- Lsp finder find the symbol definition implement reference
    -- if there is no implement it will hide
    -- when you use action in finder like open vsplit then you can
    -- use <C-t> to jump back
    vim.keymap.set("n", "<space>H", "<cmd>Lspsaga lsp_finder<CR>", { silent = true })

    -- Code action
    vim.keymap.set({ "n", "v" }, "<space>ca", "<cmd>Lspsaga code_action<CR>", { silent = true })

    -- Rename
    vim.keymap.set("n", "<space>rn", "<cmd>Lspsaga rename<CR>", { silent = true })

    -- Peek Definition
    -- you can edit the definition file in this flaotwindow
    -- also support open/vsplit/etc operation check definition_action_keys
    -- support tagstack C-t jump back
    vim.keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", { silent = true })

    -- Show line diagnostics
    vim.keymap.set("n", "<leader>cd", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true })

    -- Show cursor diagnostics
    vim.keymap.set("n", "<leader>cd", "<cmd>Lspsaga show_cursor_diagnostics<CR>", { silent = true })

    -- Diagnostic jump can use `<c-o>` to jump back
    vim.keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true })
    vim.keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true })

    -- Only jump to error
    vim.keymap.set("n", "[e", function()
      require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
    end, { silent = true })
    vim.keymap.set("n", "]e", function()
      require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
    end, { silent = true })

    -- Outline
    vim.keymap.set("n", "<space>o", "<cmd>LSoutlineToggle<CR>", { silent = true })

    -- Hover Doc
    vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true })

    -- Float terminal
    vim.keymap.set("n", "<A-d>", "<cmd>Lspsaga open_floaterm<CR>", { silent = true })

    -- if you want to pass some cli command into a terminal you can do it like this
    -- open lazygit in lspsaga float terminal
    vim.keymap.set("n", "<A-d>", "<cmd>Lspsaga open_floaterm lazygit<CR>", { silent = true })

    -- close floaterm
    vim.keymap.set("t", "<A-d>", [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]], { silent = true })

  end,
}
