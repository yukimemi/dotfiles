// =============================================================================
// File        : statusline.ts
// Author      : yukimemi
// Last Change : 2025/09/21 17:11:53.
// =============================================================================

import type { Plug } from "@yukimemi/dvpm";

import * as vars from "@denops/std/variable";
import { pluginStatus } from "../pluginstatus.ts";

export const statusline: Plug[] = [
  {
    url: "https://github.com/rebelot/heirline.nvim",
    enabled: pluginStatus.heirline,
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("heirline").setup(_A)`, {
        statusline: {},
        winbar: {},
        tabline: {},
        statuscolumn: {},
      });
    },
  },
  {
    url: "https://github.com/pnx/lualine-lsp-status",
    enabled: pluginStatus.lualine,
    profiles: ["statusline"],
  },
  {
    url: "https://github.com/nvim-lualine/lualine.nvim",
    enabled: pluginStatus.lualine,
    profiles: ["statusline"],
    dependencies: [
      "https://github.com/pnx/lualine-lsp-status",
    ],
    afterFile: `~/.config/nvim/rc/after/lualine.lua`,
  },
  {
    url: "https://github.com/itchyny/lightline.vim",
    enabled: pluginStatus.lightline,
    profiles: ["statusline"],
    before: async ({ denops }) => {
      await vars.g.set(denops, "lightline", {
        colorscheme: "rosepine",
        active: {
          left: [
            ["mode", "paste"],
            ["colorscheme", "bomb"],
            ["gitbranch", "readonly", "filename", "modified"],
          ],
          right: [
            ["lineinfo"],
            ["percent"],
            ["fileformat", "fileencoding", "filetype"],
          ],
        },
        inactive: {
          left: [
            ["mode"],
            ["gitbranch", "filename", "modified"],
          ],
          right: [
            ["fileformat", "fileencoding", "filetype"],
          ],
        },
        component: {
          bomb: '%{&bomb?"BOM":""}',
          readonly: '%{&readonly?"RO":""}',
          modified: '%{&modified?"+":""}',
          colorscheme: "%{g:colors_name}",
        },
      });
    },
  },
  {
    url: "https://github.com/tar80/staba.nvim",
    enabled: pluginStatus.staba,
    profiles: ["statusline"],
    afterFile: `~/.config/nvim/rc/after/staba.lua`,
  },
  {
    url: "https://github.com/sschleemilch/slimline.nvim",
    enabled: pluginStatus.slimline,
    profiles: ["statusline", "core"],
    afterFile: `~/.config/nvim/rc/after/slimline.lua`,
  },
];
