// =============================================================================
// File        : plugins.ts
// Author      : yukimemi
// Last Change : 2026/01/17 21:47:07.
// =============================================================================

import type { Plug } from "@yukimemi/dvpm";
import { ai } from "./plugins/ai.ts";
import { blink } from "./plugins/blink.ts";
import { bluesky } from "./plugins/bluesky.ts";
import { care } from "./plugins/care.ts";
import { clap } from "./plugins/clap.ts";
import { cmp } from "./plugins/cmp.ts";
import { coc } from "./plugins/coc.ts";
import { colors } from "./plugins/colors.ts";
import { compl } from "./plugins/compl.ts";
import { ddc } from "./plugins/ddc.ts";
import { ddu } from "./plugins/ddu.ts";
import { deck } from "./plugins/deck.ts";
import { denops } from "./plugins/denops.ts";
import { edit } from "./plugins/edit.ts";
import { fall } from "./plugins/fall.ts";
import { fern } from "./plugins/fern.ts";
import { filetypes } from "./plugins/filetypes.ts";
import { git } from "./plugins/git.ts";
import { ix } from "./plugins/ix.ts";
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
import { snacks } from "./plugins/snacks.ts";
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

export const plugins: Plug[] = [
  ...ai,
  ...blink,
  ...bluesky,
  ...care,
  ...clap,
  ...cmp,
  ...coc,
  ...colors,
  ...compl,
  ...ddc,
  ...ddu,
  ...deck,
  ...denops,
  ...edit,
  ...fall,
  ...fern,
  ...filetypes,
  ...git,
  ...ix,
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
  ...snacks,
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
