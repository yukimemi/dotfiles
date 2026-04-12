// =============================================================================
// File        : command.ts
// Author      : yukimemi
// Last Change : 2025/09/21 17:22:06.
// =============================================================================

import type { Denops } from "@denops/std";
import { batch } from "@denops/std/batch";
import * as nvimFn from "@denops/std/function/nvim";
import * as lambda from "@denops/std/lambda";
import { z } from "zod";
import { removeShada, restart, zennCreate, zennPreview } from "./util.ts";

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

    await nvimFn.nvim_create_user_command(
      denops,
      "Restart",
      `call denops#notify("${denops.name}", "${
        lambda.register(
          denops,
          async () => await restart(denops),
        )
      }", [])`,
      {},
    );

    await denops.cmd(`
      command! -nargs=+ ZennCreate call s:${denops.name}_notify("${
      lambda.register(denops, async (title, type) =>
        await zennCreate(
          denops,
          z.string().parse(title),
          z.string().optional().parse(type),
        ))
    }", [<f-args>])
      `);
    await denops.cmd(`
      command! -nargs=0 ZennPreview call s:${denops.name}_notify("${
      lambda.register(denops, async () => await zennPreview(denops))
    }", [<f-args>])
      `);
  });
}
