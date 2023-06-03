import type { Denops } from "https://deno.land/x/denops_std@v5.0.0/mod.ts";

import { batch } from "https://deno.land/x/denops_std@v5.0.0/batch/mod.ts";
import * as autocmd from "https://deno.land/x/denops_std@v5.0.0/autocmd/mod.ts";
import * as vars from "https://deno.land/x/denops_std@v5.0.0/variable/mod.ts";

export async function setFiletype(denops: Denops) {
  await batch(denops, async (denops: Denops) => {
    await vars.g.set(denops, "xml_syntax_folding", 1);
    await autocmd.group(denops, "MyXml", (helper) => {
      helper.remove("*");
      helper.define("FileType", "xml", "setl foldmethod=syntax");
    });
  });
}
