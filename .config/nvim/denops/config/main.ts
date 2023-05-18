import type { Denops } from "./dep.ts";
import {
  batch,
  Dvpm,
  ensureDir,
  ensureString,
  execute,
  exists,
  expand,
  globals,
  has,
  mapping,
  nvimOption,
  option,
  stdpath,
} from "./dep.ts";

import { notify } from "./util.ts";
import { plugins } from "./plugins.ts";

export async function main(denops: Denops): Promise<void> {
  await pre(denops);
  await dvpmInit(denops);
  await post(denops);

  await notify(denops, "Config load completed !");
}

async function pre(denops: Denops): Promise<void> {
  if (await exists(denops, ":GuiFont")) {
    await execute(denops, "GuiFont! HackGen Console NF:h10");
  }
  if (await exists(denops, ":GuiTabline")) {
    await execute(denops, "GuiTabline 0");
  }
  if (await exists(denops, ":GuiPopupmenu")) {
    await execute(denops, "GuiPopupmenu 0");
  }
  if (await exists(denops, ":GuiScrollBar")) {
    await execute(denops, "GuiScrollBar 0");
  }
  if (await exists(denops, ":GuiWindowOpacity")) {
    await execute(denops, "GuiWindowOpacity 0.95");
  }

  if (await exists(denops, "g:neovide")) {
    await globals.set(denops, "neovide_transparency", 0.9);
    await globals.set(denops, "neovide_floating_blur_amount_x", 2.0);
    await globals.set(denops, "neovide_floating_blur_amount_y", 2.0);
    await globals.set(denops, "neovide_remember_window_size", true);
    await globals.set(denops, "neovide_profiler", false);
    await globals.set(denops, "neovide_input_use_logo", true);
    await globals.set(denops, "neovide_cursor_vfx_mode", "railgun");
    await option.guifont.set(denops, "HackGen Console NF:h10:#h-none");
    await option.guifontwide.set(denops, "HackGen Console NF:h10:#h-none");
  }

  if (await has(denops, "wsl")) {
    globals.set(denops, "clipboard", {
      name: "WslClipboard",
      copy: {
        ["+"]: "win32yank.exe -i",
        ["*"]: "win32yank.exe -i",
      },
      ["paste"]: {
        ["+"]:
          'powershell.exe -NoProfile -c & {chcp 65001 | Out-Null; [Console]::OutputEncoding = [System.Text.Encoding]::GetEncoding("utf-8"); [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))}',
        ["*"]:
          'powershell.exe -NoProfile -c & {chcp 65001 | Out-Null; [Console]::OutputEncoding = [System.Text.Encoding]::GetEncoding("utf-8"); [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))}',
      },
      ["cache_enabled"]: 0,
    });
  }

  const backupdir = (await has(denops, "nvim"))
    ? ensureString(await stdpath(denops, "cache"))
    : ensureString(await expand(denops, "~/.cache/vim/back"));
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
    await option.laststatus.set(denops, 3);
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

    if (await has(denops, "nvim")) {
      await nvimOption.inccommand.set(denops, "nosplit");
      await nvimOption.pumblend.set(denops, 10);
    }

    await globals.set(denops, "mapleader", " ");
    await globals.set(denops, "maplocalleader", "\\");

    // keymaps.
    await mapping.map(denops, "<leader>w", "<cmd>write<cr>", {
      mode: "n",
      silent: true,
    });
    await mapping.map(denops, "<ESC>", "<C-\\><C-n>", {
      mode: "t",
      silent: true,
    });

    await mapping.map(denops, "<esc><esc>", "<cmd>nohlsearch<cr>", {
      mode: "n",
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

    await mapping.map(denops, "<c-p>", "<up>", { mode: "c" });
    await mapping.map(denops, "<c-n>", "<down>", { mode: "c" });
    await mapping.map(denops, "<c-f>", "<right>", { mode: "c" });
    await mapping.map(denops, "<c-b>", "<left>", { mode: "c" });
    await mapping.map(denops, "<c-a>", "<home>", { mode: "c" });
    await mapping.map(denops, "<c-e>", "<end>", { mode: "c" });
  });
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
