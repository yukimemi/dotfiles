// =============================================================================
// File        : statusline.ts
// Author      : yukimemi
// Last Change : 2025/09/07 10:34:08.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@7.1.1";

import { pluginStatus } from "../pluginstatus.ts";
import * as vars from "jsr:@denops/std@8.0.0/variable";

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
    profiles: ["statusline"],
    enabled: pluginStatus.lualine,
  },
  {
    url: "https://github.com/nvim-lualine/lualine.nvim",
    profiles: ["statusline"],
    enabled: pluginStatus.lualine,
    dependencies: [
      "https://github.com/pnx/lualine-lsp-status",
    ],
    afterFile: `~/.config/nvim/rc/after/lualine.lua`,
  },
  {
    url: "https://github.com/itchyny/lightline.vim",
    profiles: ["statusline"],
    enabled: pluginStatus.lightline,
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
    profiles: ["statusline"],
    enabled: pluginStatus.staba,
    afterFile: `~/.config/nvim/rc/after/staba.lua`,
  },
  {
    url: "https://github.com/sschleemilch/slimline.nvim",
    profiles: ["statusline"],
    enabled: pluginStatus.slimline,
    afterFile: `~/.config/nvim/rc/after/slimline.lua`,
  },
];
