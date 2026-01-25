-- =============================================================================
-- File        : megatoggler.lua
-- Author      : yukimemi
-- Last Change : 2025/09/27 13:58:07.
-- =============================================================================

require("megatoggler").setup({
  tabs = {
    {
      -- global options you might want to persist
      id = "Globals",
      items = {
        {
          id = "Ignore Case",
          -- all items must define a get method
          get = function() return vim.o.ignorecase end,
          -- items with boolean value must define on_toggle
          on_toggle = function(on) vim.o.ignorecase = on end,
        },
        {
          id = "Tabstop",
          label = "Tab Stop", -- optional label
          desc = "Tab size",  -- optional description
          get = function()
            -- use opt_global for vim options you want to persist
            return vim.opt_global.tabstop:get()
          end,
          -- items with numeric/string value must define on_set
          on_set = function(v)
            vim.opt_global.tabstop = v
          end,
          -- size of the textbox when editing
          edit_size = 3
        },
        {
          id = "Expand Tab",
          get = function() return vim.opt_global.expandtab:get() end,
          on_toggle = function(on) vim.opt_global.expandtab = on end,
        },
        {
          id = "Inc Command",
          get = function() return vim.o.inccommand end,
          on_set = function(v) vim.o.inccommand = v end,
          edit_size = 10
        },
      }
    },
    {
      -- local options you might want to toggle but not persist
      id = "Local",
      items = {
        {
          id = 'Tabstop',
          -- disable persistence for buffer-local options
          persist = false,
          get = function() return vim.bo.tabstop end,
          on_set = function(v) vim.bo.tabstop = v end
        }
      }
    },
    {
      -- toggle features provided by other plugins
      id = "Features",
      items = {
      }
    }
  }
})
