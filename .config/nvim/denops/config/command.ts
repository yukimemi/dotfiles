// =============================================================================
// File        : command.ts
// Author      : yukimemi
// Last Change : 2023/12/17 10:04:59.
// =============================================================================

import * as lambda from "https://deno.land/x/denops_std@v6.4.0/lambda/mod.ts";
import * as nvimFn from "https://deno.land/x/denops_std@v6.4.0/function/nvim/mod.ts";
import type { Denops } from "https://deno.land/x/denops_std@v6.4.0/mod.ts";
import { batch } from "https://deno.land/x/denops_std@v6.4.0/batch/mod.ts";
import { removeShada } from "./util.ts";

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
  });
}
