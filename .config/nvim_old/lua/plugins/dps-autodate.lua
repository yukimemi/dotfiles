return {
  "yukimemi/dps-autodate",

  lazy = false,
  dependencies = {
    "vim-denops/denops.vim",
  },
  init = function()
    vim.g.autodate_debug = false
    vim.g.autodate_config = {
      xml = {
        replace = {
          { '/^(.*key="version">)[^<]*(<.*)/i', '$1${format(now, "yyyyMMdd_HHmmss")}$2' },
          { '/^(.*key="%{task_file}%_version">)[^<]*(<.*)/i', '$1${format(now, "yyyyMMdd_HHmmss")}$2' },
          { '/^(.*key="%{task_name}%_version">)[^<]*(<.*)/i', '$1${format(now, "yyyyMMdd_HHmmss")}$2' },
          { '/^(.*key="autobot_version">)[^<]*(<.*)/i', '$1${format(now, "yyyyMMdd_HHmmss")}$2' }
        },
        event = "BufWritePre",
        pat = { "*.xml", "*.xaml" },
        head = 30,
        tail = 5,
      },
      ps1 = {
        replace = {
          { [[/^(\s*\.Last Change: ).*/i]], [[$1${format(now, "yyyy/MM/dd HH:mm:ss")}]] },
          { '/^(.*"version", ")[0-9_]+(".*)/i', '$1${format(now, "yyyyMMdd_HHmmss")}$2' },
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
    }
  end,
}
