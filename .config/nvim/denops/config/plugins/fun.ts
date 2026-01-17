// =============================================================================
// File        : fun.ts
// Author      : yukimemi
// Last Change : 2026/01/18 00:10:37.
// =============================================================================

import type { Plug } from "@yukimemi/dvpm";

export const fun: Plug[] = [
  {
    url: "https://github.com/frostzt/bongo-cat.nvim",
    profiles: ["fun"],
    lazy: {
      cmd: [
        "BongoCat",
        "BongoCatShow",
        "BongoCatHide",
        "BongoCatStats",
      ],
    },
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("bongo-cat").setup(_A)`, {});
    },
  },
  {
    url: "https://github.com/Abizrh/beastie.nvim",
    profiles: ["fun"],
    lazy: {
      cmd: ["BeastieStart", "BeastieStop", "BeastieSwitch"],
    },
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("beastie").setup()`);
    },
  },
  {
    url: "https://github.com/ikouchiha47/games.nvim",
    profiles: ["fun"],
    lazy: {
      cmd: ["Hangman", "MineSweeper", "Pacman"],
    },
  },
  {
    url: "https://github.com/folke/drop.nvim",
    enabled: true,
    profiles: ["fun"],
    lazy: {
      event: "CursorHold",
    },
    afterFile: "~/.config/nvim/rc/after/drop.lua",
  },
  {
    url: "https://github.com/adelarsq/snake_cursor.nvim",
    enabled: false,
    profiles: ["fun"],
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("snake_cursor").setup()`);
    },
  },
  {
    url: "https://github.com/ryoppippi/bad-apple.vim",
    enabled: false,
    profiles: ["fun"],
  },
  {
    url: "https://github.com/tamton-aquib/zone.nvim",
    enabled: Deno.build.os !== "windows" && false,
    profiles: ["fun"],
    clone: false,
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("zone").setup(_A)`, {
        after: 180,
      });
    },
  },
];

