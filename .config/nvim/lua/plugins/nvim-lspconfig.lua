local M = {
  "neovim/nvim-lspconfig",

  enabled = true,

  event = "BufReadPre",

  dependencies = {
    "SmiteshP/nvim-navic",
    "lukas-reineke/lsp-format.nvim",
    "jose-elias-alvarez/null-ls.nvim",
    {
      "williamboman/mason.nvim",
      cmd = "Mason",
    },
    "williamboman/mason-lspconfig.nvim",
    {
      "hrsh7th/cmp-nvim-lsp",
      enabled = vim.g.plugin_use_cmp,
    },
    {
      "Maan2003/lsp_lines.nvim",
      enabled = false,
      config = function()
        require("lsp_lines").setup()
        vim.diagnostic.config({
          virtual_text = false,
          virtual_lines = { only_current_line = true },
        })
      end,
    },
    {
      "folke/neodev.nvim",
      config = function()
        require("neodev").setup()
      end,
    },
    {
      "folke/neoconf.nvim",
      cmd = "Neoconf",
      config = function()
        require("neoconf").setup()
      end,
    },
  },
}

function M.config()
  -- vim.api.nvim_create_autocmd("LspAttach", {
  --   once = true,
  --   callback = function()
  --     vim.lsp.handlers["textDocument/hover"] = function(_, results, ctx, config)
  --       local client = vim.lsp.get_client_by_id(ctx.client_id)
  --       vim.lsp.handlers.hover(
  --         _,
  --         results,
  --         ctx,
  --         vim.tbl_deep_extend("force", config or {}, {
  --           border = "single",
  --           title = client.name,
  --         })
  --       )
  --     end
  --   end,
  -- })
  vim.diagnostic.config {
    virtual_text = {
      source = "always",
    },
    float = {
      source = "always",
      format = function(diag)
        if diag.code then
          return string.format("[%s](%s): %s", diag.source, diag.code, diag.message)
        else
          return string.format("[%s]: %s", diag.source, diag.message)
        end
      end,
    },
  }
  require("mason").setup({
    providers = {
      "mason.providers.client",
      "mason.providers.registry-api",
    },
  })
  require("mason-lspconfig").setup()
  require("lsp-format").setup({
    xml = {
      excludee = { "lemminx" },
    },
  })
  local lspconfig = require("lspconfig")

  local function on_attach(client, bufnr)
    require("nvim-navic").attach(client, bufnr)
    require("lsp-format").on_attach(client, bufnr)

    local opts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set(
      "n",
      "<space>e",
      vim.diagnostic.open_float,
      vim.tbl_extend("force", opts, { desc = "Open diagnostic on float" })
    )
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, vim.tbl_extend("force", opts, { desc = "Diagnostic prev" }))
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, vim.tbl_extend("force", opts, { desc = "Diagnostic next" }))
    vim.keymap.set(
      "n",
      "<space>q",
      vim.diagnostic.setloclist,
      vim.tbl_extend("force", opts, { desc = "Diagnostic to loclist" })
    )
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, { desc = "Declaration" }))
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Definition" }))
    vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover" }))
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, vim.tbl_extend("force", opts, { desc = "Implementation" }))
    vim.keymap.set("n", "gK", vim.lsp.buf.signature_help, vim.tbl_extend("force", opts, { desc = "Signature help" }))
    vim.keymap.set(
      "n",
      "<localleader>wa",
      vim.lsp.buf.add_workspace_folder,
      vim.tbl_extend("force", opts, { desc = "Add workspace folder" })
    )
    vim.keymap.set(
      "n",
      "<localleader>wr",
      vim.lsp.buf.remove_workspace_folder,
      vim.tbl_extend("force", opts, { desc = "Remove workspace folder" })
    )
    vim.keymap.set("n", "<localleader>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, vim.tbl_extend("force", opts, { desc = "List workspace folders" }))
    vim.keymap.set(
      "n",
      "<space>D",
      vim.lsp.buf.type_definition,
      vim.tbl_extend("force", opts, { desc = "Type definition" })
    )
    vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename" }))
    -- vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code action" }))
    vim.keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "References" }))
    vim.keymap.set("n", "<space>F", function()
      vim.lsp.buf.format({ async = true })
    end, vim.tbl_extend("force", opts, { desc = "Format code" }))
  end

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  if vim.g.plugin_use_cmp then
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
  end
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }

  local options = {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 150,
    },
  }

  require("mason-lspconfig").setup_handlers({
    function(server_name) -- default handler
      lspconfig[server_name].setup(options)
      require("plugins.null-ls").setup(options)
    end,

    denols = function()
      lspconfig["denols"].setup(vim.tbl_deep_extend("force", options, {
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
        single_file_support = false,
        root_dir = lspconfig.util.root_pattern("package.json"),
      }))
    end,
    ["powershell_es"] = function()
      lspconfig["powershell_es"].setup(vim.tbl_deep_extend("force", options, {
        settings = {
          powershell = {
            codeFormatting = {
              preset = "OTBS",
              ignoreOneLineBlock = false,
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
              enabled = false,
              splitAttributes = false,
              joinCDATALines = false,
              joinContentLines = false,
              joinCommentLines = false,
              spaceBeforeEmptyCloseTag = false,
            },
          },
        },
      }))
    end,
    ["rust_analyzer"] = function()
      lspconfig["rust_analyzer"].setup(vim.tbl_deep_extend("force", options, {
        settings = {
          ["rust-analyzer"] = {
            cargo = { allFeatures = true },
            checkOnSave = {
              command = "clippy",
              extraArgs = { "--no-deps" },
            },
          },
        },
      }))
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
  })
end

return M
