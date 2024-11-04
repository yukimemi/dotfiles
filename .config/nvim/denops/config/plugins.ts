// =============================================================================
// File        : plugins.ts
// Author      : yukimemi
// Last Change : 2024/11/04 22:14:25.
// =============================================================================

import { pluginStatus } from "./pluginstatus.ts";

import { ai } from "./plugins/ai.ts";
import { blink } from "./plugins/blink.ts";
import { bluesky } from "./plugins/bluesky.ts";
import { care } from "./plugins/care.ts";
import { clap } from "./plugins/clap.ts";
import { cmp } from "./plugins/cmp.ts";
import { coc } from "./plugins/coc.ts";
import { colors } from "./plugins/colors.ts";
import { ddc } from "./plugins/ddc.ts";
import { ddu } from "./plugins/ddu.ts";
import { denops } from "./plugins/denops.ts";
import { edit } from "./plugins/edit.ts";
import { fall } from "./plugins/fall.ts";
import { fern } from "./plugins/fern.ts";
import { filetypes } from "./plugins/filetypes.ts";
import { git } from "./plugins/git.ts";
import { libs } from "./plugins/libs.ts";
import { lsp } from "./plugins/lsp.ts";
import { memo } from "./plugins/memo.ts";
import { mini } from "./plugins/mini.ts";
import { motion } from "./plugins/motion.ts";
import { neotree } from "./plugins/neotree.ts";
import { nvimtree } from "./plugins/nvimtree.ts";
import { oil } from "./plugins/oil.ts";
import { operator } from "./plugins/operator.ts";
import { runner } from "./plugins/runner.ts";
import { search } from "./plugins/search.ts";
import { snippet } from "./plugins/snippet.ts";
import { startup } from "./plugins/startup.ts";
import { statusline } from "./plugins/statusline.ts";
import { telescope } from "./plugins/telescope.ts";
import { terminal } from "./plugins/terminal.ts";
import { test } from "./plugins/test.ts";
import { textobj } from "./plugins/textobj.ts";
import { tmux } from "./plugins/tmux.ts";
import { todo } from "./plugins/todo.ts";
import { treesitter } from "./plugins/treesitter.ts";
import { twitter } from "./plugins/twitter.ts";
import { ui } from "./plugins/ui.ts";
import { util } from "./plugins/util.ts";
import { yazi } from "./plugins/yazi.ts";

const plugins = [
  ...ai,
  ...bluesky,
  ...clap,
  ...colors,
  ...denops,
  ...edit,
  ...fall,
  ...filetypes,
  ...filetypes,
  ...git,
  ...libs,
  ...lsp,
  ...memo,
  ...mini,
  ...motion,
  ...neotree,
  ...nvimtree,
  ...oil,
  ...operator,
  ...runner,
  ...search,
  ...snippet,
  ...startup,
  ...statusline,
  ...telescope,
  ...terminal,
  ...test,
  ...textobj,
  ...tmux,
  ...todo,
  ...treesitter,
  ...twitter,
  ...ui,
  ...util,
  ...yazi,
];

if (pluginStatus.ddc) {
  plugins.push(...ddc);
}
if (pluginStatus.coc) {
  plugins.push(...coc);
}
if (pluginStatus.cmp) {
  plugins.push(...cmp);
}
if (pluginStatus.blink) {
  plugins.push(...blink);
}
if (pluginStatus.care) {
  plugins.push(...care);
}
if (pluginStatus.ddu) {
  plugins.push(...ddu);
}
if (pluginStatus.fern) {
  plugins.push(...fern);
}

export { plugins };
