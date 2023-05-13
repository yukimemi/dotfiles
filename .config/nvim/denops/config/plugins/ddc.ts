import { Plugin } from "./types.ts";

export const ddc: Plugin[] = [
  {
    org: "Shougo",
    repo: "pum.vim",
    lua_post: `
      vim.fn["pum#set_option"]("border", "single")
      -- vim.fn["pum#set_option"]("horizontal_menu", false)
      vim.fn["pum#set_option"]("max_height", 30)
      vim.fn["pum#set_option"]("max_width", 100)
      vim.fn["pum#set_option"]("min_width", 3)
      vim.fn["pum#set_option"]("padding", false)
      vim.fn["pum#set_option"]("scrollbar_char", "")
      vim.fn["pum#set_option"]("use_complete", false)
      vim.fn["pum#set_option"]("use_setline", false)
    `,
  },
  // ui
  { org: "Shougo", repo: "ddc-ui-pum" },
  { org: "Shougo", repo: "ddc-ui-inline" },
  // matcher
  { org: "tani", repo: "ddc-fuzzy" },
  // source
  { org: "LumaKernel", repo: "ddc-file" },
  { org: "LumaKernel", repo: "ddc-run" },
  { org: "Shougo", repo: "ddc-source-around" },
  { org: "Shougo", repo: "ddc-source-cmdline" },
  { org: "Shougo", repo: "ddc-source-codeium" },
  { org: "Shougo", repo: "ddc-source-input" },
  { org: "Shougo", repo: "ddc-source-line" },
  { org: "Shougo", repo: "ddc-source-rg" },
  { org: "Shougo", repo: "ddc-source-cmdline-history" },
  { org: "Shougo", repo: "ddc-source-nvim-lsp" },
  { org: "matsui54", repo: "ddc-buffer" },
  // snippets
  { org: "hrsh7th", repo: "vim-vsnip" },
  { org: "hrsh7th", repo: "vim-vsnip-integ" },
  { org: "rafamadriz", repo: "friendly-snippets" },
  {
    org: "matsui54",
    repo: "denops-popup-preview.vim",
    lua_post: `
      vim.g.popup_preview_config = {
        delay = 50,
        border = true,
        supportVsnip = true,
      }
      vim.fn["popup_preview#enable"]()
    `,
  },
  {
    org: "matsui54",
    repo: "denops-signature_help",
    lua_post: `
      -- vim.g.signature_help_config = { contentsStyle = "remainingLabels", viewStyle = "virtual" }
      vim.fn["signature_help#enable"]()
    `,
  },
  {
    org: "Shougo",
    repo: "ddc.vim",
    lua_post: `
      local function complete_or_insert(rel)
        if vim.fn["pum#visible"]() then
          vim.fn["pum#map#insert_relative"](rel)
        else
          return vim.fn["ddc#map#manual_complete"]()
        end
      end

      local function cmdline_post()
        if vim.fn.exists "b:prev_buffer_config" then
          local vimx = require "artemis"
          vim.fn["ddc#custom#set_buffer"](vimx.b.prev_buffer_config)
        else
          vim.fn["ddc#custom#set_buffer"]()
        end
      end

      local function cmdline_pre(mode)
        if vim.fn.exists "b:prev_buffer_config" then
          local vimx = require "artemis"
          vimx.b.prev_buffer_config = vim.fn["ddc#custom#get_buffer"]()
        end
        if mode == ":" then vim.fn["ddc#custom#patch_buffer"]("keywordPattern", "[0-9a-zA-Z_:#-]*") end
        vim.api.nvim_create_autocmd("User", {
          pattern = "DDCCmdlineLeave",
          once = true,
          callback = cmdline_post,
        })
      end

      local patch_global = {
        ui = "pum",
        autoCompleteEvents = {
          "InsertEnter",
          "TextChangedI",
          "TextChangedP",
          "CmdlineEnter",
          "CmdlineChanged",
          "TextChangedT",
        },
        sources = {
          "nvim-lsp",
          "around",
          "vsnip",
          "file",
          "rg",
          "codeium",
        },
        cmdlineSources = {
          [":"] = { "cmdline", "cmdline-history", "around", "file" },
          ["@"] = { "cmdline-history", "input", "file", "around" },
          [">"] = { "cmdline-history", "input", "file", "around" },
          ["-"] = { "around", "line" },
          ["="] = { "input" },
        },
        sourceOptions = {
          ["_"] = {
            ignoreCase = true,
            matchers = { "matcher_fuzzy" },
            sorters = { "sorter_fuzzy" },
            converters = { "converter_fuzzy" },
          },
          around = {
            mark = "around",
          },
          buffer = { mark = "buffer" },
          plantuml = { mark = "uml" },
          cmdline = {
            mark = "cmdline",
            forceCompletionPattern = "S/S*|.w*",
            dup = "force",
          },
          codeium = {
            mark = "cod",
            minAutoCompleteLength = 0,
            isVolatile = true,
          },
          input = {
            mark = "input",
            forceCompletionPattern = "S/S*",
            isVolatile = true,
            dup = "force",
          },
          line = {
            mark = "line",
          },
          mocword = {
            mark = "word",
            minAutoCompleteLength = 3,
            isVolatile = true,
          },
          ["nvim-lsp"] = {
            mark = "lsp",
            forceCompletionPattern = ".w*|=w*|->w*",
            dup = "force",
          },
          file = {
            mark = "file",
            isVolatile = true,
            forceCompletionPattern = [[\\S/\\S*]],
          },
          ["cmdline-history"] = { mark = "cmdhist", sorters = {} },
          rg = {
            mark = "rg",
            minAutoCompleteLength = 3,
            enabledIf = "finddir('.git', ';') != ''",
          },
          ["windows-clipboard-history"] = {
            mark = "clip",
          },
        },
        sourceParams = {
          buffer = {
            requireSameFiletype = false,
            limitBytes = 50000,
            fromAltBuf = true,
            forceCollect = true,
          },
          file = {
            filenameChars = "[:keyword:].",
          },
        },
      }

      local patch_filetype = {
        plantuml = {
          sources = { "plantuml", "nvim-lsp", "around", "vsnip", "file", "rg"},
        },
        ["ddu-ff-filter"] = {
          keywordPattern = "[0-9a-zA-Z_:#-]*",
          sources = { "line", "buffer" },
          specialBufferCompletion = true,
        },
        FineCmdlinePrompt = {
          keywordPattern = "[0-9a-zA-Z_:#-]*",
          sources = { "cmdline-history", "around" },
          specialBufferCompletion = true,
        },
      }

      -- Insert mode mappings.
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
      vim.keymap.set("i", "<c-k>", function() vim.fn["pum#map#extend"](vim.fn["pum#map#confirm"]) end, { expr = true })
      vim.keymap.set("i", "<c-space>", function() vim.fn["ddc#map#manual_complete"]() end)
      vim.keymap.set("i", "<C-y>", function() vim.fn["pum#map#confirm"]() end)
      vim.keymap.set("i", "<C-e>", function() vim.fn["pum#map#cancel"]() end)

      -- Normal mode mappings.
      vim.keymap.set({"n", "x"}, ":", function()
        cmdline_pre()
        return ":"
      end, { expr = true, remap = true })

      -- Command line mode mappings.
      vim.keymap.set("c", "<tab>", function()
        if vim.fn.wildmenumode() > 0 then
          return vim.fn.nr2char(vim.o.wildcharm)
        else
          if vim.fn["pum#visible"]() then
            return vim.fn["pum#map#insert_relative"](1)
          else
            return vim.fn["ddc#map#manual_complete"]()
          end
        end
      end, { expr = true })
      vim.keymap.set("c", "<s-tab>", function() return vim.fn["pum#map#insert_relative"](-1) end, { expr = true })

      -- Configure.
      vim.fn["ddc#custom#patch_global"](patch_global)
      for k, v in pairs(patch_filetype) do
        vim.fn["ddc#custom#patch_filetype"](k, v)
      end
      vim.fn["ddc#enable"]()
    `,
  },
];
