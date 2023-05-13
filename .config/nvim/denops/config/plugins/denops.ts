import { Plugin } from "./types.ts";

export const denops: Plugin[] = [
  {
    org: "yukimemi",
    repo: "dps-autocursor",
    lua_pre: `
      vim.g.autocursor_debug = false
    `,
  },
  {
    org: "yukimemi",
    repo: "dps-autobackup",
    lua_pre: `
      vim.g.autobackup_debug = false
      vim.g.autobackup_enable = true
      vim.g.autobackup_write_echo = false
      vim.g.autobackup_use_ui_select = false
      vim.g.autobackup_blacklist_filetypes = {
        "csv",
        "ctrlp",
        "ddu-ff",
        "ddu-ff-filter",
        "ddu-filer",
        "dpswalk",
        "gin-diff",
        "gin-status",
        "list",
        "log",
        "qf",
        "quickfix",
      }
    `,
  },
  {
    org: "yukimemi",
    repo: "dps-autodate",
    lua_pre: `
      vim.g.autodate_debug = false
      vim.g.autodate_config = {
        xml = {
          replace = {
            { '/^(.*key="version">)[^<]*(<.*)/i', '\$1\${format(now, "yyyyMMdd_HHmmss")}$2' },
            { '/^(.*key="%{task_file}%_version">)[^<]*(<.*)/i', '\$1\${format(now, "yyyyMMdd_HHmmss")}$2' },
            { '/^(.*key="%{task_name}%_version">)[^<]*(<.*)/i', '\$1\${format(now, "yyyyMMdd_HHmmss")}$2' },
            { '/^(.*key="autobot_version">)[^<]*(<.*)/i', '\$1\${format(now, "yyyyMMdd_HHmmss")}$2' }
          },
          event = "BufWritePre",
          pat = { "*.xml", "*.xaml" },
          head = 30,
          tail = 5,
        },
        ps1 = {
          replace = {
            { [[/^(\s*\.Last Change: ).*/i]], [[\$1\${format(now, "yyyy/MM/dd HH:mm:ss")}]] },
            { '/^(.*"version", ")[0-9_]+(".*)/i', '\$1\${format(now, "yyyyMMdd_HHmmss")}$2' },
          },
          event = "BufWritePre",
          pat = { "*.ps1" },
          head = 50,
          tail = 5,
        },
        typescript = {
          replace = {
            { '/^(const version = ")[0-9_]+(";)/', '\$1\${format(now, "yyyyMMdd_HHmmss")}$2' },
          },
          event = "BufWritePre",
          pat = { "*.ts" },
          head = 50,
          tail = 5,
        },
      }
    `,
  },
  {
    org: "yukimemi",
    repo: "dps-walk",
    lua_pre: `
      vim.g.walk_debug = false

      vim.keymap.set("n", "<space>Wa", "<cmd>DenopsWalk<cr>")
      vim.keymap.set("n", "<space>Ws", "<cmd>DenopsWalk --path=~/src<cr>")
      vim.keymap.set("n", "<space>Wd", "<cmd>DenopsWalk --path=~/.dotfiles<cr>")
      vim.keymap.set("n", "<space>Wc", "<cmd>DenopsWalk --path=~/.cache<cr>")
      vim.keymap.set("n", "<space>Wj", "<cmd>DenopsWalk --path=~/.cache/junkfile<cr>")
      vim.keymap.set("n", "<space>Wm", "<cmd>DenopsWalk --path=~/.memolist<cr>")
      vim.keymap.set("n", "<space>WD", "<cmd>DenopsWalkBufferDir<cr>")
    `,
  },
  {
    org: "yukimemi",
    repo: "dps-randomcolorscheme",
    lua_pre: `
      vim.g.randomcolorscheme_debug = false
      vim.g.randomcolorscheme_echo = true
      vim.g.randomcolorscheme_interval = 100
      vim.g.randomcolorscheme_disables = { "evening", "default", "blue" }
      vim.g.randomcolorscheme_path = vim.fn.expand "~/.config/randomcolorscheme/colorscheme.toml"
      vim.g.randomcolorscheme_notmatch = "[Ll]ight"
      vim.g.randomcolorscheme_background = "dark"
      vim.keymap.set("n", "<space>ro", "<cmd>ChangeColorscheme<cr>")
      vim.keymap.set("n", "<space>rd", "<cmd>DisableThisColorscheme<cr>")
      vim.keymap.set("n", "<space>rl", "<cmd>LikeThisColorscheme<cr>")
      vim.keymap.set("n", "<space>rh", "<cmd>HateThisColorscheme<cr>")
    `,
  },
  {
    org: "yukimemi",
    repo: "dps-hitori",
    lua_pre: `
      vim.g.hitori_debug = false
      vim.g.hitori_enable = true
      vim.g.hitori_quit = true

      vim.g.hitori_blacklist_patterns = { "\.tmp\$", "\.diff\$", "(COMMIT_EDIT|TAG_EDIT|MERGE_|SQUASH_)MSG\$" }
    `,
  },
];
