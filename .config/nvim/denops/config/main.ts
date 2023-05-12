import { Denops } from "https://deno.land/x/denops_std@v4.3.0/mod.ts";
import { batch } from "https://deno.land/x/denops_std@v4.3.0/batch/mod.ts";
import * as mapping from "https://deno.land/x/denops_std@v4.3.0/mapping/mod.ts";
import * as option from "https://deno.land/x/denops_std@v4.3.0/option/mod.ts";
import { globals } from "https://deno.land/x/denops_std@v4.3.0/variable/mod.ts";
import { stdpath } from "https://deno.land/x/denops_std@v4.3.0/function/nvim/mod.ts";
import { ensureString } from "https://deno.land/x/unknownutil@v2.1.1/mod.ts";
import { echo } from "https://deno.land/x/denops_std@v4.3.0/helper/mod.ts";
import { join } from "https://deno.land/std@0.187.0/path/mod.ts";

import {
  GitHubPlugin,
  GitPlugin,
  isGitHubPlugin,
  isGitPlugin,
  plugins,
} from "./plugins.ts";

export async function main(denops: Denops): Promise<void> {
  if (await globals.get(denops, "config_loaded") === 1) {
    return;
  }
  await globals.set(denops, "config_loaded", 1);
  await builtinsPre(denops);
  await denopm(denops);

  await denops.cmd(
    "command DenopmUpdate call denops#notify('config', 'update_plugins', [])",
  );
  await denops.cmd("LspStart");

  denops.dispatcher = {
    async update_plugins(): Promise<void> {
      const base = join(ensureString(await stdpath(denops, "cache")), "denopm");

      for (const p of plugins) {
        if (isGitPlugin(p)) {
          await denops.dispatch("denopm", "update_git", base, p.dst);
        }
        if (isGitHubPlugin(p)) {
          await denops.dispatch("denopm", "update_github", base, p.org, p.repo);
        }
      }

      echo(denops, "updated !");
    },
  };

  echo(denops, "configured !");
}

