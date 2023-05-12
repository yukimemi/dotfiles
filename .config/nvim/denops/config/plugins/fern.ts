import { Plugin } from "./types.ts";

export const fern: Plugin[] = [
  { org: "lambdalisue", repo: "glyph-palette.vim" },
  { org: "lambdalisue", repo: "nerdfont.vim" },
  {
    org: "lambdalisue",
    repo: "fern.vim",
    lua_pre: `
      vim.keymap.set("n", "<leader>e", "<cmd>Fern . -reveal=% -drawer -width=30<cr>")
      vim.keymap.set("n", "<leader>E", function()
        vim.cmd(
          string.format("Fern file:///%s -reveal=%s -drawer -width=30", vim.fn.expand "%:p:h", vim.fn.expand "%:t")
        )
      end)
    `,
    lua_post: `
      vim.g.loaded_netrwPlugin = 1
      vim.g["fern#default_hidden"] = 1
      vim.g["fern#renderer"] = "nerdfont"
      vim.g["fern#renderer#nerdfont#indent_makers"] = 1

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "fern",
        callback = function()
          vim.keymap.set(
            "n",
            "o",
            function()
              vim.fn["fern#smart#leaf"](
                "<Plug>(fern-action-open)",
                "<Plug>(fern-action-expand)",
                "<Plug>(fern-action-collapse)"
              )
            end,
            { buffer = true, expr = true }
          )

          vim.keymap.set("n", "<c-l>", "<c-w>l", { buffer = true })
          vim.keymap.set("n", "S", "<Plug>(fern-action-open:select)", { buffer = true })
          vim.keymap.set("n", "h", "<Plug>(fern-action-leave)", { buffer = true })
          vim.keymap.set("n", "n", "<Nop>", { buffer = true })
          vim.keymap.set("n", "s", "<Nop>", { buffer = true })
        end,
      })
    `,
  },
  { org: "lambdalisue", repo: "fern-hijack.vim" },
  { org: "lambdalisue", repo: "fern-git-status.vim" },
  { org: "lambdalisue", repo: "fern-git.vim" },
  { org: "lambdalisue", repo: "fern-mapping-git.vim" },
  { org: "lambdalisue", repo: "fern-bookmark.vim" },
  { org: "lambdalisue", repo: "fern-comparator-lexical.vim" },
  { org: "lambdalisue", repo: "fern-renderer-nerdfont.vim" },
];
