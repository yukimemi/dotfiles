import type { Denops } from "https://deno.land/x/denops_std@v5.0.0/mod.ts";
import type { Plug } from "https://deno.land/x/dvpm@0.3.9/mod.ts";

import { execute } from "https://deno.land/x/denops_std@v5.0.0/helper/mod.ts";
import * as fn from "https://deno.land/x/denops_std@v5.0.0/function/mod.ts";

export const treesitter: Plug[] = [
  {
    url: "nvim-treesitter/nvim-treesitter",
    enabled: async (denops: Denops) => await fn.has(denops, "nvim"),
    after: async (denops: Denops) => {
      await execute(
        denops,
        `
        lua << EOB
          require("nvim-treesitter.configs").setup({
            sync_install = false,
            highlight = {
              enable = true,
              additional_vim_regex_highlighting = false,
              disable = function(lang)
                local byte_size = vim.api.nvim_buf_get_offset(0, vim.api.nvim_buf_line_count(0))
                if byte_size > 1024 * 1024 then return true end
                if not pcall(function() vim.treesitter.get_parser(0, lang):parse() end) then return true end
                if not pcall(function() vim.treesitter.query.get(lang, "highlights") end) then return true end
                return false
              end,
            },
          })
        EOB
`,
      );
    },
  },
  {
    url: "nvim-treesitter/nvim-treesitter-context",
    dependencies: [{ url: "nvim-treesitter/nvim-treesitter" }],
    enabled: async (denops: Denops) => await fn.has(denops, "nvim"),
    after: async (denops: Denops) => {
      await denops.call(`luaeval`, `require("treesitter-context").setup()`);
    },
  },
  {
    url: "windwp/nvim-ts-autotag",
    dependencies: [{ url: "nvim-treesitter/nvim-treesitter" }],
    enabled: async (denops: Denops) => await fn.has(denops, "nvim"),
    after: async (denops: Denops) => {
      await denops.call(`luaeval`, `require("nvim-ts-autotag").setup()`);
    },
  },
];
