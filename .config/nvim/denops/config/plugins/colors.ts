// =============================================================================
// File        : colors.ts
// Author      : yukimemi
// Last Change : 2025/02/01 13:35:40.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@6.2.0";

import * as fn from "jsr:@denops/std@7.4.0/function";
import * as mapping from "jsr:@denops/std@7.4.0/mapping";
import * as vars from "jsr:@denops/std@7.4.0/variable";

export const colors: Plug[] = [
  { url: "https://github.com/4513ECHO/vim-colors-hatsunemiku", profiles: ["colors"] },
  { url: "https://github.com/AlessandroYorba/Alduin", profiles: ["colors"] },
  { url: "https://github.com/Allianaab2m/penumbra.nvim", profiles: ["colors"] },
  { url: "https://github.com/Badacadabra/vim-archery", profiles: ["colors"] },
  { url: "https://github.com/ChristianChiarulli/nvcode-color-schemes.vim", profiles: ["colors"] },
  { url: "https://github.com/masisz/ashikaga.nvim", profiles: ["colors"] },
  { url: "https://github.com/FrenzyExists/aquarium-vim", profiles: ["colors"] },
  { url: "https://github.com/KeitaNakamura/neodark.vim", profiles: ["colors"] },
  { url: "https://github.com/Matsuuu/pinkmare", profiles: ["colors"] },
  { url: "https://github.com/NLKNguyen/papercolor-theme", profiles: ["colors"] },
  { url: "https://github.com/PHSix/nvim-hybrid", profiles: ["colors"] },
  { url: "https://github.com/RRethy/nvim-base16", profiles: ["colors"] },
  { url: "https://github.com/Rigellute/rigel", profiles: ["default"] },
  { url: "https://github.com/Styzex/Sonomin.nvim", profiles: ["colors"] },
  { url: "https://github.com/adrian5/oceanic-next-vim", profiles: ["colors"] },
  { url: "https://github.com/aereal/vim-colors-japanesque", profiles: ["colors"] },
  { url: "https://github.com/ajlende/atlas.vim", profiles: ["colors"] },
  { url: "https://github.com/aonemd/quietlight.vim", profiles: ["colors"] },
  { url: "https://github.com/archseer/colibri.vim", profiles: ["colors"] },
  { url: "https://github.com/arrow2nd/aqua", profiles: ["colors"] },
  { url: "https://github.com/atrnh/magical-girl-vim", profiles: ["colors"] },
  { url: "https://github.com/ayu-theme/ayu-vim", profiles: ["colors"] },
  { url: "https://github.com/bluz71/vim-nightfly-colors", profiles: ["colors"] },
  { url: "https://github.com/bluz71/vim-nightfly-guicolors", profiles: ["colors"] },
  { url: "https://github.com/catppuccin/nvim", profiles: ["default"] },
  { url: "https://github.com/cocopon/iceberg.vim", profiles: ["colors"] },
  { url: "https://github.com/craftzdog/solarized-osaka.nvim", profiles: ["colors"] },
  { url: "https://github.com/cseelus/vim-colors-lucid", profiles: ["colors"] },
  { url: "https://github.com/daltonmenezes/aura-theme", profiles: ["colors"] },
  { url: "https://github.com/daschw/leaf.nvim", profiles: ["colors"] },
  { url: "https://github.com/doums/darcula", profiles: ["colors"] },
  { url: "https://github.com/dracula/vim", profiles: ["colors"] },
  { url: "https://github.com/drewtempelmeyer/palenight.vim", profiles: ["colors"] },
  { url: "https://github.com/echasnovski/mini.base16", profiles: ["colors"] },
  { url: "https://github.com/eddyekofo94/gruvbox-flat.nvim", profiles: ["colors"] },
  { url: "https://github.com/eihigh/vim-aomi-grayscale", profiles: ["colors"] },
  { url: "https://github.com/ellisonleao/gruvbox.nvim", profiles: ["colors"] },
  { url: "https://github.com/fenetikm/falcon", profiles: ["colors"] },
  { url: "https://github.com/folke/tokyonight.nvim", profiles: ["default"] },
  { url: "https://github.com/gkapfham/vim-vitamin-onec", profiles: ["colors"] },
  { url: "https://github.com/gkeep/iceberg-dark", profiles: ["colors"] },
  { url: "https://github.com/gruvbox-community/gruvbox", profiles: ["colors"] },
  { url: "https://github.com/habamax/vim-gruvbit", profiles: ["colors"] },
  { url: "https://github.com/ingram1107/vim-zhi", profiles: ["colors"] },
  { url: "https://github.com/jonathanfilip/vim-lucius", profiles: ["colors"] },
  { url: "https://github.com/joshdick/onedark.vim", profiles: ["colors"] },
  { url: "https://github.com/jsit/toast.vim", profiles: ["colors"] },
  { url: "https://github.com/kihachi2000/yash.nvim", profiles: ["colors"] },
  { url: "https://github.com/kjssad/quantum.vim", profiles: ["colors"] },
  { url: "https://github.com/kwsp/halcyon-neovim", profiles: ["colors"] },
  { url: "https://github.com/kyoh86/momiji", profiles: ["colors"] },
  { url: "https://github.com/ldelossa/vimdark", profiles: ["colors"] },
  { url: "https://github.com/leviosa42/vim-github-theme", profiles: ["colors"] },
  { url: "https://github.com/lifepillar/vim-solarized8", profiles: ["colors"] },
  { url: "https://github.com/liuchengxu/space-vim-dark", profiles: ["colors"] },
  { url: "https://github.com/liuchengxu/space-vim-theme", profiles: ["colors"] },
  { url: "https://github.com/lourenci/github-colors", profiles: ["colors"] },
  { url: "https://github.com/machakann/vim-colorscheme-kemonofriends", profiles: ["colors"] },
  { url: "https://github.com/machakann/vim-colorscheme-tatami", profiles: ["colors"] },
  { url: "https://github.com/marko-cerovac/material.nvim", profiles: ["colors"] },
  { url: "https://github.com/maxmx03/solarized.nvim", profiles: ["colors"] },
  { url: "https://github.com/miikanissi/modus-themes.nvim", profiles: ["colors"] },
  { url: "https://github.com/nickburlett/vim-colors-stylus", profiles: ["colors"] },
  { url: "https://github.com/nvimdev/oceanic-material", profiles: ["colors"] },
  { url: "https://github.com/nvimdev/zephyr-nvim", profiles: ["colors"] },
  { url: "https://github.com/oxfist/night-owl.nvim", profiles: ["colors"] },
  { url: "https://github.com/pbrisbin/vim-colors-off", profiles: ["colors"] },
  { url: "https://github.com/pineapplegiant/spaceduck", profiles: ["colors"] },
  { url: "https://github.com/polirritmico/monokai-nightasty.nvim", profiles: ["colors"] },
  { url: "https://github.com/projekt0n/caret.nvim", profiles: ["colors"] },
  { url: "https://github.com/projekt0n/github-nvim-theme", profiles: ["colors"] },
  { url: "https://github.com/rafamadriz/neon", profiles: ["colors"] },
  { url: "https://github.com/rafi/awesome-vim-colorschemes", profiles: ["colors"] },
  { url: "https://github.com/rainglow/vim", profiles: ["colors"] },
  { url: "https://github.com/ramojus/mellifluous.nvim", profiles: ["colors"] },
  { url: "https://github.com/ray-x/aurora", profiles: ["colors"] },
  { url: "https://github.com/rebelot/kanagawa.nvim", profiles: ["colors"] },
  { url: "https://github.com/rhysd/vim-color-spring-night", profiles: ["colors"] },
  { url: "https://github.com/romgrk/github-light.vim", profiles: ["colors"] },
  { url: "https://github.com/rose-pine/neovim", profiles: ["colors"] },
  { url: "https://github.com/sainnhe/edge", profiles: ["default"] },
  { url: "https://github.com/sainnhe/gruvbox-material", profiles: ["default"] },
  { url: "https://github.com/savq/melange-nvim", profiles: ["colors"] },
  { url: "https://github.com/severij/vadelma", profiles: ["colors"] },
  { url: "https://github.com/shaunsingh/nord.nvim", profiles: ["colors"] },
  { url: "https://github.com/sho-87/kanagawa-paper.nvim", profiles: ["colors"] },
  { url: "https://github.com/sigmavim/kyotonight", profiles: ["colors"] },
  { url: "https://github.com/srcery-colors/srcery-vim", profiles: ["colors"] },
  { url: "https://github.com/sts10/vim-pink-moon", profiles: ["colors"] },
  { url: "https://github.com/tiagovla/tokyodark.nvim", profiles: ["colors"] },
  { url: "https://github.com/tobi-wan-kenobi/zengarden", profiles: ["colors"] },
  { url: "https://github.com/wadackel/vim-dogrun", profiles: ["colors"] },
  { url: "https://github.com/yasukotelin/shirotelin", profiles: ["colors"] },
  { url: "https://github.com/yorik1984/newpaper.nvim", profiles: ["colors"] },
  { url: "https://github.com/yuttie/hydrangea-vim", profiles: ["colors"] },
  { url: "https://github.com/zacanger/angr.vim", profiles: ["colors"] },
  { url: "https://github.com/zefei/cake16", profiles: ["colors"] },
  { url: "https://github.com/zenbones-theme/zenbones.nvim", profiles: ["colors"] },
  {
    url: "https://github.com/diegoulloao/neofusion.nvim",
    profiles: ["colors"],
    enabled: false,
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("neofusion").setup()`);
    },
  },
  {
    url: "https://github.com/crispybaccoon/evergarden",
    profiles: ["colors"],
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("evergarden").setup(_A)`, {
        transparent_background: true,
        constrast_dark: "medium",
      });
    },
  },
  {
    url: "https://github.com/scottmckendry/cyberdream.nvim",
    profiles: ["colors"],
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
    profiles: ["colors"],
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("flow").setup()`);
    },
  },
  {
    url: "https://github.com/rmehri01/onenord.nvim",
    profiles: ["colors"],
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("onenord").setup()`);
    },
  },
  {
    url: "https://github.com/yukimemi/spectrism.vim",
    profiles: ["default"],
    dependencies: [
      "https://github.com/0xstepit/flow.nvim",
      "https://github.com/4513ECHO/vim-colors-hatsunemiku",
      "https://github.com/AlessandroYorba/Alduin",
      "https://github.com/Allianaab2m/penumbra.nvim",
      "https://github.com/masisz/ashikaga.nvim",
      "https://github.com/Badacadabra/vim-archery",
      "https://github.com/ChristianChiarulli/nvcode-color-schemes.vim",
      "https://github.com/FrenzyExists/aquarium-vim",
      "https://github.com/KeitaNakamura/neodark.vim",
      "https://github.com/Matsuuu/pinkmare",
      "https://github.com/NLKNguyen/papercolor-theme",
      "https://github.com/PHSix/nvim-hybrid",
      "https://github.com/RRethy/nvim-base16",
      "https://github.com/Rigellute/rigel",
      "https://github.com/Styzex/Sonomin.nvim",
      "https://github.com/adrian5/oceanic-next-vim",
      "https://github.com/aereal/vim-colors-japanesque",
      "https://github.com/ajlende/atlas.vim",
      "https://github.com/aonemd/quietlight.vim",
      "https://github.com/archseer/colibri.vim",
      "https://github.com/arrow2nd/aqua",
      "https://github.com/atrnh/magical-girl-vim",
      "https://github.com/ayu-theme/ayu-vim",
      "https://github.com/bluz71/vim-nightfly-colors",
      "https://github.com/bluz71/vim-nightfly-guicolors",
      "https://github.com/catppuccin/nvim",
      "https://github.com/cocopon/iceberg.vim",
      "https://github.com/craftzdog/solarized-osaka.nvim",
      "https://github.com/crispybaccoon/evergarden",
      "https://github.com/cseelus/vim-colors-lucid",
      "https://github.com/daltonmenezes/aura-theme",
      "https://github.com/daschw/leaf.nvim",
      "https://github.com/diegoulloao/neofusion.nvim",
      "https://github.com/doums/darcula",
      "https://github.com/dracula/vim",
      "https://github.com/drewtempelmeyer/palenight.vim",
      "https://github.com/echasnovski/mini.base16",
      "https://github.com/eddyekofo94/gruvbox-flat.nvim",
      "https://github.com/eihigh/vim-aomi-grayscale",
      "https://github.com/ellisonleao/gruvbox.nvim",
      "https://github.com/fenetikm/falcon",
      "https://github.com/folke/tokyonight.nvim",
      "https://github.com/gkapfham/vim-vitamin-onec",
      "https://github.com/gkeep/iceberg-dark",
      "https://github.com/gruvbox-community/gruvbox",
      "https://github.com/habamax/vim-gruvbit",
      "https://github.com/ingram1107/vim-zhi",
      "https://github.com/jonathanfilip/vim-lucius",
      "https://github.com/joshdick/onedark.vim",
      "https://github.com/jsit/toast.vim",
      "https://github.com/kihachi2000/yash.nvim",
      "https://github.com/kjssad/quantum.vim",
      "https://github.com/kwsp/halcyon-neovim",
      "https://github.com/kyoh86/momiji",
      "https://github.com/ldelossa/vimdark",
      "https://github.com/leviosa42/vim-github-theme",
      "https://github.com/lifepillar/vim-solarized8",
      "https://github.com/liuchengxu/space-vim-dark",
      "https://github.com/liuchengxu/space-vim-theme",
      "https://github.com/lourenci/github-colors",
      "https://github.com/machakann/vim-colorscheme-kemonofriends",
      "https://github.com/machakann/vim-colorscheme-tatami",
      "https://github.com/marko-cerovac/material.nvim",
      "https://github.com/maxmx03/solarized.nvim",
      "https://github.com/miikanissi/modus-themes.nvim",
      "https://github.com/nickburlett/vim-colors-stylus",
      "https://github.com/nvimdev/oceanic-material",
      "https://github.com/nvimdev/zephyr-nvim",
      "https://github.com/oxfist/night-owl.nvim",
      "https://github.com/pbrisbin/vim-colors-off",
      "https://github.com/pineapplegiant/spaceduck",
      "https://github.com/polirritmico/monokai-nightasty.nvim",
      "https://github.com/projekt0n/caret.nvim",
      "https://github.com/projekt0n/github-nvim-theme",
      "https://github.com/rafamadriz/neon",
      "https://github.com/rafi/awesome-vim-colorschemes",
      "https://github.com/rainglow/vim",
      "https://github.com/ramojus/mellifluous.nvim",
      "https://github.com/ray-x/aurora",
      "https://github.com/rebelot/kanagawa.nvim",
      "https://github.com/rhysd/vim-color-spring-night",
      "https://github.com/rmehri01/onenord.nvim",
      "https://github.com/romgrk/github-light.vim",
      "https://github.com/rose-pine/neovim",
      "https://github.com/sainnhe/edge",
      "https://github.com/sainnhe/gruvbox-material",
      "https://github.com/savq/melange-nvim",
      "https://github.com/scottmckendry/cyberdream.nvim",
      "https://github.com/severij/vadelma",
      "https://github.com/shaunsingh/nord.nvim",
      "https://github.com/sho-87/kanagawa-paper.nvim",
      "https://github.com/sigmavim/kyotonight",
      "https://github.com/srcery-colors/srcery-vim",
      "https://github.com/sts10/vim-pink-moon",
      "https://github.com/tiagovla/tokyodark.nvim",
      "https://github.com/tobi-wan-kenobi/zengarden",
      "https://github.com/wadackel/vim-dogrun",
      "https://github.com/yasukotelin/shirotelin",
      "https://github.com/yorik1984/newpaper.nvim",
      "https://github.com/yuttie/hydrangea-vim",
      "https://github.com/zacanger/angr.vim",
      "https://github.com/zefei/cake16",
      "https://github.com/zenbones-theme/zenbones.nvim",
    ],
    before: async ({ denops }) => {
      await vars.g.set(denops, "spectrism_debug", false);
      await vars.g.set(denops, "spectrism_echo", false);
      await vars.g.set(denops, "spectrism_notify", true);
      await vars.g.set(denops, "spectrism_interval", 60);
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
        "<space>Rd",
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
