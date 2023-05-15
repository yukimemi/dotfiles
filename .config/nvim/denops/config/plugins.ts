import { coc } from "./plugins/coc.ts";
import { git } from "./plugins/git.ts";
import { ddu } from "./plugins/ddu.ts";
import { denops } from "./plugins/denops.ts";
import { edit } from "./plugins/edit.ts";
import { libs } from "./plugins/libs.ts";
import { motion } from "./plugins/motion.ts";
import { operator } from "./plugins/operator.ts";
import { textobj } from "./plugins/textobj.ts";
import { treesitter } from "./plugins/treesitter.ts";
import { ui } from "./plugins/ui.ts";
import { util } from "./plugins/util.ts";

export const plugins = [
  ...libs,
  ...ui,
  ...util,
  ...motion,
  ...edit,
  ...git,
  ...coc,
  ...textobj,
  ...operator,
  ...treesitter,
  ...ddu,
  ...denops,
];
