// =============================================================================
// File        : option.ts
// Author      : yukimemi
// Last Change : 2024/01/03 12:01:28.
// =============================================================================

import type { Denops } from "https://deno.land/x/denops_std@v6.0.0/mod.ts";

import * as autocmd from "https://deno.land/x/denops_std@v6.0.0/autocmd/mod.ts";
import * as fn from "https://deno.land/x/denops_std@v6.0.0/function/mod.ts";
import * as helper from "https://deno.land/x/denops_std@v6.0.0/helper/mod.ts";
import * as lambda from "https://deno.land/x/denops_std@v6.0.0/lambda/mod.ts";
import * as nvimOption from "https://deno.land/x/denops_std@v6.0.0/option/nvim/mod.ts";
import * as option from "https://deno.land/x/denops_std@v6.0.0/option/mod.ts";
import { batch } from "https://deno.land/x/denops_std@v6.0.0/batch/mod.ts";
import { ensure, is } from "https://deno.land/x/unknownutil@v3.14.1/mod.ts";
import { ensureDir } from "https://deno.land/std@0.214.0/fs/ensure_dir.ts";
import { stdpath } from "https://deno.land/x/denops_std@v6.0.0/function/nvim/mod.ts";

export async function setOption(denops: Denops) {
  const backupdir = denops.meta.host === "nvim"
    ? ensure(await stdpath(denops, "cache"), is.String)
    : ensure(await fn.expand(denops, "~/.cache/vim/back"), is.String);
  await ensureDir(backupdir);

  await batch(denops, async (denops: Denops) => {
    await option.encoding.set(denops, "utf-8");
    await option.fileencodings.set(
      denops,
      "ucs-bom,utf-8,iso-2022-jp,euc-jp,cp932,latin1",
    );
    await option.fileformats.set(denops, "unix,dos,mac");

    await option.backup.set(denops, false);
    await option.backupdir.set(denops, backupdir);
    await option.colorcolumn.set(denops, "100");
    await option.completeopt.set(denops, "menu,menuone,noselect,noinsert");
    await option.completeslash.set(denops, "slash");
    await option.confirm.set(denops, true);
    await option.expandtab.set(denops, true);
    await option.grepformat.set(denops, "%f:%l:%c:%m");
    await option.grepprg.set(denops, "rg --vimgrep");
    await option.hidden.set(denops, true);
    await option.ignorecase.set(denops, true);
    await option.list.set(denops, true);
    await option.listchars.set(
      denops,
      "tab:¦ ,trail:-,extends:»,precedes:«,nbsp:%",
    );
    await option.more.set(denops, false);
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

    if (denops.meta.host === "nvim") {
      // await option.cmdheight.set(denops, 0);
      await nvimOption.inccommand.set(denops, "nosplit");
      await nvimOption.pumblend.set(denops, 10);
      await option.laststatus.set(denops, 3);
      await option.clipboard.set(denops, "unnamedplus");
    } else {
      await option.laststatus.set(denops, 2);
      await option.incsearch.set(denops, true);
      await option.hlsearch.set(denops, true);
      await option.clipboard.set(denops, "unnamed,unnamedplus");
      await option.undodir.set(denops, backupdir);
      await option.backupdir.set(denops, backupdir);
      await option.directory.set(denops, backupdir);
      await option.viewdir.set(denops, backupdir);
    }

    await autocmd.group(denops, "MyAutoCmd", (helper) => {
      helper.remove("*");
      helper.define(["FileType", "BufRead"], "*", `set fo-=c fo-=r fo-=o`);
      helper.define(
        "BufReadPost",
        "*",
        `call <SID>${denops.name}_notify("${
          lambda.register(
            denops,
            async () => {
              const lastpos = await fn.line(denops, `'"`);
              const lastLine = await fn.line(denops, "$");
              if (lastpos > 0 && lastpos <= lastLine) {
                // await denops.cmd('normal! g`"');
              }
            },
          )
        }", [])`,
      );
      helper.define(
        ["CursorHold", "FocusGained", "FocusLost"],
        "*",
        `silent! checktime`,
      );
    });

    await helper.execute(
      denops,
      `
        " https://vim-jp.org/vim-users-jp/2011/02/20/Hack-202.html
        augroup vimrc-auto-mkdir
          autocmd!
          autocmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'), v:cmdbang)
          function! s:auto_mkdir(dir, force)
            if !isdirectory(a:dir) && (a:force ||
            \\  input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\\%[es]$')
              call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
            endif
          endfunction
        augroup END
      `,
    );
    await helper.execute(
      denops,
      `
        " https://zenn.dev/vim_jp/articles/f23938c7df2dd9
        function s:show_qf_lists()
          let l:qnr = 1
          while qnr <= 10
            let l:list = getqflist({"nr": qnr, "title": v:true, "id": 0})
            if l:list["nr"] > 0
              echo l:qnr .. ": " .. l:list["title"] .. ": " .. l:list["id"]
            endif
            let l:qnr = l:qnr + 1
          endwhile
        endfunction
        command! ShowQfLists call <sid>show_qf_lists()
      `,
    );
  });
}
