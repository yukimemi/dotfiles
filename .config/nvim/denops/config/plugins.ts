// import { ddc } from "./plugins/ddc.ts";
import { coc } from "./plugins/coc.ts";
import { ddu } from "./plugins/ddu.ts";
import { denops } from "./plugins/denops.ts";
import { edit } from "./plugins/edit.ts";
import { fern } from "./plugins/fern.ts";
import { libs } from "./plugins/libs.ts";
// import { lsp } from "./plugins/lsp.ts";
import { motion } from "./plugins/motion.ts";
import { operator } from "./plugins/operator.ts";
import { textobj } from "./plugins/textobj.ts";
import { treesitter } from "./plugins/treesitter.ts";
import { ui } from "./plugins/ui.ts";
import { util } from "./plugins/util.ts";

export * from "./plugins/types.ts";

export const plugins = [
  ...libs,
  ...fern,
  ...ui,
  ...util,
  ...motion,
  ...edit,
  ...coc,
  // ...lsp,
  ...textobj,
  ...operator,
  ...treesitter,
  // ...ddc,
  ...ddu,
  ...denops,
];
