// =============================================================================
// File        : main.ts
// Author      : yukimemi
// Last Change : 2023/11/03 08:40:05.
// =============================================================================

import { type Denops } from "https://deno.land/x/denops_std@v5.1.0/mod.ts";
import { type Plug } from "https://deno.land/x/dvpm@3.6.0/mod.ts";

import * as fn from "https://deno.land/x/denops_std@v5.1.0/function/mod.ts";
import { Dvpm } from "https://deno.land/x/dvpm@3.6.0/mod.ts";
import { ensure, is } from "https://deno.land/x/unknownutil@v3.11.0/mod.ts";
import { execute } from "https://deno.land/x/denops_std@v5.1.0/helper/mod.ts";
import { notify } from "./util.ts";
import { plugins } from "./plugins.ts";
import { setFiletype } from "./filetype.ts";
import { setKeymapPost, setKeymapPre } from "./keymap.ts";
import { setNeovide } from "./neovide.ts";
import { setNeovimQt } from "./neovimqt.ts";
import { setNvy } from "./nvy.ts";
import { setFvim } from "./fvim.ts";
import { setOption } from "./option.ts";
import { cacheLua, cacheVim } from "./cache.ts";

export const pluginStatus = {
  autopairs: false,
  barbecue: true,
  bufferline: false,
  buffertabs: false,
  cmp: false,
  coc: false,
  ddc: true,
  ddu: true,
  fern: false,
  heirline: false,
  hlchunk: false,
  indentblankline: true,
  insx: true,
  lualine: true,
  modesearch: false,
  neotree: true,
  notifier: false,
  nvimnotify: true,
  nvimtree: false,
  snipewin: true,
  ultimatepair: false,
  vimwiki: false,
  vscode: false,
  windowpicker: false,
  yankround: true,
  yanky: false,
};

export async function main(denops: Denops): Promise<void> {
  const starttime = performance.now();
  await notify(denops, `dvpm main start !`);
  pluginStatus.vscode = await fn.exists(denops, "g:vscode");
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
  await setNvy(denops);
  await setFvim(denops);

  await setFiletype(denops);
  await setOption(denops);
  await setKeymapPre(denops);
}

async function post(denops: Denops): Promise<void> {
  await setKeymapPost(denops);
  await vimInit(denops);
}

async function vimInit(denops: Denops) {
  if (denops.meta.host !== "vim") {
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
  const base_path = denops.meta.host === "nvim" ? "~/.cache/nvim/dvpm" : "~/.cache/vim/dvpm";
  const base = ensure(await fn.expand(denops, base_path), is.String);
  const cache_path = denops.meta.host === "nvim"
    ? "~/.cache/nvim/dvpm/cache/plugin/dvpm_plugin_cache.vim"
    : "~/.cache/vim/dvpm/cache/pluguin/dvpm_plugin_cache.vim";
  const cache = ensure(await fn.expand(denops, cache_path), is.String);
  const dvpm = await Dvpm.begin(denops, {
    base,
    cache,
    debug: false,
    profile: false,
    notify: true,
    concurrency: denops.meta.platform === "windows" ? 5 : 13,
    logarg: [],
  });

  await Promise.all(plugins.map((p: Plug) => dvpm.add(p)));

  await dvpm.end();

  return dvpm;
}
