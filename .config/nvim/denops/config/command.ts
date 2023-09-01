// =============================================================================
// File        : command.ts
// Author      : yukimemi
// Last Change : 2023/09/01 20:33:25.
// =============================================================================

import type { Denops } from "https://deno.land/x/denops_std@v5.0.1/mod.ts";

import { batch } from "https://deno.land/x/denops_std@v5.0.1/batch/mod.ts";
import { execute } from "https://deno.land/x/denops_std@v5.0.1/helper/execute.ts";
import { assert, is } from "https://deno.land/x/unknownutil@v3.6.0/mod.ts";
import { json2toml, toml2json } from "./util.ts";

export async function setCommand(denops: Denops) {
  denops.dispatcher = {
    ...denops.dispatcher,
    async toml2json(start: unknown, end: unknown): Promise<void> {
      assert(start, is.Number);
      assert(end, is.Number);
      await toml2json(denops, start, end);
    },
    async json2toml(start: unknown, end: unknown): Promise<void> {
      assert(start, is.Number);
      assert(end, is.Number);
      await json2toml(denops, start, end);
    },
  };

  await batch(denops, async (denops: Denops) => {
    await execute(
      denops,
      `
        command! -range=% TJ call s:${denops.name}_notify('toml2json', [<line1>, <line2>])
        command! -range=% JT call s:${denops.name}_notify('json2toml', [<line1>, <line2>])
      `,
    );
  });
}
