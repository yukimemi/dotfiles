// =============================================================================
// File        : main.ts
// Author      : yukimemi
// Last Change : 2024/07/27 22:00:11.
// =============================================================================

import type { Denops, Entrypoint } from "jsr:@denops/std@7.0.3";
import { type Plug } from "jsr:@yukimemi/dvpm@4.0.2";

import * as fn from "jsr:@denops/std@7.0.3/function";
import { Dvpm } from "jsr:@yukimemi/dvpm@4.0.2";
import { z } from "npm:zod@3.23.8";
import { execute } from "jsr:@denops/std@7.0.3/helper";
import { notify } from "./util.ts";
import { plugins } from "./plugins.ts";
import { pluginStatus } from "./pluginstatus.ts";
import { setFiletype } from "./filetype.ts";
import { setKeymapPost, setKeymapPre } from "./keymap.ts";
import { setCommandPost, setCommandPre } from "./command.ts";
import { setNeovide } from "./neovide.ts";
import { setNeovimQt } from "./neovimqt.ts";
import { setNvy } from "./nvy.ts";
import { setFvim } from "./fvim.ts";
import { setOption } from "./option.ts";
import { cacheLua, cacheVim } from "./cache.ts";

export const main: Entrypoint = async (denops) => {
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
};

async function pre(denops: Denops): Promise<void> {
  await setNeovimQt(denops);
  await setNeovide(denops);
  await setNvy(denops);
  await setFvim(denops);

  await setFiletype(denops);
  await setOption(denops);
  await setCommandPre(denops);
  await setKeymapPre(denops);
}

async function post(denops: Denops): Promise<void> {
  await setCommandPost(denops);
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
  const base = z.string().parse(await fn.expand(denops, base_path));
  const cache_path = denops.meta.host === "nvim"
    ? "~/.cache/nvim/dvpm/cache/plugin/dvpm_plugin_cache.vim"
    : "~/.cache/vim/dvpm/cache/pluguin/dvpm_plugin_cache.vim";
  const cache = z.string().parse(await fn.expand(denops, cache_path));
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