async function builtinsPre(denops: Denops): Promise<void> {
  await batch(denops, async (denops: Denops) => {
    await option.title.set(denops, true);
    await option.timeoutlen.set(denops, 1000);
    await option.ttimeoutlen.set(denops, 0);
    await option.termguicolors.set(denops, true);
    await option.number.set(denops, true);
    await option.relativenumber.set(denops, true);
    await option.expandtab.set(denops, true);
    await option.tabstop.set(denops, 2);
    await option.shiftwidth.set(denops, 2);
    await option.clipboard.set(denops, "unnamedplus");
    await option.showmode.set(denops, false);
    await option.laststatus.set(denops, 3);

    await globals.set(denops, "mapleader", " ");
    await globals.set(denops, "maplocalleader", "\\");

    await mapping.map(denops, "<leader>w", "<cmd>write<cr>", {
      mode: "n",
      silent: true,
    });
    await mapping.map(denops, "<ESC>", "<C-\\><C-n>", {
      mode: "t",
      silent: true,
    });

    await mapping.map(denops, "j", "gj", { mode: ["n", "x"], silent: true });
    await mapping.map(denops, "k", "gk", { mode: ["n", "x"], silent: true });
    await mapping.map(denops, "<tab>", "%", { mode: ["n", "x"], silent: true });
    await mapping.map(denops, "gh", "^", { mode: ["n", "x"], silent: true });
    await mapping.map(denops, "gl", "$", { mode: ["n", "x"], silent: true });

    await mapping.map(denops, "<c-l>", "<c-g>U<right>", {
      mode: "i",
      silent: true,
    });

    // `s` prefix mappings.
    await mapping.map(denops, "s", "<Nop>", { mode: "n", silent: true });
    await mapping.map(denops, "s0", "<cmd>only<cr>", {
      mode: "n",
      silent: true,
    });
    await mapping.map(denops, "s=", "<c-w>=", { mode: "n", silent: true });
    await mapping.map(denops, "sH", "<c-w>H", { mode: "n", silent: true });
    await mapping.map(denops, "sJ", "<c-w>J", { mode: "n", silent: true });
    await mapping.map(denops, "sK", "<c-w>K", { mode: "n", silent: true });
    await mapping.map(denops, "sL", "<c-w>L", { mode: "n", silent: true });
    await mapping.map(denops, "sO", "<cmd>tabonly<cr>", {
      mode: "n",
      silent: true,
    });
    await mapping.map(denops, "sQ", "<cmd>qa<cr>", { mode: "n", silent: true });
    await mapping.map(denops, "sbk", "<cmd>bd!<cr>", {
      mode: "n",
      silent: true,
    });
    await mapping.map(denops, "sbq", "<cmd>q!<cr>", {
      mode: "n",
      silent: true,
    });
    await mapping.map(denops, "sn", "<cmd>bn<cr>", { mode: "n", silent: true });
    await mapping.map(denops, "so", "<c-w>_<c-w>|", {
      mode: "n",
      silent: true,
    });
    await mapping.map(denops, "sp", "<cmd>bp<cr>", { mode: "n", silent: true });
    await mapping.map(denops, "sq", "<cmd>q<cr>", { mode: "n", silent: true });
    await mapping.map(denops, "sr", "<c-w>r", { mode: "n", silent: true });
    await mapping.map(denops, "sh", "<cmd>sp<cr>", { mode: "n", silent: true });
    await mapping.map(denops, "st", "<cmd>tabnew<cr>", {
      mode: "n",
      silent: true,
    });
    await mapping.map(denops, "sv", "<cmd>vs<cr>", { mode: "n", silent: true });
    await mapping.map(denops, "sw", "<c-w>w", { mode: "n", silent: true });

    await mapping.map(denops, "<c-h>", "<c-w>h", { mode: "n", silent: true });
    await mapping.map(denops, "<c-l>", "<c-w>l", { mode: "n", silent: true });
    await mapping.map(denops, "<c-j>", "<c-w>j", { mode: "n", silent: true });
    await mapping.map(denops, "<c-k>", "<c-w>k", { mode: "n", silent: true });
  });
}

async function denopm_github(
  denops: Denops,
  base: string,
  p: GitHubPlugin,
): Promise<void> {
  await denops.dispatch("denopm", "download_github", base, p.org, p.repo);

  if (p.lua_pre != null) {
    await denops.cmd(`lua ${p.lua_pre}`);
  }

  await denops.dispatch("denopm", "add_rtp_github", base, p.org, p.repo);
  await denops.dispatch(
    "denopm",
    "source_vimscript_github",
    base,
    p.org,
    p.repo,
  );
  await denops.dispatch("denopm", "source_lua_github", base, p.org, p.repo);
  await denops.dispatch(
    "denopm",
    "register_denops_github",
    base,
    p.org,
    p.repo,
  );

  if (p.lua_post != null) {
    await denops.cmd(`lua ${p.lua_post}`);
  }
}

async function denopm_git(
  denops: Denops,
  base: string,
  p: GitPlugin,
): Promise<void> {
  await denops.dispatch("denopm", "download_git", base, p.dst, p.url);

  if (p.lua_pre != null) {
    await denops.cmd(`lua ${p.lua_pre}`);
  }

  await denops.dispatch("denopm", "add_rtp_git", base, p.dst, p.url);
  await denops.dispatch("denopm", "source_vimscript_git", base, p.dst, p.url);
  await denops.dispatch("denopm", "source_lua_git", base, p.dst, p.url);
  await denops.dispatch("denopm", "register_denops_git", base, p.dst, p.url);

  if (p.lua_post != null) {
    await denops.cmd(`lua ${p.lua_post}`);
  }
}

async function denopm(denops: Denops): Promise<void> {
  const base = join(ensureString(await stdpath(denops, "cache")), "denopm");

  for (const p of plugins) {
    if (isGitPlugin(p)) {
      await denopm_git(denops, base, p);
    }
    if (isGitHubPlugin(p)) {
      await denopm_github(denops, base, p);
    }
  }
}
