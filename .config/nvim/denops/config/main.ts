import { type Denops } from "https://deno.land/x/denops_std@v5.0.1/mod.ts";
import { type Plug } from "https://deno.land/x/dvpm@2.2.0/mod.ts";

import * as fn from "https://deno.land/x/denops_std@v5.0.1/function/mod.ts";
import { Dvpm } from "https://deno.land/x/dvpm@2.2.0/mod.ts";
import { ensure, is } from "https://deno.land/x/unknownutil@v3.2.0/mod.ts";
import { execute } from "https://deno.land/x/denops_std@v5.0.1/helper/mod.ts";
import { notify } from "./util.ts";
import { plugins } from "./plugins.ts";
import { setFiletype } from "./filetype.ts";
import { setKeymapPost, setKeymapPre } from "./keymap.ts";
import { setNeovide } from "./neovide.ts";
import { setNeovimQt } from "./neovimqt.ts";
import { setOption } from "./option.ts";
import { cacheLua, cacheVim } from "./cache.ts";

export const pluginStatus = {
  nvimnotify: true,
  notifier: false,
  heirline: false,
  lualine: true,
  bufferline: false,
  ddc: true,
  coc: false,
  autopairs: false,
  insx: true,
  modesearch: false,
};

export async function main(denops: Denops): Promise<void> {
  const starttime = performance.now();
  await pre(denops);
  const dvpm = await dvpmExec(denops);
  await post(denops);

  const elapsed = performance.now() - starttime;
  await notify(denops, [`Config load completed !`, `Elapsed: (${elapsed})`]);

  await dvpm.cache(cacheLua());
  await dvpm.cache(cacheVim());
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
  const base = ensure(await fn.expand(denops, base_path), is.String);
  const cache_path = (await fn.has(denops, "nvim"))
    ? "~/.config/nvim/plugin/dvpm_plugin_cache.vim"
    : "~/.config/vim/plugin/dvpm_plugin_cache.vim";
  const cache = ensure(await fn.expand(denops, cache_path), is.String);
  const dvpm = await Dvpm.begin(denops, {
    base,
    cache,
    debug: false,
    profile: false,
    notify: true,
    concurrency: 13,
    logarg: [],
  });

  await Promise.all(plugins.map((p: Plug) => dvpm.add(p)));

  await dvpm.end();

  return dvpm;
}
