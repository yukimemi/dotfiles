// =============================================================================
// File        : colors.ts
// Author      : yukimemi
// Last Change : 2026/04/01 00:00:00.
// =============================================================================

import type { Plug } from "@yukimemi/dvpm";

import * as fn from "@denops/std/function";
import * as vars from "@denops/std/variable";

export const colors: Plug[] = [
  {
    url: "https://github.com/0xstepit/flow.nvim",
    profiles: ["colors", "favoritecolors"],
    lazy: { colorscheme: ["flow", "flow-mono"] },
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("flow").setup()`);
    },
  },
  {
    url: "https://github.com/4513ECHO/vim-colors-hatsunemiku",
    profiles: ["colors"],
    lazy: { colorscheme: ["hatsunemiku", "hatsunemiku_light"] },
  },
  {
    url: "https://github.com/AlessandroYorba/Alduin",
    profiles: ["colors"],
    lazy: { colorscheme: "alduin" },
  },
  {
    url: "https://github.com/Allianaab2m/penumbra.nvim",
    profiles: ["colors"],
    lazy: { colorscheme: "penumbra" },
  },
  {
    url: "https://github.com/Badacadabra/vim-archery",
    profiles: ["colors"],
    lazy: { colorscheme: "archery" },
  },
  {
    url: "https://github.com/b0o/Lavi",
    profiles: ["colors"],
    lazy: { colorscheme: "lavi" },
  },
  {
    url: "https://github.com/uhs-robert/oasis.nvim",
    profiles: ["colors"],
    lazy: {
      colorscheme: [
        "oasis",
        "oasis-abyss",
        "oasis-cactus",
        "oasis-canyon",
        "oasis-desert",
        "oasis-dune",
        "oasis-lagoon",
        "oasis-midnight",
        "oasis-mirage",
        "oasis-night",
        "oasis-rose",
        "oasis-sol",
        "oasis-starlight",
        "oasis-twilight",
      ],
    },
  },
  {
    url: "https://github.com/alexpasmantier/hubbamax.nvim",
    profiles: ["colors"],
    lazy: { colorscheme: "hubbamax" },
  },
  {
    url: "https://github.com/jdsimcoe/abstract.vim",
    profiles: ["colors"],
    lazy: { colorscheme: "abstract" },
  },
  {
    url: "https://github.com/ChristianChiarulli/nvcode-color-schemes.vim",
    profiles: ["colors"],
    lazy: {
      colorscheme: [
        "aurora",
        "dracula",
        "gruvbox",
        "lunar",
        "metanoia",
        "nord",
        "nvcode",
        "onedark",
        "palenight",
        "snazzy",
        "xoria",
      ],
    },
  },
  {
    url: "https://github.com/FrenzyExists/aquarium-vim",
    profiles: ["colors"],
    lazy: { colorscheme: "aquarium" },
  },
  {
    url: "https://github.com/KeitaNakamura/neodark.vim",
    profiles: ["colors"],
    lazy: { colorscheme: "neodark" },
  },
  {
    url: "https://github.com/Matsuuu/pinkmare",
    profiles: ["colors", "favoritecolors"],
    lazy: { colorscheme: "pinkmare" },
  },
  {
    url: "https://github.com/NLKNguyen/papercolor-theme",
    profiles: ["colors"],
    lazy: { colorscheme: "PaperColor" },
  },
  {
    url: "https://github.com/PHSix/nvim-hybrid",
    profiles: ["colors"],
    lazy: { colorscheme: "nvim-hybrid" },
  },
  {
    url: "https://github.com/RRethy/nvim-base16",
    profiles: ["colors"],
    lazy: { colorscheme: "base16-*" },
  },
  {
    url: "https://github.com/Rigellute/rigel",
    profiles: ["colors"],
    lazy: { colorscheme: "rigel" },
  },
  {
    url: "https://github.com/Styzex/Sonomin.nvim",
    profiles: ["colors"],
    lazy: { colorscheme: "sonomin" },
  },
  {
    url: "https://github.com/adrian5/oceanic-next-vim",
    profiles: ["colors"],
    lazy: { colorscheme: "oceanicnext" },
  },
  {
    url: "https://github.com/aereal/vim-colors-japanesque",
    profiles: ["colors"],
    lazy: { colorscheme: "japanesque" },
  },
  {
    url: "https://github.com/ajlende/atlas.vim",
    profiles: ["colors"],
    lazy: { colorscheme: "nms" },
  },
  {
    url: "https://github.com/aonemd/quietlight.vim",
    profiles: ["colors"],
    lazy: { colorscheme: "quietlight" },
  },
  {
    url: "https://github.com/archseer/colibri.vim",
    profiles: ["colors"],
    lazy: { colorscheme: "colibri" },
  },
  {
    url: "https://github.com/arrow2nd/aqua",
    profiles: ["colors"],
    lazy: { colorscheme: "aqua" },
  },
  {
    url: "https://github.com/atrnh/magical-girl-vim",
    profiles: ["colors"],
    lazy: { colorscheme: "fruits" },
  },
  {
    url: "https://github.com/ayu-theme/ayu-vim",
    profiles: ["colors"],
    lazy: { colorscheme: "ayu" },
  },
  {
    url: "https://github.com/bluz71/vim-nightfly-colors",
    profiles: ["colors"],
    lazy: { colorscheme: "nightfly" },
  },
  {
    url: "https://github.com/bluz71/vim-nightfly-guicolors",
    profiles: ["colors"],
    lazy: { colorscheme: "nightfly" },
  },
  {
    url: "https://github.com/catppuccin/nvim",
    profiles: ["colors"],
    lazy: {
      colorscheme: [
        "catppuccin",
        "catppuccin-frappe",
        "catppuccin-latte",
        "catppuccin-macchiato",
        "catppuccin-mocha",
        "catppuccin-nvim",
      ],
    },
  },
  {
    url: "https://github.com/cocopon/iceberg.vim",
    profiles: ["colors"],
    lazy: { colorscheme: "iceberg" },
  },
  {
    url: "https://github.com/craftzdog/solarized-osaka.nvim",
    profiles: ["colors"],
    lazy: { colorscheme: ["solarized-osaka", "solarized-osaka-day"] },
  },
  {
    url: "https://github.com/crispybaccoon/evergarden",
    profiles: ["colors"],
    lazy: {
      colorscheme: [
        "evergarden",
        "evergarden-fall",
        "evergarden-spring",
        "evergarden-summer",
        "evergarden-winter",
      ],
    },
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("evergarden").setup(_A)`, {
        transparent_background: true,
        constrast_dark: "medium",
      });
    },
  },
  {
    url: "https://github.com/cseelus/vim-colors-lucid",
    profiles: ["colors"],
    lazy: { colorscheme: "lucid" },
  },
  {
    url: "https://github.com/daltonmenezes/aura-theme",
    profiles: ["colors"],
    lazy: {
      colorscheme: [
        "aura-dark",
        "aura-dark-soft-text",
        "aura-soft-dark",
        "aura-soft-dark-soft-text",
      ],
    },
  },
  {
    url: "https://github.com/daschw/leaf.nvim",
    profiles: ["colors"],
    lazy: { colorscheme: "leaf" },
  },
  {
    url: "https://github.com/diegoulloao/neofusion.nvim",
    enabled: true,
    profiles: ["colors"],
    lazy: { colorscheme: "neofusion" },
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("neofusion").setup()`);
    },
  },
  {
    url: "https://github.com/doums/darcula",
    profiles: ["colors"],
    lazy: { colorscheme: "darcula" },
  },
  {
    url: "https://github.com/dracula/vim",
    profiles: ["colors"],
    lazy: { colorscheme: "dracula" },
  },
  {
    url: "https://github.com/drewtempelmeyer/palenight.vim",
    profiles: ["colors"],
    lazy: { colorscheme: "palenight" },
  },
  {
    url: "https://github.com/echasnovski/mini.base16",
    profiles: ["colors"],
    lazy: { colorscheme: ["minicyan", "minischeme"] },
  },
  {
    url: "https://github.com/eddyekofo94/gruvbox-flat.nvim",
    profiles: ["colors"],
    lazy: { colorscheme: "gruvbox-flat" },
  },
  {
    url: "https://github.com/eihigh/vim-aomi-grayscale",
    profiles: ["colors"],
    lazy: { colorscheme: "aomi-grayscale" },
  },
  {
    url: "https://github.com/ellisonleao/gruvbox.nvim",
    profiles: ["colors"],
    lazy: { colorscheme: "gruvbox" },
  },
  {
    url: "https://github.com/fenetikm/falcon",
    profiles: ["colors"],
    lazy: { colorscheme: "falcon" },
  },
  {
    url: "https://github.com/folke/tokyonight.nvim",
    profiles: ["colors", "favoritecolors"],
    lazy: {
      colorscheme: [
        "tokyonight",
        "tokyonight-day",
        "tokyonight-moon",
        "tokyonight-night",
        "tokyonight-storm",
      ],
    },
  },
  {
    url: "https://github.com/futsuuu/vim-robot",
    profiles: ["colors"],
    lazy: { colorscheme: "robot" },
  },
  {
    url: "https://github.com/gkapfham/vim-vitamin-onec",
    profiles: ["colors"],
    lazy: { colorscheme: "vitaminonec" },
  },
  {
    url: "https://github.com/gkeep/iceberg-dark",
    profiles: ["colors"],
    lazy: { colorscheme: "iceberg-dark" },
  },
  {
    url: "https://github.com/maxmx03/fluoromachine.nvim",
    profiles: ["colors"],
    lazy: { colorscheme: ["fluoromachine", "delta", "retrowave"] },
  },
  {
    url: "https://github.com/gruvbox-community/gruvbox",
    profiles: ["colors"],
    lazy: { colorscheme: "gruvbox" },
  },
  {
    url: "https://github.com/habamax/vim-gruvbit",
    profiles: ["colors"],
    lazy: { colorscheme: "gruvbit" },
  },
  {
    url: "https://github.com/ingram1107/vim-zhi",
    profiles: ["colors"],
    lazy: { colorscheme: "zhi" },
  },
  {
    url: "https://github.com/jonathanfilip/vim-lucius",
    profiles: ["colors"],
    lazy: { colorscheme: "lucius" },
  },
  {
    url: "https://github.com/joshdick/onedark.vim",
    profiles: ["colors"],
    lazy: { colorscheme: "onedark" },
  },
  {
    url: "https://github.com/jsit/toast.vim",
    profiles: ["colors"],
    lazy: { colorscheme: "toast" },
  },
  {
    url: "https://github.com/kihachi2000/yash.nvim",
    profiles: ["colors"],
    lazy: { colorscheme: "yash" },
  },
  {
    url: "https://github.com/kjssad/quantum.vim",
    profiles: ["colors"],
    lazy: { colorscheme: "quantum" },
  },
  {
    url: "https://github.com/kwsp/halcyon-neovim",
    profiles: ["colors"],
    lazy: { colorscheme: "halcyon" },
  },
  {
    url: "https://github.com/kyoh86/momiji",
    profiles: ["colors"],
    lazy: { colorscheme: "momiji" },
  },
  {
    url: "https://github.com/ldelossa/vimdark",
    profiles: ["colors"],
    lazy: { colorscheme: ["vimdark", "vimlight"] },
  },
  {
    url: "https://github.com/leviosa42/vim-github-theme",
    profiles: ["colors"],
    lazy: {
      colorscheme: [
        "github",
        "github_dark",
        "github_dark_colorbind",
        "github_dark_dimmed",
        "github_dark_high_contrast",
        "github_dark_tritanopia",
        "github_light",
        "github_light_colorbind",
        "github_light_high_contrast",
        "github_light_tritanopia",
      ],
    },
  },
  {
    url: "https://github.com/Pearljak/terracotta.nvim",
    profiles: ["colors"],
    lazy: { colorscheme: "terracotta" },
  },
  {
    url: "https://github.com/lifepillar/vim-solarized8",
    profiles: ["colors"],
    lazy: {
      colorscheme: [
        "solarized8",
        "solarized8_flat",
        "solarized8_high",
        "solarized8_low",
      ],
    },
  },
  {
    url: "https://github.com/liuchengxu/space-vim-dark",
    profiles: ["colors"],
    lazy: { colorscheme: "space-vim-dark" },
  },
  {
    url: "https://github.com/liuchengxu/space-vim-theme",
    profiles: ["colors"],
    lazy: { colorscheme: "space_vim_theme" },
  },
  {
    url: "https://github.com/lourenci/github-colors",
    profiles: ["colors"],
    lazy: { colorscheme: "github-colors" },
  },
  {
    url: "https://github.com/machakann/vim-colorscheme-kemonofriends",
    profiles: ["colors"],
    lazy: { colorscheme: "kemonofriends" },
  },
  {
    url: "https://github.com/machakann/vim-colorscheme-tatami",
    profiles: ["colors"],
    lazy: { colorscheme: "tatami" },
  },
  {
    url: "https://github.com/marko-cerovac/material.nvim",
    profiles: ["colors"],
    lazy: {
      colorscheme: [
        "material",
        "material-darker",
        "material-deep-ocean",
        "material-lighter",
        "material-oceanic",
        "material-palenight",
      ],
    },
  },
  {
    url: "https://github.com/maxmx03/solarized.nvim",
    profiles: ["colors"],
    lazy: { colorscheme: "solarized" },
  },
  {
    url: "https://github.com/miikanissi/modus-themes.nvim",
    profiles: ["colors"],
    lazy: { colorscheme: ["modus", "modus_operandi", "modus_vivendi"] },
  },
  {
    url: "https://github.com/monaqa/colorimetry.nvim",
    profiles: ["colors"],
    lazy: { colorscheme: "colorimetry" },
  },
  {
    url: "https://github.com/neko-night/nvim",
    profiles: ["colors"],
    lazy: {
      colorscheme: [
        "nekonight",
        "nekonight-arcdark",
        "nekonight-aurora",
        "nekonight-day",
        "nekonight-deep-ocean",
        "nekonight-doom-one",
        "nekonight-dracula",
        "nekonight-dracula-at-night",
        "nekonight-fire-obsidian",
        "nekonight-gruvbox",
        "nekonight-mars",
        "nekonight-material-theme",
        "nekonight-moon",
        "nekonight-moonlight",
        "nekonight-night",
        "nekonight-noctis-uva",
        "nekonight-nord",
        "nekonight-onedark",
        "nekonight-onedark-deep",
        "nekonight-palenight",
        "nekonight-shades-of-purple",
        "nekonight-shades-of-purple-dark",
        "nekonight-sky-blue",
        "nekonight-space",
        "nekonight-storm",
        "nekonight-synthwave",
        "nekonight-zenburn",
      ],
    },
  },
  {
    url: "https://github.com/nickburlett/vim-colors-stylus",
    profiles: ["colors"],
    lazy: { colorscheme: "stylus" },
  },
  {
    url: "https://github.com/nvimdev/oceanic-material",
    profiles: ["colors", "favoritecolors"],
    lazy: { colorscheme: "oceanic_material" },
  },
  {
    url: "https://github.com/nvimdev/zephyr-nvim",
    profiles: ["colors"],
    lazy: { colorscheme: "zephyr" },
  },
  {
    url: "https://github.com/oxidescheme/nvim",
    profiles: ["colors"],
    lazy: { colorscheme: "oxide" },
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("oxide").setup()`);
    },
  },
  {
    url: "https://github.com/oxfist/night-owl.nvim",
    profiles: ["colors"],
    lazy: { colorscheme: "night-owl" },
  },
  {
    url: "https://github.com/pbrisbin/vim-colors-off",
    profiles: ["colors"],
    lazy: { colorscheme: "off" },
  },
  {
    url: "https://github.com/pineapplegiant/spaceduck",
    profiles: ["colors"],
    lazy: { colorscheme: "spaceduck" },
  },
  {
    url: "https://github.com/loctvl842/monokai-pro.nvim",
    profiles: ["colors"],
    lazy: {
      colorscheme: [
        "monokai-pro",
        "monokai-pro-classic",
        "monokai-pro-light",
        "monokai-pro-machine",
        "monokai-pro-octagon",
        "monokai-pro-ristretto",
        "monokai-pro-spectrum",
      ],
    },
  },
  {
    url: "https://github.com/polirritmico/monokai-nightasty.nvim",
    profiles: ["colors"],
    lazy: { colorscheme: ["monokai-nightasty", "dark", "light"] },
  },
  {
    url: "https://github.com/projekt0n/caret.nvim",
    profiles: ["colors"],
    lazy: { colorscheme: "caret" },
  },
  {
    url: "https://github.com/projekt0n/github-nvim-theme",
    profiles: ["colors"],
    lazy: {
      colorscheme: [
        "github_dark",
        "github_dark_colorblind",
        "github_dark_default",
        "github_dark_dimmed",
        "github_dark_high_contrast",
        "github_dark_tritanopia",
        "github_light",
        "github_light_colorblind",
        "github_light_default",
        "github_light_high_contrast",
        "github_light_tritanopia",
      ],
    },
  },
  {
    url: "https://github.com/rafamadriz/neon",
    profiles: ["colors"],
    lazy: { colorscheme: "neon" },
  },
  {
    url: "https://github.com/rafi/awesome-vim-colorschemes",
    profiles: ["colors"],
    lazy: {
      colorscheme: [
        "256_noir",
        "OceanicNext",
        "OceanicNextLight",
        "abstract",
        "afterglow",
        "alduin",
        "anderson",
        "angr",
        "apprentice",
        "archery",
        "atom",
        "ayu",
        "carbonized-dark",
        "carbonized-light",
        "challenger_deep",
        "deep-space",
        "deus",
        "dogrun",
        "flattened_dark",
        "flattened_light",
        "focuspoint",
        "fogbell",
        "fogbell_light",
        "fogbell_lite",
        "github",
        "gotham",
        "gotham256",
        "gruvbox",
        "happy_hacking",
        "hybrid",
        "hybrid_material",
        "hybrid_reverse",
        "iceberg",
        "jellybeans",
        "lightning",
        "lucid",
        "lucius",
        "materialbox",
        "meta5",
        "minimalist",
        "molokai",
        "molokayo",
        "mountaineer",
        "mountaineer-grey",
        "mountaineer-light",
        "nord",
        "one",
        "one-dark",
        "onedark",
        "onehalfdark",
        "onehalflight",
        "orange-moon",
        "orbital",
        "PaperColor",
        "paramount",
        "parsec",
        "pink-moon",
        "purify",
        "pyte",
        "rdark-terminal2",
        "scheakur",
        "seoul256",
        "seoul256-light",
        "sierra",
        "snow",
        "solarized8",
        "solarized8_flat",
        "solarized8_high",
        "solarized8_low",
        "sonokai",
        "space-vim-dark",
        "spacecamp",
        "spacecamp_lite",
        "stellarized",
        "sunbather",
        "tender",
        "termschool",
        "twilight256",
        "two-firewatch",
        "wombat256mod",
        "yellow-moon",
      ],
    },
  },
  {
    url: "https://github.com/rainglow/vim",
    profiles: ["colors"],
    lazy: { colorscheme: "*" },
  },
  {
    url: "https://github.com/ramojus/mellifluous.nvim",
    profiles: ["colors"],
    lazy: { colorscheme: ["mellifluous", "shades"] },
  },
  {
    url: "https://github.com/ray-x/aurora",
    profiles: ["colors"],
    lazy: { colorscheme: "aurora" },
  },
  {
    url: "https://github.com/rebelot/kanagawa.nvim",
    profiles: ["colors"],
    lazy: {
      colorscheme: [
        "kanagawa",
        "kanagawa-dragon",
        "kanagawa-lotus",
        "kanagawa-wave",
      ],
    },
  },
  {
    url: "https://github.com/rhysd/vim-color-spring-night",
    profiles: ["colors", "favoritecolors"],
    lazy: { colorscheme: "spring-night" },
  },
  {
    url: "https://github.com/rmehri01/onenord.nvim",
    profiles: ["colors"],
    lazy: { colorscheme: ["onenord", "onenord-light", "onenordlight"] },
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require("onenord").setup()`);
    },
  },
  {
    url: "https://github.com/romgrk/github-light.vim",
    profiles: ["colors"],
    lazy: { colorscheme: "github-light" },
  },
  {
    url: "https://github.com/rose-pine/neovim",
    profiles: ["colors", "favoritecolors"],
    lazy: {
      colorscheme: [
        "rose-pine",
        "rose-pine-dawn",
        "rose-pine-main",
        "rose-pine-moon",
      ],
    },
  },
  {
    url: "https://github.com/sainnhe/edge",
    profiles: ["colors", "favoritecolors"],
    lazy: { colorscheme: "edge" },
  },
  {
    url: "https://github.com/sainnhe/gruvbox-material",
    profiles: ["colors", "favoritecolors"],
    lazy: { colorscheme: "gruvbox-material" },
  },
  {
    url: "https://github.com/savq/melange-nvim",
    profiles: ["colors"],
    lazy: { colorscheme: "melange" },
  },
  {
    url: "https://github.com/scottmckendry/cyberdream.nvim",
    profiles: ["colors"],
    lazy: { colorscheme: ["cyberdream", "cyberdream-light"] },
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
    url: "https://github.com/severij/vadelma",
    profiles: ["colors"],
    lazy: { colorscheme: "vadelma" },
  },
  {
    url: "https://github.com/shaunsingh/nord.nvim",
    profiles: ["colors"],
    lazy: { colorscheme: "nord" },
  },
  {
    url: "https://github.com/sho-87/kanagawa-paper.nvim",
    profiles: ["colors"],
    lazy: {
      colorscheme: [
        "kanagawa-paper",
        "kanagawa-paper-canvas",
        "kanagawa-paper-ink",
      ],
    },
  },
  {
    url: "https://github.com/sigmavim/kyotonight",
    profiles: ["colors", "favoritecolors"],
    lazy: { colorscheme: "kyotonight" },
  },
  {
    url: "https://github.com/sponkurtus2/angelic.nvim",
    profiles: ["colors", "favoritecolors"],
    lazy: { colorscheme: "angelic" },
  },
  {
    url: "https://github.com/srcery-colors/srcery-vim",
    profiles: ["colors"],
    lazy: { colorscheme: "srcery" },
  },
  {
    url: "https://github.com/sts10/vim-pink-moon",
    profiles: ["colors"],
    lazy: { colorscheme: ["pink-moon", "orange-moon", "yellow-moon"] },
  },
  {
    url: "https://github.com/Styzex/Sonomin.nvim",
    profiles: ["colors"],
    lazy: { colorscheme: "sonomin" },
  },
  {
    url: "https://github.com/tiagovla/tokyodark.nvim",
    profiles: ["colors"],
    lazy: { colorscheme: "tokyodark" },
  },
  {
    url: "https://github.com/tobi-wan-kenobi/zengarden",
    profiles: ["colors"],
    lazy: { colorscheme: "zengarden" },
  },
  {
    url: "https://github.com/wadackel/vim-dogrun",
    profiles: ["colors"],
    lazy: { colorscheme: "dogrun" },
  },
  {
    url: "https://github.com/yasukotelin/shirotelin",
    profiles: ["colors"],
    lazy: { colorscheme: "shirotelin" },
  },
  {
    url: "https://github.com/yazeed1s/oh-lucy.nvim",
    profiles: ["colors"],
    lazy: { colorscheme: ["oh-lucy", "oh-lucy-evening"] },
  },
  {
    url: "https://github.com/yorik1984/newpaper.nvim",
    profiles: ["colors"],
    lazy: { colorscheme: "newpaper" },
  },
  {
    url: "https://github.com/yuttie/hydrangea-vim",
    profiles: ["colors"],
    lazy: { colorscheme: "hydrangea" },
  },
  {
    url: "https://github.com/zacanger/angr.vim",
    profiles: ["colors"],
    lazy: { colorscheme: "angr" },
  },
  {
    url: "https://github.com/zefei/cake16",
    profiles: ["colors"],
    lazy: { colorscheme: "cake16" },
  },
  {
    url: "https://github.com/zenbones-theme/zenbones.nvim",
    profiles: ["colors"],
    lazy: {
      colorscheme: [
        "duckbones",
        "forestbones",
        "kanagawabones",
        "neobones",
        "nordbones",
        "randombones",
        "randombones_dark",
        "randombones_light",
        "rosebones",
        "seoulbones",
        "tokyobones",
        "vimbones",
        "zenbones",
        "zenburned",
        "zenwritten",
      ],
    },
  },
  {
    url: "https://github.com/yukimemi/lumiris.vim",
    profiles: ["colors", "favoritecolors", "core"],
    lazy: {
      cmd: [
        "ChangeColorscheme",
        "LikeThisColorscheme",
        "HateThisColorscheme",
        "DisableThisColorscheme",
        "OpenColorschemeSetting",
      ],
      keys: [
        {
          lhs: "<space>co",
          rhs: "<cmd>ChangeColorscheme<cr>",
          mode: "n",
          desc: "ChangeColorscheme",
        },
        {
          lhs: "<space>Rd",
          rhs: "<cmd>DisableThisColorscheme<cr>",
          mode: "n",
          desc: "DisableThisColorscheme",
        },
        {
          lhs: "mL",
          rhs: "<cmd>LikeThisColorscheme<cr>",
          mode: "n",
          desc: "LikeThisColorscheme",
        },
        {
          lhs: "mh",
          rhs: "<cmd>HateThisColorscheme<cr>",
          mode: "n",
          desc: "HateThisColorscheme",
        },
      ],
      event: "CursorHold",
    },
    dependencies: [],
    before: async ({ denops }) => {
      await vars.g.set(denops, "lumiris_debug", false);
      await vars.g.set(denops, "lumiris_echo", false);
      await vars.g.set(denops, "lumiris_notify", true);
      await vars.g.set(denops, "lumiris_interval", 3600);
      await vars.g.set(denops, "lumiris_checkwait", 3000);
      await vars.g.set(denops, "lumiris_disables", [
        "evening",
        "default",
        "blue",
      ]);
      await vars.g.set(
        denops,
        "lumiris_path",
        await fn.expand(denops, "~/.cache/nvim/lumiris/colorscheme.toml"),
      );
      await vars.g.set(denops, "lumiris_notmatch", "[Ll]ight");
      await vars.g.set(denops, "lumiris_background", "dark");
      await vars.g.set(denops, "lumiris_colors_path", [
        await fn.expand(denops, "~/.cache/nvim/dvpm/github.com"),
      ]);
    },
  },
];
