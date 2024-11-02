// =============================================================================
// File        : main.ts
// Author      : yukimemi
// Last Change : 2024/10/05 16:57:38.
// =============================================================================

import * as fn from "jsr:@denops/std@7.3.0/function";
import * as lambda from "jsr:@denops/std@7.3.0/lambda";
import * as log from "jsr:@std/log@0.224.9";
import type { Denops, Entrypoint } from "jsr:@denops/std@7.3.0";
import { Dvpm } from "jsr:@yukimemi/dvpm@5.0.12";
import { cacheLua, cacheVim } from "./cache.ts";
import { dir } from "jsr:@cross/dir@1.1.0";
import { ensureFile } from "jsr:@std/fs@1.0.5/ensure-file";
import { execute } from "jsr:@denops/std@7.3.0/helper";
import { join } from "jsr:@std/path@1.0.8/join";
import { notify, openLog } from "./util.ts";
import { plugins } from "./plugins.ts";
import { setCommandPost, setCommandPre } from "./command.ts";
import { setFiletype } from "./filetype.ts";
import { setFvim } from "./fvim.ts";
import { setKeymapPost, setKeymapPre } from "./keymap.ts";
import { setNeovide } from "./neovide.ts";
import { setNeovimQt } from "./neovimqt.ts";
import { setNvy } from "./nvy.ts";
import { setOption } from "./option.ts";
import { z } from "npm:zod@3.23.8";

const logPath = join(await dir("cache"), "dvpm", `dvpm_${new Date().getTime()}.log`);
await ensureFile(logPath);

log.setup({
  handlers: {
    console: new log.ConsoleHandler("INFO"),
    file: new log.FileHandler("DEBUG", {
      filename: logPath,
      formatter: (record) =>
        `${record.datetime.toLocaleTimeString()} ${record.levelName} ${record.msg}`,
    }),
  },

  loggers: {
    dvpm: {
      level: "DEBUG",
      handlers: ["console", "file"],
    },
  },
});

export const main: Entrypoint = async (denops) => {
  const starttime = performance.now();
  await pre(denops);
  const dvpm = await dvpmExec(denops);
  await post(denops);

  const elapsed = performance.now() - starttime;
  await notify(denops, [`Config load completed !`, `Elapsed: (${elapsed})`]);
  console.log(`Config load completed ! Elapsed: (${elapsed})`);

  await denops.cmd(`
    command! -nargs=0 DvpmOpenLog call s:${denops.name}_notify("${
    lambda.register(denops, async () => await openLog(denops, logPath))
  }", [])
      `);
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
    notify: true,
    concurrency: denops.meta.platform === "windows" ? 5 : 13,
  });

  await Promise.all(plugins.map((p) => dvpm.add(p)));

  await dvpm.end();

  return dvpm;
}
