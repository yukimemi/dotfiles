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

-- Helper to check if buffer is in vault
local function is_in_vault(buf)
  local client = require("obsidian").get_client()
  if not client then
    return false, nil
  end
  local path = vim.fs.normalize(vim.api.nvim_buf_get_name(buf))
  for _, workspace in ipairs(client.opts.workspaces) do
    local workspace_path = vim.fs.normalize(vim.fn.expand(workspace.path))
    if path:find(workspace_path, 1, true) then
      return true, vim.fs.dirname(path)
    end
  end
  return false, nil
end

-- Auto sync on save (Pull -> Add -> Commit -> Push)
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*.md",
  callback = function(opts)
    local in_vault, cwd = is_in_vault(opts.buf)
    if in_vault then
      local function git_sync()
        vim.fn.jobstart({ "git", "pull", "--rebase" }, {
          cwd = cwd,
          on_exit = function(_, code_pull)
            if code_pull == 0 then
              vim.fn.jobstart({ "git", "add", "." }, {
                cwd = cwd,
                on_exit = function(_, code_add)
                  if code_add == 0 then
                    vim.fn.jobstart({ "git", "commit", "-m", "chore(obsidian): auto save from neovim" }, {
                      cwd = cwd,
                      on_exit = function(_, code_commit)
                        if code_commit == 0 then
                          vim.fn.jobstart({ "git", "push" }, {
                            cwd = cwd,
                            on_exit = function(_, code_push)
                              if code_push == 0 then
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
            else
              vim.notify("Obsidian pull failed! Check for conflicts.", vim.log.levels.WARN)
            end
          end,
        })
      end
      git_sync()
    end
  end,
})

-- Auto pull on focus
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
  pattern = "*.md",
  callback = function(opts)
    local in_vault, cwd = is_in_vault(opts.buf)
    if in_vault then
      vim.fn.jobstart({ "git", "pull", "--rebase" }, {
        cwd = cwd,
        on_exit = function(_, code)
          if code == 0 then
            -- Reload buffer if file changed on disk
            vim.cmd("checktime")
          end
        end,
      })
    end
  end,
})
