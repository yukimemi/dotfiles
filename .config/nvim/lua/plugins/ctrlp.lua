return {
  "ctrlpvim/ctrlp.vim",

  enabled = vim.g.plugin_use_ctrlp,

  cmd = {
    "CtrlP",
    "CtrlPBuffer",
    "CtrlPCurFile",
    "CtrlPMRUFiles",
    "CtrlPLauncher",
    "CtrlPSonictemplate",
    "CtrlPCmdHistory",
    "CtrlPSearchHistory",
    "CtrlPMRMru",
    "CtrlPMRMrw",
    "CtrlPMRMrr",
  },

  dependencies = {
    "kaneshin/ctrlp-filetype",
    "kaneshin/ctrlp-memolist",
    "mattn/ctrlp-launcher",
    "mattn/ctrlp-mark",
    "mattn/ctrlp-matchfuzzy",
    "ompugao/ctrlp-history",
    "suy/vim-ctrlp-commandline",
    {
      "tsuyoshicho/ctrlp-mr.vim",
      dependencies = {
        "lambdalisue/mr.vim",
      },
    },
    {
      "kaneshin/ctrlp-sonictemplate",
      dependencies = {
        "mattn/vim-sonictemplate",
      },
    },
    {
      "ompugao/ctrlp-kensaku",
      dependencies = {
        "lambdalisue/kensaku.vim",
      },
    }
  },

  keys = {
    -- { "<space>ch", "<cmd>CtrlPCommandLine<cr>", mode = { "n", "x" } },
    { "<space>cM", "<cmd>CtrlPMark<cr>", mode = "n" },
    { "<space>cS", "<cmd>CtrlPSearchHistory<cr>", mode = "n" },
    { "<space>cb", "<cmd>CtrlPBuffer<cr>", mode = "n" },
    { "<space>cc", "<cmd>CtrlP ~/.cache<cr>", mode = "n" },
    -- { "<space>cl", "<cmd>CtrlPLauncher<cr>", mode = "n" },
    { "<space>cd", "<cmd>CtrlP ~/.dotfiles<cr>", mode = "n" },
    { "<space>cD", "<cmd>CtrlPCurFile<cr>", mode = "n" },
    { "<space>cf", "<cmd>CtrlPFiletype<cr>", mode = "n" },
    { "<space>cm", "<cmd>CtrlPMemolist<cr>", mode = "n" },
    { "<space>cp", "<cmd>CtrlP<cr>", mode = "n" },
    { "<space>cs", "<cmd>CtrlP ~/src<cr>", mode = "n" },
    { "<space>cr", "<cmd>CtrlPMRMrr<cr>", mode = "n" },
    { "<space>cu", "<cmd>CtrlPMRMru<cr>", mode = "n" },
    { "<space>cw", "<cmd>CtrlPMRMrw<cr>", mode = "n" },
  },

  init = function()
    vim.g.ctrlp_map = "<nop>"
    vim.g.ctrlp_clear_cache_on_exit = 0
    vim.g.ctrlp_key_loop = 1
    vim.g.ctrlp_lazy_update = 200
    vim.g.ctrlp_line_prefix = "» "
    vim.g.ctrlp_match_current_file = 1
    vim.g.ctrlp_mruf_max = 100000
    vim.g.ctrlp_show_hidden = 1
    vim.g.ctrlp_use_caching = 1
    vim.g.ctrlp_user_command_async = 1
    vim.g.ctrlp_regexp = 1

    vim.api.nvim_create_user_command("CtrlPCommandLine", "call ctrlp#init(ctrlp#commandline#id())", {})

    if vim.fn.executable("rg") then
      vim.g.ctrlp_grep_command = "rg -i --vimgrep --no-heading --hidden --no-ignore --regexp"
    end

    local function kensaku()
      local oldmatcher = vim.g.ctrlp_match_func
      vim.g.ctrlp_match_func = { match = "ctrlp_kensaku#matcher" }
      vim.cmd([[CtrlP]])
      vim.g.ctrlp_match_func = oldmatcher
    end

    vim.api.nvim_create_user_command("CtrlPKensaku", kensaku, {})
  end,
}
