-- =============================================================================
-- File        : nvim-lspconfig.lua
-- Author      : yukimemi
-- Last Change : 2024/05/15 10:48:29.
-- =============================================================================

require("mason").setup({
  providers = {
    "mason.providers.client",
    "mason.providers.registry-api",
  },
})
require("mason-lspconfig").setup()
-- require("lsp-format").setup()
-- require("lsp_lines").setup()
vim.diagnostic.config({
  virtual_text = true,
  -- virtual_lines = { only_current_line = true },
})
local lspconfig = require("lspconfig")

local function on_attach(client, bufnr)
  require("nvim-navic").attach(client, bufnr)
  require("lsp").on_attach(client, bufnr)
end

-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- local capabilities = require("cmp_nvim_lsp").default_capabilities()
-- local capabilities = require("ddc_source_lsp").make_client_capabilities()
-- capabilities.textDocument.foldingRange = {
--   dynamicRegistration = false,
--   lineFoldingOnly = true,
-- }

local options = {
  on_attach = on_attach,
  -- capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
}

require("mason-lspconfig").setup_handlers({
  function(server_name) -- default handler
    lspconfig[server_name].setup(options)
  end,
  efm = function()
    lspconfig["efm"].setup(vim.tbl_deep_extend("force", options, {
      init_options = {
        documentFormatting = true,
        documentRangeFormatting = true,
      },
      settings = {
        rootMarkers = {
          ".git/",
        },
        languages = {
          lua = {
            {
              formatCommand = "stylua --color Never --config-path ~/.config/.stylua.toml -",
            },
            {
              lintCommand = "luacheck --no-color --quiet --config ~/.config/.luacheckrc -",
              lintFormats = {
                "%f:%l:%c: %m",
              }
            }
          }
        }
      },
      filetypes = {
        "lua",
      }
    }))
  end,
  denols = function()
    lspconfig["denols"].setup(vim.tbl_deep_extend("force", options, {
      root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
      init_options = {
        lint = true,
        unstable = true,
        suggest = {
          imports = {
            hosts = {
              ["https://deno.land"] = true,
              ["https://cdn.nest.land"] = true,
              ["https://crux.land"] = true,
            },
          },
        },
      },
    }))
  end,
  tsserver = function()
    lspconfig["tsserver"].setup(vim.tbl_deep_extend("force", options, {
      root_dir = lspconfig.util.root_pattern("package.json"),
      single_file_support = false,
    }))
  end,
  vtsls = function()
    lspconfig["vtsls"].setup(vim.tbl_deep_extend("force", options, {
      root_dir = lspconfig.util.root_pattern("package.json"),
      single_file_support = false,
    }))
  end,
  ["powershell_es"] = function()
    lspconfig["powershell_es"].setup(vim.tbl_deep_extend("force", options, {
      settings = {
        powershell = {
          single_file_support = true,
          codeFormatting = {
            preset = "OTBS",
            ignoreOneLineBlock = false,
            useCorrectCasing = true,
          },
        },
      },
    }))
  end,
  ["lemminx"] = function()
    lspconfig["lemminx"].setup(vim.tbl_deep_extend("force", options, {
      settings = {
        xml = {
          format = {
            enabled = true,
            formatComments = true,
            joinCDATALines = false,
            joinCommentLines = false,
            joinContentLines = false,
            spaceBeforeEmptyCloseTag = true,
            splitAttributes = true,
          },
          completion = {
            autoCloseTags = true,
          },
        },
      },
    }))
  end,
  ["rust_analyzer"] = function()
    -- Use rustaceanvim instead
  end,
  ["lua_ls"] = function()
    lspconfig["lua_ls"].setup(vim.tbl_deep_extend("force", options, {
      single_file_support = true,
      settings = {
        Lua = {
          workspace = {
            checkThirdParty = false,
          },
          completion = {
            workspaceWord = true,
            callSnippet = "Both",
          },
          diagnostics = {
            -- enable = false,
            -- globals = { 'vim' },
            groupSeverity = {
              strong = "Warning",
              strict = "Warning",
            },
            groupFileStatus = {
              ["ambiguity"] = "Opened",
              ["await"] = "Opened",
              ["codestyle"] = "None",
              ["duplicate"] = "Opened",
              ["global"] = "Opened",
              ["luadoc"] = "Opened",
              ["redefined"] = "Opened",
              ["strict"] = "Opened",
              ["strong"] = "Opened",
              ["type-check"] = "Opened",
              ["unbalanced"] = "Opened",
              ["unused"] = "Opened",
            },
            unusedLocalExclude = { "_*" },
          },
          format = {
            enable = true,
            defaultConfig = {
              indent_style = "space",
              indent_size = "2",
              continuation_indent_size = "2",
            },
          },
        },
      },
    }))
  end,
  bicep = function()
    lspconfig["bicep"].setup(vim.tbl_deep_extend("force", options, {
      single_file_support = true,
    }))
  end,
})
