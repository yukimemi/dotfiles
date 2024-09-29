// =============================================================================
// File        : colors.ts
// Author      : yukimemi
// Last Change : 2024/09/29 18:50:44.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@5.0.6";

import * as fn from "jsr:@denops/std@7.2.0/function";
import * as mapping from "jsr:@denops/std@7.2.0/mapping";
import * as vars from "jsr:@denops/std@7.2.0/variable";
import { pluginStatus } from "../pluginstatus.ts";

export const colors: Plug[] = [
  {
    url: "https://github.com/crispybaccoon/evergarden",
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("evergarden").setup(_A)`, {
        transparent_background: true,
        constrast_dark: "medium",
      });
    },
  },
  {
    url: "https://github.com/scottmckendry/cyberdream.nvim",
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("cyberdream").setup(_A)`, {
        transparent: true,
        italic_comments: true,
        hide_fillchars: true,
        boarderless_telescope: true,
      });
    },
  },
  {
    url: "https://github.com/0xstepit/flow.nvim",
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("flow").setup()`);
    },
  },
  {
    url: "https://github.com/rmehri01/onenord.nvim",
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("onenord").setup()`);
    },
  },
  { url: "https://github.com/4513ECHO/vim-colors-hatsunemiku" },
  { url: "https://github.com/AlessandroYorba/Alduin" },
  { url: "https://github.com/Allianaab2m/penumbra.nvim" },
  { url: "https://github.com/ChristianChiarulli/nvcode-color-schemes.vim" },
  { url: "https://github.com/KeitaNakamura/neodark.vim" },
  { url: "https://github.com/Matsuuu/pinkmare" },
  { url: "https://github.com/NLKNguyen/papercolor-theme" },
  { url: "https://github.com/PHSix/nvim-hybrid" },
  { url: "https://github.com/RRethy/nvim-base16" },
  { url: "https://github.com/Rigellute/rigel" },
  { url: "https://github.com/adrian5/oceanic-next-vim" },
  { url: "https://github.com/aereal/vim-colors-japanesque" },
  { url: "https://github.com/arrow2nd/aqua" },
  { url: "https://github.com/ayu-theme/ayu-vim" },
  { url: "https://github.com/bluz71/vim-nightfly-guicolors" },
  { url: "https://github.com/catppuccin/nvim" },
  { url: "https://github.com/cocopon/iceberg.vim" },
  { url: "https://github.com/craftzdog/solarized-osaka.nvim" },
  { url: "https://github.com/cseelus/vim-colors-lucid" },
  { url: "https://github.com/doums/darcula" },
  { url: "https://github.com/drewtempelmeyer/palenight.vim" },
  { url: "https://github.com/ellisonleao/gruvbox.nvim" },
  { url: "https://github.com/fenetikm/falcon" },
  { url: "https://github.com/folke/tokyonight.nvim" },
  { url: "https://github.com/gkeep/iceberg-dark" },
  { url: "https://github.com/joshdick/onedark.vim" },
  { url: "https://github.com/kihachi2000/yash.nvim" },
  { url: "https://github.com/kjssad/quantum.vim" },
  { url: "https://github.com/kyoh86/momiji" },
  { url: "https://github.com/liuchengxu/space-vim-dark" },
  { url: "https://github.com/lourenci/github-colors" },
  { url: "https://github.com/marko-cerovac/material.nvim" },
  { url: "https://github.com/nvimdev/zephyr-nvim" },
  { url: "https://github.com/oxfist/night-owl.nvim" },
  { url: "https://github.com/polirritmico/monokai-nightasty.nvim" },
  { url: "https://github.com/projekt0n/github-nvim-theme" },
  { url: "https://github.com/rafamadriz/neon" },
  { url: "https://github.com/rafi/awesome-vim-colorschemes" },
  { url: "https://github.com/ray-x/aurora" },
  { url: "https://github.com/rebelot/kanagawa.nvim" },
  { url: "https://github.com/rhysd/vim-color-spring-night" },
  { url: "https://github.com/rose-pine/neovim" },
  { url: "https://github.com/sainnhe/edge" },
  { url: "https://github.com/sainnhe/gruvbox-material" },
  { url: "https://github.com/savq/melange-nvim" },
  { url: "https://github.com/severij/vadelma" },
  { url: "https://github.com/sho-87/kanagawa-paper.nvim" },
  { url: "https://github.com/sigmavim/kyotonight" },
  { url: "https://github.com/srcery-colors/srcery-vim" },
  { url: "https://github.com/tiagovla/tokyodark.nvim" },
  { url: "https://github.com/yuttie/hydrangea-vim" },
  {
    url: "https://github.com/yukimemi/spectrism.vim",
    dst: "~/src/github.com/yukimemi/spectrism.vim",
    dependencies: [
      "https://github.com/4513ECHO/vim-colors-hatsunemiku",
      "https://github.com/AlessandroYorba/Alduin",
      "https://github.com/Allianaab2m/penumbra.nvim",
      "https://github.com/ChristianChiarulli/nvcode-color-schemes.vim",
      "https://github.com/KeitaNakamura/neodark.vim",
      "https://github.com/Matsuuu/pinkmare",
      "https://github.com/NLKNguyen/papercolor-theme",
      "https://github.com/PHSix/nvim-hybrid",
      "https://github.com/RRethy/nvim-base16",
      "https://github.com/Rigellute/rigel",
      "https://github.com/adrian5/oceanic-next-vim",
      "https://github.com/aereal/vim-colors-japanesque",
      "https://github.com/arrow2nd/aqua",
      "https://github.com/ayu-theme/ayu-vim",
      "https://github.com/bluz71/vim-nightfly-guicolors",
      "https://github.com/catppuccin/nvim",
      "https://github.com/cocopon/iceberg.vim",
      "https://github.com/craftzdog/solarized-osaka.nvim",
      "https://github.com/cseelus/vim-colors-lucid",
      "https://github.com/doums/darcula",
      "https://github.com/drewtempelmeyer/palenight.vim",
      "https://github.com/ellisonleao/gruvbox.nvim",
      "https://github.com/fenetikm/falcon",
      "https://github.com/folke/tokyonight.nvim",
      "https://github.com/gkeep/iceberg-dark",
      "https://github.com/joshdick/onedark.vim",
      "https://github.com/kihachi2000/yash.nvim",
      "https://github.com/kjssad/quantum.vim",
      "https://github.com/kyoh86/momiji",
      "https://github.com/liuchengxu/space-vim-dark",
      "https://github.com/lourenci/github-colors",
      "https://github.com/marko-cerovac/material.nvim",
      "https://github.com/nvimdev/zephyr-nvim",
      "https://github.com/oxfist/night-owl.nvim",
      "https://github.com/polirritmico/monokai-nightasty.nvim",
      "https://github.com/projekt0n/github-nvim-theme",
      "https://github.com/rafamadriz/neon",
      "https://github.com/rafi/awesome-vim-colorschemes",
      "https://github.com/ray-x/aurora",
      "https://github.com/rebelot/kanagawa.nvim",
      "https://github.com/rhysd/vim-color-spring-night",
      "https://github.com/rose-pine/neovim",
      "https://github.com/sainnhe/edge",
      "https://github.com/sainnhe/gruvbox-material",
      "https://github.com/savq/melange-nvim",
      "https://github.com/severij/vadelma",
      "https://github.com/sho-87/kanagawa-paper.nvim",
      "https://github.com/sigmavim/kyotonight",
      "https://github.com/srcery-colors/srcery-vim",
      "https://github.com/tiagovla/tokyodark.nvim",
      "https://github.com/yuttie/hydrangea-vim",
    ],
    before: async ({ denops }) => {
      await vars.g.set(denops, "spectrism_debug", false);
      await vars.g.set(denops, "spectrism_echo", false);
      await vars.g.set(denops, "spectrism_notify", true);
      await vars.g.set(denops, "spectrism_interval", 300);
      await vars.g.set(denops, "spectrism_checkwait", 1000);
      await vars.g.set(denops, "spectrism_disables", [
        "evening",
        "default",
        "blue",
      ]);
      await vars.g.set(
        denops,
        "spectrism_path",
        await fn.expand(denops, "~/.cache/nvim/spectrism/colorscheme.toml"),
      );
      await vars.g.set(denops, "spectrism_notmatch", "[Ll]ight");
      await vars.g.set(denops, "spectrism_background", "dark");

      await mapping.map(denops, "<space>co", "<cmd>ChangeColorscheme<cr>", {
        mode: "n",
      });
      await mapping.map(
        denops,
        "<space>rd",
        "<cmd>DisableThisColorscheme<cr>",
        { mode: "n" },
      );
      await mapping.map(denops, "ml", "<cmd>LikeThisColorscheme<cr>", {
        mode: "n",
      });
      await mapping.map(denops, "mh", "<cmd>HateThisColorscheme<cr>", {
        mode: "n",
      });
    },
  },
];
