local M = {
  "neovim/nvim-lspconfig",

  enabled = true,

  event = "BufReadPre",

  dependencies = {
    "SmiteshP/nvim-navic",
    "jose-elias-alvarez/null-ls.nvim",
    {
      "williamboman/mason.nvim",
      cmd = "Mason",
    },
    {
      "williamboman/mason-lspconfig.nvim",
    },
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
      config = true,
    },
    {
      "folke/neoconf.nvim",
      cmd = "Neoconf",
      config = true
    },
  },
}

function M.config()
  require("mason").setup()
  require("mason-lspconfig").setup()
  local lspconfig = require("lspconfig")

  local function on_attach(client, bufnr)
    require("nvim-navic").attach(client, bufnr)

    local opts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "gK", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<localleader>wa", vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set("n", "<localleader>wr", vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set("n", "<localleader>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>F', function() vim.lsp.buf.format({ async = true }) end, opts)
  end

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  if vim.g.plugin_use_cmp then
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
  end
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }

  require("mason-lspconfig").setup_handlers({
    function(server_name) -- default handler
      local options = {
        on_attach = on_attach,
        capabilities = capabilities,
        flags = {
          debounce_text_changes = 150,
        },
      }
      lspconfig[server_name].setup(options)
      require("plugins.null-ls").setup(options)
    end,

    denols = function()
      lspconfig["denols"].setup({
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
      })
    end,
    tsserver = function()
      lspconfig["tsserver"].setup({
        single_file_support = false,
        root_dir = lspconfig.util.root_pattern("package.json"),
      })
    end,
    ["powershell_es"] = function()
      lspconfig["powershell_es"].setup({
        settings = {
          powershell = {
            codeFormatting = {
              preset = "OTBS",
              ignoreOneLineBlock = false,
            },
          },
        },
      })
    end,
    ["rust_analyzer"] = function()
      lspconfig["rust_analyzer"].setup({
        settings = {
          ["rust-analyzer"] = {
            cargo = { allFeatures = true },
            checkOnSave = {
              command = "clippy",
              extraArgs = { "--no-deps" },
            },
          },
        },
      })
    end,
    ["sumneko_lua"] = function()
      lspconfig["sumneko_lua"].setup({
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
      })
    end,
  })
end

return M
