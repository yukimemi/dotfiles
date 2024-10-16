// =============================================================================
// File        : plugins.ts
// Author      : yukimemi
// Last Change : 2024/10/12 20:39:35.
// =============================================================================

import { pluginStatus } from "./pluginstatus.ts";

import { ai } from "./plugins/ai.ts";
import { bluesky } from "./plugins/bluesky.ts";
import { clap } from "./plugins/clap.ts";
import { cmp } from "./plugins/cmp.ts";
import { blink } from "./plugins/blink.ts";
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

const plugins = [
  ...denops,
  ...libs,
  ...git,
  ...memo,
  ...clap,
  ...fall,
  ...tmux,
  ...oil,
  ...ui,
  ...mini,
  ...telescope,
  ...search,
  ...neotree,
  ...nvimtree,
  ...lsp,
  ...treesitter,
  ...todo,
  ...util,
  ...motion,
  ...edit,
  ...textobj,
  ...operator,
  ...statusline,
  ...twitter,
  ...bluesky,
  ...snippet,
  ...terminal,
  ...test,
  ...runner,
  ...filetypes,
  ...startup,
  ...ai,
  ...colors,
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
if (pluginStatus.ddu) {
  plugins.push(...ddu);
}
if (pluginStatus.fern) {
  plugins.push(...fern);
}

export { plugins };
