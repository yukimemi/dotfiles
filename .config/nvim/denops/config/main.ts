// =============================================================================
// File        : main.ts
// Author      : yukimemi
// Last Change : 2025/12/31 20:38:33.
// =============================================================================

import { dir } from "@cross/dir";
import type { Denops, Entrypoint } from "@denops/std";
import * as autocmd from "@denops/std/autocmd";
import * as fn from "@denops/std/function";
import { execute } from "@denops/std/helper";
import * as lambda from "@denops/std/lambda";
import { ensureFile } from "@std/fs/ensure-file";
import * as log from "@std/log";
import { join } from "@std/path/join";
import { Dvpm } from "@yukimemi/dvpm";
import { z } from "zod";
import { cacheLua, cacheVim } from "./cache.ts";
import { setCommandPost, setCommandPre } from "./command.ts";
import { setFiletype } from "./filetype.ts";
import { setFvim } from "./fvim.ts";
import { setKeymapPost, setKeymapPre } from "./keymap.ts";
import { setNeovide } from "./neovide.ts";
import { setNeovimQt } from "./neovimqt.ts";
import { setNvy } from "./nvy.ts";
import { setOption } from "./option.ts";
import { plugins } from "./plugins.ts";
import { notify, openLog } from "./util.ts";

const logPath = join(
  await dir("cache"),
  "dvpm",
  `dvpm_${new Date().getTime()}.log`,
);
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

export const main: Entrypoint = async (denops: Denops) => {
  const starttime = performance.now();
  autocmd.define(
    denops,
    "User",
    "DvpmCacheUpdated",
    `echom "Dvpm cache updated !"`,
  );
  const dvpm = await dvpmCreate(denops);
  await pre(denops);
  await dvpmExec(dvpm);
  await post(denops);

  const elapsed = performance.now() - starttime;
  await notify(denops, [`Config load completed !`, `Elapsed: (${elapsed})`]);

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

async function dvpmCreate(denops: Denops): Promise<Dvpm> {
  const basePath = denops.meta.host === "nvim" ? "~/.cache/nvim/dvpm" : "~/.cache/vim/dvpm";
  const base = z.string().parse(await fn.expand(denops, basePath));
  const cachePath = denops.meta.host === "nvim"
    ? "~/.config/nvim/plugin/dvpm_plugin_cache.vim"
    : "~/.config/vim/pluguin/dvpm_plugin_cache.vim";
  const cache = z.string().parse(await fn.expand(denops, cachePath));
  const dvpm = await Dvpm.begin(denops, {
    base,
    cache,
    notify: true,
    profiles: [
      "ai",
      "colors",
      "completion",
      "core",
      "favaritecolors",
      "ff",
      "filer",
      "filetype",
      "git",
      "lsp",
      "mark",
      "markdown",
      "memo",
      "mini",
      "motion",
      "operator",
      "quickfix",
      "runner",
      "search",
      "snippet",
      "statusline",
      "terminal",
      "test",
      "textobj",
      "treesitter",
      "twitter",
      "ui",
      "yank",
    ],
    concurrency: denops.meta.platform === "windows" ? 5 : 13,
  });

  return dvpm;
}

async function dvpmExec(dvpm: Dvpm): Promise<void> {
  await Promise.all(plugins.map((p) => dvpm.add(p)));
  await dvpm.end();
}
