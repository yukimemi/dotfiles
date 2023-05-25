import { coc } from "./plugins/coc.ts";
import { ddu } from "./plugins/ddu.ts";
import { denops } from "./plugins/denops.ts";
import { edit } from "./plugins/edit.ts";
import { filetypes } from "./plugins/filetypes.ts";
import { git } from "./plugins/git.ts";
import { libs } from "./plugins/libs.ts";
import { motion } from "./plugins/motion.ts";
import { operator } from "./plugins/operator.ts";
import { statusline } from "./plugins/statusline.ts";
import { terminal } from "./plugins/terminal.ts";
import { textobj } from "./plugins/textobj.ts";
import { treesitter } from "./plugins/treesitter.ts";
import { ui } from "./plugins/ui.ts";
import { util } from "./plugins/util.ts";

export const plugins = [
  ...libs,
  ...coc,
  ...ddu,
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
  ...terminal,
  ...filetypes,
];
