// =============================================================================
// File        : plugins.ts
// Author      : yukimemi
// Last Change : 2023/12/30 19:37:08.
// =============================================================================

import { cmp } from "./plugins/cmp.ts";
import { coc } from "./plugins/coc.ts";
import { ddc } from "./plugins/ddc.ts";
import { ddu } from "./plugins/ddu.ts";
import { denops } from "./plugins/denops.ts";
import { edit } from "./plugins/edit.ts";
import { fern } from "./plugins/fern.ts";
import { filetypes } from "./plugins/filetypes.ts";
import { git } from "./plugins/git.ts";
import { libs } from "./plugins/libs.ts";
import { lsp } from "./plugins/lsp.ts";
import { mini } from "./plugins/mini.ts";
import { motion } from "./plugins/motion.ts";
import { neotree } from "./plugins/neotree.ts";
import { nvimtree } from "./plugins/nvimtree.ts";
import { operator } from "./plugins/operator.ts";
import { search } from "./plugins/search.ts";
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
import { startup } from "./plugins/startup.ts";
import { util } from "./plugins/util.ts";
import { memo } from "./plugins/memo.ts";

export const plugins = [
  ...denops,
  ...libs,
  ...memo,
  ...ddu,
  ...tmux,
  ...coc,
  ...mini,
  ...telescope,
  ...search,
  ...fern,
  ...neotree,
  ...nvimtree,
  ...ddc,
  ...cmp,
  ...lsp,
  ...treesitter,
  ...todo,
  ...util,
  ...motion,
  ...edit,
  ...git,
  ...textobj,
  ...operator,
  ...ui,
  ...statusline,
  ...twitter,
  ...terminal,
  ...test,
  ...filetypes,
  ...startup,
];
