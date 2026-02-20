// =============================================================================
// File        : pluginstatus.ts
// Author      : yukimemi
// Last Change : 2026/02/08 17:03:13
// =============================================================================

export const features = {
  ai: true,
  colors: true,
  completion: true,
  core: true,
  favoritecolors: true,
  ff: true,
  filer: true,
  filetype: true,
  git: true,
  indent: true,
  detect_indent: true,
  notification: true,
  scroll: true,
  horizontal_motion: true,
  lsp: true,
  mark: true,
  markdown: true,
  memo: true,
  mini: false,
  motion: true,
  operator: true,
  quickfix: true,
  runner: true,
  rust: true,
  search: true,
  snippet: true,
  statusline: true,
  terminal: true,
  test: true,
  textobj: true,
  translate: true,
  treesitter: true,
  twitter: false,
  ui: true,
  yank: true,
  window: true,
};

export type Selections = {
  completion: "blink" | "cmp" | "ddc" | "coc" | "care" | "ix" | "compl";
  ff: "snacks" | "fall" | "ddu" | "telescope" | "clap" | "deck";
  filer: "yazi" | "oil" | "nvimtree" | "neotree" | "fern" | "ddu";
  statusline: "slimline" | "lualine" | "lightline" | "heirline" | "staba";
  snippet: "denippet" | "vsnip";
  test: "vimtest" | "neotest";
  runner: "quickrun" | "overseer" | "zignite";
  pairs: "insx" | "autopairs" | "ultimatepair" | "blink";
  column: "virtcolumn" | "virt_column" | "neocolumn" | "none";
  motion:
    | "flash"
    | "fuzzymotion"
    | "jab"
    | "hellshake"
    | "smartmotion"
    | "initial"
    | "none";
  indent: "snacks" | "indent-blankline" | "hlchunk" | "blink" | "none";
  detect_indent: "findent" | "dansa" | "none";
  notification: "fidget" | "nvim-notify" | "notifier" | "noice" | "none";
  smooth_scroll: "neoscroll" | "smoothie" | "cinnamon" | "none";
  scrollbar: "scrollbar" | "satellite" | "none";
  horizontal_motion:
    | "flash"
    | "quickscope"
    | "eyeliner"
    | "shot-f"
    | "clever-f"
    | "none";
};

export const selections: Selections = {
  completion: "blink",
  ff: "snacks",
  filer: "yazi",
  statusline: "slimline",
  snippet: "denippet",
  test: "vimtest",
  runner: "overseer",
  pairs: "insx",
  column: "virtcolumn",
  motion: "smartmotion",
  indent: "snacks",
  detect_indent: "dansa",
  notification: "noice",
  smooth_scroll: "none",
  scrollbar: "satellite",
  horizontal_motion: "clever-f",
};

export const pluginStatus = {
  augment: false,
  barbar: false,
  barbecue: false,
  betterwhitespace: true,
  bookmarks: false,
  bqf: true,
  bufferline: false,
  buffertabs: false,
  codeium: false,
  ddt: false,
  denops_translate: true,
  difftastic: true,
  diffview: false,
  fusen: true,
  haritsuke: false,
  illuminate: true,
  incline: false,
  mini: false,
  modesearch: false,
  necodeium: false,
  obsidian: false,
  qfpreview: false,
  qfreplace: true,
  quicker: false,
  rosetta: false,
  sg: false,
  snacks: true,
  snipewin: true,
  vimbookmarks: false,
  vimwiki: false,
  vscode: false,
  windowpicker: false,
  windows: false,
  yankround: false,
  yanky: true,
};
