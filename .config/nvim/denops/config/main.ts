import { type Denops } from "https://deno.land/x/denops_std@v5.0.0/mod.ts";
import { type Plug } from "https://deno.land/x/dvpm@1.1.2/mod.ts";

import * as fn from "https://deno.land/x/denops_std@v5.0.0/function/mod.ts";
import { Dvpm } from "https://deno.land/x/dvpm@1.1.2/mod.ts";
import { ensureString } from "https://deno.land/x/unknownutil@v2.1.1/mod.ts";
import { execute } from "https://deno.land/x/denops_std@v5.0.0/helper/mod.ts";
import { notify } from "./util.ts";
import { plugins } from "./plugins.ts";
import { setFiletype } from "./filetype.ts";
import { setKeymapPost, setKeymapPre } from "./keymap.ts";
import { setNeovide } from "./neovide.ts";
import { setNeovimQt } from "./neovimqt.ts";
import { setOption } from "./option.ts";
import { notifyWeather } from "./weather.ts";

export const pluginStatus = {
  heirline: false,
  lualine: true,
  bufferline: false,
  ddc: Deno.build.os === "windows",
  coc: Deno.build.os !== "windows",
  autopairs: false,
  insx: true,
  modesearch: false,
};

export async function main(denops: Denops): Promise<void> {
  const starttime = performance.now();
  await pre(denops);
  await dvpmExec(denops);
  await post(denops);

  const elapsed = performance.now() - starttime;
  await notify(denops, [`Config load completed !`, `Elapsed: (${elapsed})`]);

  await notifyWeather(denops);
}

async function pre(denops: Denops): Promise<void> {
  await setNeovimQt(denops);
  await setNeovide(denops);

  await setFiletype(denops);
  await setOption(denops);
  await setKeymapPre(denops);
}

async function post(denops: Denops): Promise<void> {
  await setKeymapPost(denops);
  await vimInit(denops);
}

async function vimInit(denops: Denops) {
  if (await fn.has(denops, "nvim")) {
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

async function dvpmExec(denops: Denops) {
  const base_path = (await fn.has(denops, "nvim"))
    ? "~/.cache/nvim/dvpm"
    : "~/.cache/vim/dvpm";
  const base = ensureString(await fn.expand(denops, base_path));
  const dvpm = await Dvpm.begin(denops, {
    base,
    debug: false,
    profile: false,
    notify: true,
    concurrency: 13,
    logarg: [],
  });

  await Promise.all(plugins.map((p: Plug) => dvpm.add(p)));

  await dvpm.end();
}
