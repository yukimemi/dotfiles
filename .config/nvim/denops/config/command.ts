// =============================================================================
// File        : command.ts
// Author      : yukimemi
// Last Change : 2024/06/16 20:33:49.
// =============================================================================

import * as lambda from "https://deno.land/x/denops_std@v6.5.1/lambda/mod.ts";
import * as nvimFn from "https://deno.land/x/denops_std@v6.5.1/function/nvim/mod.ts";
import type { Denops } from "https://deno.land/x/denops_std@v6.5.1/mod.ts";
import { batch } from "https://deno.land/x/denops_std@v6.5.1/batch/mod.ts";
import { removeShada, zennCreate, zennPreview } from "./util.ts";
import { z } from "https://deno.land/x/zod@v3.23.8/mod.ts";

export async function setCommandPre(_denops: Denops) {
}

export async function setCommandPost(denops: Denops) {
  await batch(denops, async (denops: Denops) => {
    await nvimFn.nvim_create_user_command(
      denops,
      "RemoveShada",
      `call denops#notify("${denops.name}", "${
        lambda.register(
          denops,
          async () => await removeShada(denops),
        )
      }", [])`,
      {},
    );

    await denops.cmd(`
      command! -nargs=+ ZennCreate call s:${denops.name}_notify("${
      lambda.register(denops, async (title, type) =>
        await zennCreate(denops, z.string().parse(title), z.string().optional().parse(type)))
    }", [<f-args>])
      `);
    await denops.cmd(`
      command! -nargs=0 ZennPreview call s:${denops.name}_notify("${
      lambda.register(denops, async () => await zennPreview(denops))
    }", [<f-args>])
      `);
  });
}
