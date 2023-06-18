import { coc } from "./plugins/coc.ts";
import { ddc } from "./plugins/ddc.ts";
import { ddu } from "./plugins/ddu.ts";
import { test } from "./plugins/test.ts";
import { denops } from "./plugins/denops.ts";
import { edit } from "./plugins/edit.ts";
import { fern } from "./plugins/fern.ts";
import { filetypes } from "./plugins/filetypes.ts";
import { git } from "./plugins/git.ts";
import { libs } from "./plugins/libs.ts";
import { lsp } from "./plugins/lsp.ts";
import { motion } from "./plugins/motion.ts";
import { operator } from "./plugins/operator.ts";
import { search } from "./plugins/search.ts";
import { statusline } from "./plugins/statusline.ts";
import { telescope } from "./plugins/telescope.ts";
import { terminal } from "./plugins/terminal.ts";
import { textobj } from "./plugins/textobj.ts";
import { treesitter } from "./plugins/treesitter.ts";
import { twitter } from "./plugins/twitter.ts";
import { ui } from "./plugins/ui.ts";
import { util } from "./plugins/util.ts";

export const plugins = [
  ...libs,
  ...ddu,
  ...coc,
  ...telescope,
  ...search,
  ...fern,
  ...ddc,
  ...lsp,
  ...treesitter,
  ...util,
  ...motion,
  ...edit,
  ...git,
  ...textobj,
  ...operator,
  ...denops,
  ...ui,
  ...statusline,
  ...twitter,
  ...terminal,
  ...test,
  ...filetypes,
];
