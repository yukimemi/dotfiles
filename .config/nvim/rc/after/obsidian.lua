-- =============================================================================
-- File        : obsidian.lua
-- Author      : yukimemi
-- Last Change : 2026/01/11 17:24:34
-- =============================================================================

vim.opt.conceallevel = 2

local source = require("obsidian")
source.setup({
  workspaces = {
    {
      name = "personal",
      path = "~/obsidian",
    },
  },
  completion = {
    nvim_cmp = false,
    min_chars = 2,
  },
  mappings = {
    -- Smart action (links, tags, checkboxes)
    ["<cr>"] = {
      action = function()
        return require("obsidian").util.smart_action()
      end,
      opts = { buffer = true, expr = true },
    },
    -- Overrides the 'gf' mapping to work on markdown/obsidian links within the vault.
    ["gf"] = {
      action = function()
        return require("obsidian").util.gf_passthrough()
      end,
      opts = { noremap = false, expr = true, buffer = true },
    },
    -- Toggle check-boxes.
    ["<space>ch"] = {
      action = function()
        return require("obsidian").util.toggle_checkbox()
      end,
      opts = { buffer = true },
    },
    -- Create a new link from the visual selection
    ["<space>on"] = {
      action = function()
        return require("obsidian").util.insert_link()
      end,
      opts = { buffer = true },
    },
  },
})

-- Snacks picker support for searching notes
local obsidian_path = vim.fn.expand("~/obsidian")

vim.keymap.set("n", "<space>of", function()
  Snacks.picker.files({ cwd = obsidian_path })
end, { desc = "Find Obsidian notes (Snacks)" })

vim.keymap.set("n", "<space>og", function()
  Snacks.picker.grep({ cwd = obsidian_path })
end, { desc = "Grep Obsidian notes (Snacks)" })

-- Override Obsidian commands to use Snacks picker
vim.api.nvim_create_user_command("ObsidianQuickSwitch", function()
  Snacks.picker.files({ cwd = obsidian_path })
end, { force = true })

vim.api.nvim_create_user_command("ObsidianSearch", function()
  Snacks.picker.grep({ cwd = obsidian_path })
end, { force = true })

-- Auto sync on save
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*.md",
  callback = function(opts)
    local client = require("obsidian").get_client()
    if not client then
      return
    end

    -- Check if the file is in the vault
    local path = vim.fs.normalize(vim.api.nvim_buf_get_name(opts.buf))
    local in_vault = false
    for _, workspace in ipairs(client.opts.workspaces) do
      local workspace_path = vim.fs.normalize(vim.fn.expand(workspace.path))
      if path:find(workspace_path, 1, true) then
        in_vault = true
        break
      end
    end

    if in_vault then
      local cwd = vim.fs.dirname(path)
      local function git_sync()
        vim.fn.jobstart({ "git", "add", "." }, {
          cwd = cwd,
          on_exit = function(_, code1)
            if code1 == 0 then
              vim.fn.jobstart({ "git", "commit", "-m", "chore(obsidian): auto save from neovim" }, {
                cwd = cwd,
                on_exit = function(_, code2)
                  if code2 == 0 then
                    vim.fn.jobstart({ "git", "push" }, {
                      cwd = cwd,
                      on_exit = function(_, code3)
                        if code3 == 0 then
                          vim.notify("Obsidian synced!", vim.log.levels.INFO)
                        end
                      end,
                    })
                  end
                end,
              })
            end
          end,
        })
      end
      git_sync()
    end
  end,
})
