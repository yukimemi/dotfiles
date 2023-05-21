import type { Denops } from "https://deno.land/x/denops_std@v4.3.3/mod.ts";
import type { Plug } from "https://deno.land/x/dvpm@0.2.4/mod.ts";

import { pluginStatus } from "../main.ts";

export const statusline: Plug[] = [
  {
    url: "rebelot/heirline.nvim",
    enabled: pluginStatus.heirline,
    after: async (denops: Denops) => {
      await denops.call(`luaeval`, `require("heirline").setup(_A.param)`, {
        param: {
          statusline: {},
          winbar: {},
          tabline: {},
          statuscolumn: {},
        },
      });
    },
  },
  {
    url: "nvim-lualine/lualine.nvim",
    enabled: pluginStatus.lualine,
    after: async (denops: Denops) => {
      await denops.call(`luaeval`, `require("lualine").setup(_A.param)`, {
        param: {
          options: {
            icons_enabled: true,
            theme: "auto",
            component_separators: { left: "", right: "" },
            section_separators: { left: "", right: "" },
            disabled_filetypes: {
              statusline: [],
              winbar: [],
            },
            ignore_focus: [],
            always_divide_middle: true,
            globalstatus: false,
            refresh: {
              statusline: 1000,
              tabline: 1000,
              winbar: 1000,
            },
          },
          sections: {
            lualine_a: ["mode"],
            lualine_b: ["branch", "diff", "diagnostics"],
            lualine_c: ["filename"],
            lualine_x: ["encoding", "fileformat", "filetype"],
            lualine_y: ["progress"],
            lualine_z: ["location"],
          },
          inactive_sections: {
            lualine_a: [],
            lualine_b: [],
            lualine_c: ["filename"],
            lualine_x: ["location"],
            lualine_y: [],
            lualine_z: [],
          },
          tabline: [],
          winbar: [],
          inactive_winbar: [],
          extensions: [],
        },
      });
    },
  },
];
