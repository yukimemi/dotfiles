import { Plugin } from "./types.ts";

export const ddc: Plugin[] = [
  { org: "Shougo", repo: "ddc-around" },
  { org: "Shougo", repo: "ddc-cmdline" },
  { org: "Shougo", repo: "ddc-cmdline-history" },
  { org: "Shougo", repo: "ddc-nvim-lsp" },
  { org: "Shougo", repo: "ddc-zsh" },
  { org: "Shougo", repo: "pum.vim" },
  { org: "Shougo", repo: "ddc-ui-pum" },
  { org: "LumaKernel", repo: "ddc-file" },
  { org: "tani", repo: "ddc-fuzzy" },
  { org: "matsui54", repo: "ddc-buffer" },

  { org: "hrsh7th", repo: "vim-vsnip" },
  { org: "hrsh7th", repo: "vim-vsnip-integ" },
  { org: "rafamadriz", repo: "friendly-snippets" },
  {
    org: "matsui54",
    repo: "denops-popup-preview.vim",
    lua_post: `vim.fn["popup_preview#enable"]()`,
  },
  {
    org: "matsui54",
    repo: "denops-signature_help",
    lua_post: `
      vim.g.signature_help_config = { contentsStyle = "remainingLabels", viewStyle = "virtual" }
      vim.fn["signature_help#enable"]()
    `,
  },
  {
    org: "Shougo",
    repo: "ddc.vim",
    lua_post: `
      local patch_global = vim.fn["ddc#custom#patch_global"]

      local function complete_or_insert(rel)
        if vim.fn["pum#visible"]() then
          vim.fn["pum#map#insert_relative"](rel)
        else
          return vim.fn["ddc#map#manual_complete"]()
        end
      end

      -- pum
      patch_global("ui", "pum")
      vim.keymap.set(
        "i",
        "<C-n>",
        function() return complete_or_insert(1) end,
        { silent = true, expr = true, replace_keycodes = false }
      )
      vim.keymap.set(
        "i",
        "<C-p>",
        function() return complete_or_insert(-1) end,
        { silent = true, expr = true, replace_keycodes = false }
      )
      vim.keymap.set("i", "<C-y>", function() vim.fn["pum#map#confirm"]() end)
      vim.keymap.set("i", "<C-e>", function() vim.fn["pum#map#cancel"]() end)

      -- sources
      patch_global("sources", { "nvim-lsp", "buffer", "around", "file", "vsnip", "zsh" })
      patch_global("sourceOptions", {
        around = { mark = "A" },
        ["nvim-lsp"] = { mark = "L" },
        file = {
          mark = "F",
          isVolatile = true,
          forceCompletionPattern = [[\S/\S*]],
        },
        buffer = { mark = "B" },
        cmdline = { mark = "CMD" },
        ["cmdline-history"] = { mark = "CMD" },
        zsh = { mark = "Z" },
        ["_"] = {
          matchers = { "matcher_fuzzy" },
          sorters = { "sorter_fuzzy" },
          converters = { "converter_fuzzy" },
        },
      })
      patch_global("sourceParams", {
        around = { maxSize = 500 },
      })

      -- cmdline
      local function commandline_post(maps)
        for lhs, _ in pairs(maps) do
          pcall(vim.keymap.del, "c", lhs)
        end
        if vim.b.prev_buffer_config ~= nil then
          vim.fn["ddc#custom#set_buffer"](vim.b.prev_buffer_config)
          vim.b.prev_buffer_config = nil
        else
          vim.fn["ddc#custom#set_buffer"]({})
        end
      end

      local function commandline_pre()
        local maps = {
          ["<C-n>"] = function() vim.fn["pum#map#insert_relative"](1) end,
          ["<C-p>"] = function() vim.fn["pum#map#insert_relative"](-1) end,
        }
        for lhs, rhs in pairs(maps) do
          vim.keymap.set("c", lhs, rhs)
        end
        if vim.b.prev_buffer_config == nil then
          -- Overwrite sources
          vim.b.prev_buffer_config = vim.fn["ddc#custom#get_buffer"]()
        end
        vim.fn["ddc#custom#patch_buffer"]("cmdlineSources", { "cmdline", "cmdline-history", "file", "around" })
        vim.api.nvim_create_autocmd("User", {
          pattern = "DDCCmdLineLeave",
          once = true,
          callback = function() pcall(commandline_post, maps) end,
        })
        vim.api.nvim_create_autocmd("InsertEnter", {
          once = true,
          buffer = 0,
          callback = function() pcall(commandline_post, maps) end,
        })

        -- Enable command line completion
        vim.fn["ddc#enable_cmdline_completion"]()
      end

      vim.keymap.set("n", ":", function()
        commandline_pre()
        return ":"
      end, { expr = true, remap = true })
      patch_global(
        "autoCompleteEvents",
        { "InsertEnter", "TextChangedI", "TextChangedP", "CmdlineEnter", "CmdlineChanged" }
      )
      patch_global("cmdlineSources", { "cmdline", "cmdline-history", "file", "around" })

      -- enable
      vim.fn["ddc#enable"]()
    `,
  },
];
