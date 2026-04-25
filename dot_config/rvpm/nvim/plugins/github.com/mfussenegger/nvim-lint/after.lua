local ok, lint = pcall(require, "lint")
if not ok then
  return
end

lint.linters_by_ft = {
  markdown = { "vale" },
  sh = { "shellcheck" },
  bash = { "shellcheck" },
  zsh = { "zsh" },
  fish = { "fish" },
  lua = { "selene" },
  python = { "ruff" },
  rust = { "clippy" },
  go = { "golangcilint" },
  yaml = { "yamllint" },
  dockerfile = { "hadolint" },
  vim = { "vint" },
  toml = { "tombi" },
  ["yaml.ghaction"] = { "actionlint" },
  gitcommit = { "gitlint" },
}

vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
  group = vim.api.nvim_create_augroup("rvpm_nvim_lint", { clear = true }),
  callback = function()
    require("lint").try_lint()
  end,
})
