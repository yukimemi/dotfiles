import { Plugin } from "./types.ts";

export const ddu: Plugin[] = [
  { org: "4513ECHO", repo: "ddu-kind-url" },
  { org: "4513ECHO", repo: "ddu-source-emoji" },
  { org: "4513ECHO", repo: "ddu-source-source" },
  { org: "Milly", repo: "ddu-filter-kensaku" },
  { org: "Shougo", repo: "ddu-kind-file" },
  { org: "Shougo", repo: "ddu-kind-word" },
  { org: "Shougo", repo: "ddu-source-file_old" },
  { org: "Shougo", repo: "ddu-source-line" },
  { org: "Shougo", repo: "ddu-source-register" },
  { org: "Shougo", repo: "ddu-ui-ff" },
  { org: "matsui54", repo: "ddu-source-command_history" },
  { org: "matsui54", repo: "ddu-source-help" },
  { org: "matsui54", repo: "ddu-vim-ui-select" },
  { org: "shun", repo: "ddu-source-buffer" },
  { org: "tyru", repo: "open-browser.vim" },
  {
    org: "Shougo",
    repo: "ddu.vim",
    lua_pre: `
      local start = vim.fn["ddu#start"]
      vim.keymap.set("n", "<leader>d", function() start({ sources = { { name = "source" } } }) end)
      vim.keymap.set("i", "<C-x><C-e>", function() start({ sources = { { name = "emoji", options = { defaultAction = "append" } } } }) end)
    `,
    lua_post: `
      local patch_global = vim.fn["ddu#custom#patch_global"]

      -- ui
      patch_global("ui", "ff")
      patch_global("uiParams", {
        ff = {
          split = "floating",
          floatingBorder = "single",
        },
      })

      -- sources
      patch_global("sources", {})
      patch_global("sourceOptions", {
        ["_"] = { matchers = { "matcher_kensaku" } },
      })
      patch_global("sourceParams", {})

      --- kinds
      patch_global("kindOptions", {
        command_history = { defaultAction = "edit" },
        file = { defaultAction = "open" },
        source = { defaultAction = "execute" },
        ui_select = { defaultAction = "select" },
        url = { defaultAction = "browse" },
        word = { defaultAction = "append" },
      })

      -- key-bindings
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "ddu-ff",
        callback = function()
          local opts = { buffer = true }
          vim.wo.cursorline = true
          vim.keymap.set("n", "<cr>", "<cmd>call ddu#ui#do_action('itemAction')<cr>", opts)
          vim.keymap.set("n", "<space>", "<cmd>call ddu#ui#do_action('toggleSelectItem')<cr>", opts)
          vim.keymap.set("n", "i", "<cmd>call ddu#ui#do_action('openFilterWindow')<cr>", opts)
          vim.keymap.set("n", "a", "<cmd>call ddu#ui#do_action('chooseAction')<cr>", opts)
          vim.keymap.set("n", "A", "<cmd>call ddu#ui#do_action('inputAction')<cr>", opts)
          vim.keymap.set("n", "<C-l>", "<cmd>call ddu#ui#do_action('refreshItems')<cr>", opts)
          vim.keymap.set("n", "p", "<cmd>call ddu#ui#do_action('preview')<cr>", opts)
          vim.keymap.set("n", "q", "<cmd>call ddu#ui#do_action('quit')<cr>", opts)
          vim.keymap.set("n", "c", "<cmd>call ddu#ui#do_action('itemAction', {'name': 'cd'})<cr>", opts)
          vim.keymap.set("n", "d", "<cmd>call ddu#ui#do_action('itemAction', {'name': 'delete'})<cr>", opts)
          vim.keymap.set("n", "e", "<cmd>call ddu#ui#do_action('itemAction', {'name': 'edit'})<cr>", opts)
          vim.keymap.set(
            "n",
            "E",
            "<cmd>call ddu#ui#do_action('itemAction', {'params': eval(input('params: '))})<cr>",
            opts
          )
          vim.keymap.set(
            "n",
            "v",
            "<cmd>call ddu#ui#do_action('itemAction', {'name': 'open', 'params': {'command': 'vsplit'}})<cr>",
            opts
          )
          vim.keymap.set("n", "N", "<cmd>call ddu#ui#do_action('itemAction', {'name': 'new'})<cr>", opts)
          vim.keymap.set(
            "n",
            "r",
            "<cmd>call ddu#ui#do_action('itemAction', {'name': 'quickfix'})<cr>",
            opts
          )
          vim.keymap.set("n", "<esc>", "<cmd>call ddu#ui#do_action('quit')<cr>", { nowait = true, buffer = true })
          vim.keymap.set(
            "n",
            "u",
            "<cmd>call ddu#ui#do_action('updateOptions', {'sourceOptions': {'_': {'matchers': []}}})<cr>",
            opts
          )
        end,
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "ddu-ff-filter",
        callback = function()
          local opts = { buffer = true }
          vim.keymap.set("i", "<cr>", "<cmd>call ddu#ui#do_action('itemAction')<cr>", opts)
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
            opts
          )
          vim.keymap.set(
            "i",
            "<c-k>",
            [[<cmd>call ddu#ui#ff#execute('call cursor((line(".") - 2 + line("$")) % line("$") + 1, 0)<bar>redraw')<cr>]],
            opts
          )
        end,
      })
    `,
  },
];
