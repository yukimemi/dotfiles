// =============================================================================
// File        : filetype.ts
// Author      : yukimemi
// Last Change : 2025/09/21 17:21:16.
// =============================================================================

import type { Denops } from "@denops/std";

import { batch } from "@denops/std/batch";
import * as autocmd from "@denops/std/autocmd";
import * as vars from "@denops/std/variable";

export async function setFiletype(denops: Denops) {
  await batch(denops, async (denops: Denops) => {
    await vars.g.set(denops, "xml_syntax_folding", 1);
    await autocmd.group(denops, "MyXml", (helper) => {
      helper.remove("*");
      helper.define("FileType", "xml", "setl foldmethod=syntax");
    });
  });
}
