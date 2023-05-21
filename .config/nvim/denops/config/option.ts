import type { Denops } from "https://deno.land/x/denops_std@v4.3.3/mod.ts";

import * as nvimOption from "https://deno.land/x/denops_std@v4.3.3/option/nvim/mod.ts";
import * as autocmd from "https://deno.land/x/denops_std@v4.3.3/autocmd/mod.ts";
import * as option from "https://deno.land/x/denops_std@v4.3.3/option/mod.ts";
import { batch } from "https://deno.land/x/denops_std@v4.3.3/batch/mod.ts";
import { ensureDir } from "https://deno.land/std@0.188.0/fs/ensure_dir.ts";
import { ensureString } from "https://deno.land/x/unknownutil@v2.1.1/mod.ts";
import { stdpath } from "https://deno.land/x/denops_std@v4.3.3/function/nvim/mod.ts";
import * as fn from "https://deno.land/x/denops_std@v4.3.3/function/mod.ts";

export async function setOption(denops: Denops) {
  const backupdir = (await fn.has(denops, "nvim"))
    ? ensureString(await stdpath(denops, "cache"))
    : ensureString(await fn.expand(denops, "~/.cache/vim/back"));
  await ensureDir(backupdir);

  await batch(denops, async (denops: Denops) => {
    await option.encoding.set(denops, "utf-8");
    await option.fileencodings.set(
      denops,
      "ucs-bom,utf-8,iso-2022-jp,euc-jp,cp932,latin1",
    );
    await option.fileformats.set(denops, "unix,dos,mac");

    await option.backup.set(denops, true);
    await option.backupdir.set(denops, `${backupdir}/backup`);
    await option.clipboard.set(denops, "unnamedplus");
    // await option.cmdheight.set(denops, 0);
    await option.completeopt.set(denops, "menu,menuone,noselect");
    await option.confirm.set(denops, true);
    await option.expandtab.set(denops, true);
    await option.grepformat.set(denops, "%f:%l:%c:%m");
    await option.grepprg.set(denops, "rg --vimgrep");
    await option.hidden.set(denops, true);
    await option.ignorecase.set(denops, true);
    await option.laststatus.set(denops, 2);
    await option.list.set(denops, true);
    await option.listchars.set(
      denops,
      "tab:\¦\ ,trail:-,extends:»,precedes:«,nbsp:%",
    );
    await option.mouse.set(denops, "a");
    await option.number.set(denops, true);
    await option.pumheight.set(denops, 30);
    await option.relativenumber.set(denops, true);
    await option.scrolloff.set(denops, 4);
    await option.sessionoptions.set(denops, "buffers,curdir,tabpages,winsize");
    await option.shiftround.set(denops, true);
    await option.shiftwidth.set(denops, 2);
    await option.showmode.set(denops, false);
    await option.sidescrolloff.set(denops, 4);
    await option.signcolumn.set(denops, "yes");
    await option.smartcase.set(denops, true);
    await option.smartindent.set(denops, true);
    await option.spell.set(denops, false);
    await option.splitbelow.set(denops, true);
    await option.splitright.set(denops, true);
    await option.tabstop.set(denops, 2);
    await option.termguicolors.set(denops, true);
    await option.timeoutlen.set(denops, 1000);
    await option.ttimeoutlen.set(denops, 0);
    await option.undofile.set(denops, true);
    await option.undolevels.set(denops, 10000);
    await option.wildmode.set(denops, "longest:full,full");
    await option.wrap.set(denops, false);

    if (await fn.has(denops, "nvim")) {
      await nvimOption.inccommand.set(denops, "nosplit");
      await nvimOption.pumblend.set(denops, 10);
      await option.laststatus.set(denops, 3);
    }

    await autocmd.group(denops, "MyCommentOut", (helper) => {
      helper.remove("*");
      helper.define(
        "FileType",
        "*",
        `set fo-=c fo-=r fo-=o`,
      );
    });
  });
}
