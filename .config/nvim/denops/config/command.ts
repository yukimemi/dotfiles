// =============================================================================
// File        : command.ts
// Author      : yukimemi
// Last Change : 2024/06/16 20:33:49.
// =============================================================================

import * as lambda from "jsr:@denops/std@7.6.0/lambda";
import * as nvimFn from "jsr:@denops/std@7.6.0/function/nvim";
import type { Denops } from "jsr:@denops/std@7.6.0";
import { batch } from "jsr:@denops/std@7.6.0/batch";
import { removeShada, zennCreate, zennPreview } from "./util.ts";
import { z } from "npm:zod@4.0.17";

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
