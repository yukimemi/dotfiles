return {
  "Shougo/ddu.vim",

  enabled = vim.g.plugin_use_ddu,

  lazy = false,

  dependencies = {
    "vim-denops/denops.vim",

    -- commands
    "Shougo/ddu-commands.vim",

    -- ui
    "Shougo/ddu-ui-ff",

    -- matcher / filter
    "Milly/ddu-filter-merge",
    "4513ECHO/ddu-source-colorscheme",
    "Shougo/ddu-column-filename",
    "Shougo/ddu-filter-converter_display_word",
    "Shougo/ddu-filter-matcher_hidden",
    "Shougo/ddu-filter-matcher_relative",
    "Shougo/ddu-filter-matcher_substring",
    "kuuote/ddu-filter-fuse",
    "yuki-yano/ddu-filter-fzf",
    {
      "Milly/ddu-filter-kensaku",
      dependencies = {
        "lambdalisue/vim-kensaku",
      },
    },

    -- kind
    "Shougo/ddu-kind-file",
    "Shougo/ddu-kind-word",

    -- action
    "Shougo/ddu-source-action",

    -- ui-select
    "matsui54/ddu-vim-ui-select",

    -- sources
    {
      "Milly/windows-clipboard-history.vim",
      enabled = jit.os:find("Windows"),
    },
    "4513ECHO/ddu-source-source",
    "4513ECHO/vim-readme-viewer",
    "Shougo/ddc-source-cmdline-history",
    "Shougo/ddu-source-file",
    "Shougo/ddu-source-file_old",
    "Shougo/ddu-source-file_point",
    "Shougo/ddu-source-file_rec",
    "Shougo/ddu-source-line",
    "Shougo/ddu-source-register",
    "Shougo/ddu-filter-matcher_ignore_files",
    "matsui54/ddu-source-file_external",
    "matsui54/ddu-source-help",
    "shun/ddu-source-buffer",
    {
      "shun/ddu-source-rg",
      dependencies = {
        "lambdalisue/vim-kensaku",
      },
    },
    {
      "kuuote/ddu-source-mr",
      dependencies = {
        "lambdalisue/vim-mr",
      },
    },
    "tennashi/ddu-source-github",
    "tennashi/ddu-source-git_ref",
  },

  init = function()
    vim.keymap.set("n", "<space>do", "<cmd>Ddu file_old<cr>")
    vim.keymap.set("n", "<space>du", "<cmd>Ddu mr<cr>")
    vim.keymap.set("n", "<space>dw", "<cmd>Ddu mr -source-param-kind='mrw'<cr>")
    vim.keymap.set("n", "<space>db", "<cmd>Ddu buffer<cr>")
    vim.keymap.set("n", "<space>df", "<cmd>Ddu `finddir('.git', ';') != '' ? 'file_external' : 'file_rec'`<cr>")
    vim.keymap.set("n", "<space>dR", "<cmd>Ddu -buffer-name=register register -ui-param-autoResize<cr>")
    vim.keymap.set("n", "<space>dd", "<cmd>Ddu file_rec -source-option-path=`fnamemodify(bufname(), ':p:h')`<cr>")
    vim.keymap.set("n", "<space>dc", "<cmd>Ddu file_rec -source-option-path=`expand('~/.cache')`<cr>")
    vim.keymap.set("n", "<space>dj", "<cmd>Ddu file_rec -source-option-path=`expand('~/.cache/junkfile')`<cr>")
    vim.keymap.set("n", "<space>dD", "<cmd>Ddu file_rec -source-option-path=`expand('~/.dotfiles')`<cr>")
    vim.keymap.set("n", "<space>dm", "<cmd>Ddu file_rec -source-option-path=`expand('~/.memolist')`<cr>")
    vim.keymap.set("n", "<space>dS", "<cmd>Ddu file_rec -source-option-path=`expand('~/src')`<cr>")
    vim.keymap.set("n", "<space>dH", "<cmd>Ddu help<cr>")
    vim.keymap.set("n", "<space>dh", "<cmd>Ddu command_history<cr>")
    vim.keymap.set(
      "n",
      "<space>ds",
      "<cmd>Ddu -name=rg rg -ui-param-ignoreEmpty -source-param-input=`input('Pattern: ')`<cr>"
    )
    vim.keymap.set(
      "n",
      "<space>dk",
      "<cmd>Ddu -name=rg rg -ui-param-ignoreEmpty -source-param-inputType='migemo' -source-param-input=`input('Pattern: ')`<cr>"
    )
    vim.keymap.set("n", "<space>dr", "<cmd>Ddu -name=rg -resume<cr>")
    vim.keymap.set("n", "<space>dC", "<cmd>Ddu windows-clipboard-history -source-param-prefix='clip'<cr>")
    vim.keymap.set("n", "<space>dgt", "<cmd>Ddu git_ref -source-param-kind='git_tag'<cr>")
    vim.keymap.set("n", "<space>dgb", "<cmd>Ddu git_ref -source-param-kind='git_branch'<cr>")
    vim.keymap.set("n", "<space>dgp", "<cmd>Ddu github_pr<cr>")
    vim.keymap.set("n", "<space>dgi", "<cmd>Ddu github_issue<cr>")

    local function ddu_rg_live()
      vim.fn["ddu#start"]({
        volatile = true,
        sources = { {
          name = "rg",
          options = {
            matchers = {},
          },
        } },
        uiParams = {
          ff = {
            ignoreEmpty = false,
            autoResise = false,
          },
        },
      })
    end

    vim.api.nvim_create_user_command("DduRgLive", ddu_rg_live, {})

    vim.api.nvim_create_autocmd("FileType", {
      group = "MyAutoCmd",
      pattern = "ddu-ff-filter",
      callback = function()
        vim.keymap.set("i", "<cr>", "<cmd>call ddu#ui#do_action('itemAction')<cr>", { buffer = true })
        vim.keymap.set(
          "i",
          "<esc>",
          "<esc><cmd>call ddu#ui#do_action('closeFilterWindow')<cr>",
          { nowait = true, buffer = true }
        )
        vim.keymap.set(
          "i",
          "<c-j>",
          [[<cmd>call ddu#ui#ff#execute('call cursor(line(".") % line("$") + 1, 0)<bar>redraw')<cr>]],
          { buffer = true }
        )
        vim.keymap.set(
          "i",
          "<c-k>",
          [[<cmd>call ddu#ui#ff#execute('call cursor((line(".") - 2 + line("$")) % line("$") + 1, 0)<bar>redraw')<cr>]],
          { buffer = true }
        )
      end,
    })

    vim.api.nvim_create_autocmd("FileType", {
      group = "MyAutoCmd",
      pattern = "ddu-ff",
      callback = function()
        vim.wo.cursorline = true
        vim.keymap.set("n", "<cr>", "<cmd>call ddu#ui#do_action('itemAction')<cr>", { buffer = true })
        vim.keymap.set("n", "<space>", "<cmd>call ddu#ui#do_action('toggleSelectItem')<cr>", { buffer = true })
        vim.keymap.set("n", "i", "<cmd>call ddu#ui#do_action('openFilterWindow')<cr>", { buffer = true })
        vim.keymap.set("n", "a", "<cmd>call ddu#ui#do_action('chooseAction')<cr>", { buffer = true })
        vim.keymap.set("n", "A", "<cmd>call ddu#ui#do_action('inputAction')<cr>", { buffer = true })
        vim.keymap.set("n", "<C-l>", "<cmd>call ddu#ui#do_action('refreshItems')<cr>", { buffer = true })
        vim.keymap.set("n", "p", "<cmd>call ddu#ui#do_action('preview')<cr>", { buffer = true })
        vim.keymap.set("n", "q", "<cmd>call ddu#ui#do_action('quit')<cr>", { buffer = true })
        vim.keymap.set("n", "c", "<cmd>call ddu#ui#do_action('itemAction', {'name': 'cd'})<cr>", { buffer = true })
        vim.keymap.set("n", "d", "<cmd>call ddu#ui#do_action('itemAction', {'name': 'delete'})<cr>", { buffer = true })
        vim.keymap.set("n", "e", "<cmd>call ddu#ui#do_action('itemAction', {'name': 'edit'})<cr>", { buffer = true })
        vim.keymap.set(
          "n",
          "E",
          "<cmd>call ddu#ui#do_action('itemAction', {'params': eval(input('params: '))})<cr>",
          { buffer = true }
        )
        vim.keymap.set(
          "n",
          "v",
          "<cmd>call ddu#ui#do_action('itemAction', {'name': 'open', 'params': {'command': 'vsplit'}})<cr>",
          { buffer = true }
        )
        vim.keymap.set("n", "N", "<cmd>call ddu#ui#do_action('itemAction', {'name': 'new'})<cr>", { buffer = true })
        vim.keymap.set(
          "n",
          "r",
          "<cmd>call ddu#ui#do_action('itemAction', {'name': 'quickfix'})<cr>",
          { buffer = true }
        )
        vim.keymap.set("n", "<esc>", "<cmd>call ddu#ui#do_action('quit')<cr>", { nowait = true, buffer = true })
        vim.keymap.set(
          "n",
          "u",
          "<cmd>call ddu#ui#do_action('updateOptions', {'sourceOptions': {'_': {'matchers': []}}})<cr>",
          { buffer = true }
        )
      end,
    })
  end,

  config = function()
    vim.fn["ddu#custom#patch_global"]({
      ui = "ff",
      uiParams = {
        ff = {
          split = "horizontal",
          prompt = "»",
          startFilter = true,
        },
      },
      uiOptions = {
        filer = {
          toggle = true,
        },
      },
      sourceOptions = {
        ["_"] = {
          ignoreCase = true,
          matchers = { "merge" },
        },
        file_old = {
          matchers = {
            "matcher_substring",
            "matcher_relative",
            "matcher_ignore_current_buffer",
          },
        },
        file_external = {
          matchers = {
            "matcher_substring",
          },
        },
        file_rec = {
          matchers = {
            "matcher_substring",
            "matcher_hidden",
          },
        },
        file = {
          matchers = {
            "matcher_substring",
            "matcher_hidden",
          },
          sorters = { "sorter_alpha" },
        },
        dein = {
          defaultAction = "cd",
        },
        markdown = {
          sorters = {},
        },
        line = {
          matchers = {
            "matcher_kensaku",
          },
        },
        path_history = {
          defaultAction = "uiCd",
        },
        rg = {
          matchers = {
            "matcher_substring",
            "matcher_files",
          },
        },
      },
      sourceParams = {
        file_external = {
          cmd = { "git", "ls-files", "-co", "--exclude-standard" },
        },
        file_rg = {
          cmd = { "rg", "--files", "--glob", "!.git", "--color", "never", "--no-messages", "--json" },
          updateItems = 50000,
        },
        rg = {
          args = { "--ignore-case", "--column", "--no-heading", "--color", "never", "--json" },
          inputType = "regex",
        },
      },
      filterParams = {
        matcher_fzf = {
          highlightMatched = "Search",
        },
        matcher_fuse = {
          highlightMatched = "Search",
        },
        matcher_kensaku = {
          highlightMatched = "Search",
        },
        merge = {
          highlightMatched = "Search",
          filters = {
            {
              name = "matcher_kensaku",
              weight = 2.0,
            },
            "matcher_fuse",
          },
        },
      },
      kindParams = {
        action = {
          quit = true,
        },
      },
      kindOptions = {
        file = {
          defaultAction = "open",
        },
        help = {
          defaultAction = "open",
        },
        word = {
          defaultAction = "append",
        },
        action = {
          defaultAction = "do",
        },
        readme_viewer = {
          defaultAction = "open",
        },
        git_tag = {
          defaultAction = "switch",
        },
        git_branch = {
          defaultAction = "switch",
        },
        github_pr = {
          defaultAction = "switch",
        },
        github_issue = {
          defaultAction = "view_web",
        },
      },
      actionOptions = {
        narrow = {
          quit = false,
        },
        tabopen = {
          quit = false,
        },
      },
      actionParams = {
        rg = {
          quit = false,
        },
      },
    })
  end,
}
