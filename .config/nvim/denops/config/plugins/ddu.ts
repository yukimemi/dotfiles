import { Denops } from "https://deno.land/x/denops_std@v4.3.3/mod.ts";
import { type Plug } from "https://deno.land/x/dvpm@0.1.1/mod.ts";
import { execute } from "https://deno.land/x/denops_std@v4.3.3/helper/mod.ts";

export const ddu: Plug[] = [
  { url: "4513ECHO/ddu-kind-url" },
  { url: "4513ECHO/ddu-source-emoji" },
  { url: "4513ECHO/ddu-source-source" },
  { url: "Milly/ddu-filter-kensaku" },
  { url: "Shougo/ddu-kind-file" },
  { url: "Shougo/ddu-kind-word" },
  { url: "Shougo/ddu-source-file_old" },
  { url: "Shougo/ddu-source-file_rec" },
  { url: "Shougo/ddu-source-line" },
  { url: "Shougo/ddu-source-register" },
  { url: "Shougo/ddu-ui-ff" },
  { url: "matsui54/ddu-source-command_history" },
  { url: "matsui54/ddu-source-help" },
  { url: "matsui54/ddu-vim-ui-select" },
  { url: "shun/ddu-source-buffer" },
  { url: "tyru/open-browser.vim" },
  {
    url: "Shougo/ddu.vim",
    before: async (denops: Denops) => {
      await execute(
        denops,
        `
lua << EOB
      local start = vim.fn["ddu#start"]
      vim.keymap.set("n", "<leader>ds", function() start({ sources = { { name = "source" } } }) end, { desc = "ddu source" })
      vim.keymap.set("n", "<leader>do", function() start({ sources = { { name = "file_old" } } }) end, { desc = "ddu file_old" })
      vim.keymap.set("n", "<leader>db", function() start({ sources = { { name = "buffer" } } }) end, { desc = "ddu buffer" })
      vim.keymap.set("n", "<leader>dd", function() start({ sources = { { name = "file_rec", sourceOptionPath = vim.fn.fnamemodify(vim.fn.bufname(), ":p:h") } } }) end, { desc = "ddu files on buffered dir" })
      vim.keymap.set("n", "<leader>dD", function() start({ sources = { { name = "file_rec", sourceOptionPath = vim.fn.expand("~/.dotfiles") } } }) end, { desc = "ddu files on dorfiles dir" })
      vim.keymap.set("i", "<C-x><C-e>", function() start({ sources = { { name = "emoji", options = { defaultAction = "append" } } } }) end)
EOB
    `,
      );
    },
    after: async (denops: Denops) => {
      await execute(
        denops,
        `
lua << EOB
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
EOB
    `,
      );
    },
  },
];
