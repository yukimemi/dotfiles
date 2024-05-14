// =============================================================================
// File        : filetype.ts
// Author      : yukimemi
// Last Change : 2023/07/16 00:39:11.
// =============================================================================

import type { Denops } from "https://deno.land/x/denops_std@v6.4.3/mod.ts";

import { batch } from "https://deno.land/x/denops_std@v6.4.3/batch/mod.ts";
import * as autocmd from "https://deno.land/x/denops_std@v6.4.3/autocmd/mod.ts";
import * as vars from "https://deno.land/x/denops_std@v6.4.3/variable/mod.ts";

export async function setFiletype(denops: Denops) {
  await batch(denops, async (denops: Denops) => {
    await vars.g.set(denops, "xml_syntax_folding", 1);
    await autocmd.group(denops, "MyXml", (helper) => {
      helper.remove("*");
      helper.define("FileType", "xml", "setl foldmethod=syntax");
    });
  });
}
