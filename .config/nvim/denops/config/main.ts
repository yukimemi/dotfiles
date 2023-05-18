import type { Denops } from "https://deno.land/x/denops_std@v4.3.3/mod.ts";

import { ensureString } from "https://deno.land/x/unknownutil@v2.1.1/mod.ts";
import { execute } from "https://deno.land/x/denops_std@v4.3.3/helper/mod.ts";
import {
  expand,
  has,
} from "https://deno.land/x/denops_std@v4.3.3/function/mod.ts";
import { Dvpm } from "https://deno.land/x/dvpm@0.1.1/dvpm.ts";
import { notify } from "./util.ts";
import { setNeovimQt } from "./neovimqt.ts";
import { setNeovide } from "./neovide.ts";
import { setOption } from "./option.ts";
import { setKeymap } from "./keymap.ts";
import { plugins } from "./plugins.ts";

export async function main(denops: Denops): Promise<void> {
  const starttime = performance.now();
  await pre(denops);
  await dvpmInit(denops);
  await post(denops);

  const elapsed = performance.now() - starttime;
  await notify(
    denops,
    `Config load completed ! \\nElapsed: (${elapsed})`,
  );
}

async function pre(denops: Denops): Promise<void> {
  await setNeovimQt(denops);
  await setNeovide(denops);

  await setOption(denops);
  await setKeymap(denops);
}

async function post(denops: Denops): Promise<void> {
  await vimInit(denops);
}

async function vimInit(denops: Denops) {
  if (await has(denops, "nvim")) {
    return;
  }
  await execute(
    denops,
    `
    silent! syntax enable
    filetype plugin indent on
    `,
  );
}

async function dvpmInit(denops: Denops) {
  const base_path = (await has(denops, "nvim"))
    ? "~/.cache/nvim/dvpm"
    : "~/.cache/vim/dvpm";
  const base = ensureString(await expand(denops, base_path));
  const dvpm = await Dvpm.create(denops, { base, debug: false });

  await Promise.all(plugins.map(async (p) => {
    await dvpm.add(p);
  }));
}
