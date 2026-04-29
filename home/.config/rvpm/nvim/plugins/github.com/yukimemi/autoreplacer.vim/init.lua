-- =============================================================================
-- File        : init.lua
-- Author      : yukimemi
-- Last Change : 2026/04/20 20:46:03.
-- =============================================================================

vim.g.autoreplacer_debug = false
vim.g.autoreplacer_notify = true
vim.g.autoreplacer_config = {
  xml = {
    replace = {
      { '/^(.*key="version">)[^<]*(<.*)/i',               '$1${format(now, "yyyyMMdd_HHmmss")}$2' },
      { '/^(.*key="%{task_file}%_version">)[^<]*(<.*)/i', '$1${format(now, "yyyyMMdd_HHmmss")}$2' },
      { '/^(.*key="%{task_name}%_version">)[^<]*(<.*)/i', '$1${format(now, "yyyyMMdd_HHmmss")}$2' },
      { '/^(.*key="autobot_version">)[^<]*(<.*)/i',       '$1${format(now, "yyyyMMdd_HHmmss")}$2' },
    },
    event = "BufWritePre",
    pat = { "*.xml", "*.xaml" },
    head = 30,
    tail = 5,
  },
  ps1 = {
    replace = {
      { '/^(\\s*.Last Change\\s*: ).*\\./i',  '$1${format(now, "yyyy/MM/dd HH:mm:ss")}.' },
      { '/^(.*"version", ")[0-9_]+(".*)/i',   '$1${format(now, "yyyyMMdd_HHmmss")}$2' },
      { '/^(.*\\$version = ")[0-9_]+(".*)/i', '$1${format(now, "yyyyMMdd_HHmmss")}$2' },
    },
    event = "BufWritePre",
    pat = { "*.ps1" },
    head = 50,
    tail = 5,
  },
  typescript = {
    replace = {
      { '/^(const version = ")[0-9_]+(";)/', '$1${format(now, "yyyyMMdd_HHmmss")}$2' },
    },
    event = "BufWritePre",
    pat = { "*.ts" },
    head = 50,
    tail = 5,
  },
  toml = {
    replace = {
      { "/^(version = [\"'])[0-9_]+([\"'])/", '$1${format(now, "yyyyMMdd_HHmmss")}$2' },
    },
    event = "BufWritePre",
    pat = { "*.toml" },
    head = 55,
    tail = 5,
  },
}
