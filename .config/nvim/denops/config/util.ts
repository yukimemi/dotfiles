// =============================================================================
// File        : util.ts
// Author      : yukimemi
// Last Change : 2023/12/17 16:16:59.
// =============================================================================

import * as fn from "https://deno.land/x/denops_std@v6.0.1/function/mod.ts";
import * as fs from "https://deno.land/std@0.214.0/fs/mod.ts";
import * as helper from "https://deno.land/x/denops_std@v6.0.1/helper/mod.ts";
import * as nvimFn from "https://deno.land/x/denops_std@v6.0.1/function/nvim/mod.ts";
import * as option from "https://deno.land/x/denops_std@v6.0.1/option/mod.ts";
import * as vars from "https://deno.land/x/denops_std@v6.0.1/variable/mod.ts";
import type { Denops } from "https://deno.land/x/denops_std@v6.0.1/mod.ts";
import { ensure, is } from "https://deno.land/x/unknownutil@v3.15.0/mod.ts";
import { join } from "https://deno.land/std@0.214.0/path/join.ts";
import { systemopen } from "https://deno.land/x/systemopen@v0.2.0/mod.ts";

const useNvimNotify = true;

export async function notify(
  denops: Denops,
  msg: string | string[],
  opt?: { timeout?: number },
) {
  if (denops.meta.host === "nvim") {
    try {
      if (useNvimNotify) {
        await denops.call(
          `luaeval`,
          `
            require("notify")(_A.msg, vim.log.levels.INFO, {
              timeout = _A.timeout,
              on_open = function(win)
                vim.wo[win].wrap = true
              end,
            })
          `,
          { msg, timeout: opt?.timeout || 5000 },
        );
      } else {
        const message = is.ArrayOf(is.String)(msg) ? msg.join("\r") : msg;
        await helper.execute(
          denops,
          `lua vim.notify([[${message}]], vim.log.levels.INFO)`,
        );
      }
      return;
      // deno-lint-ignore no-empty
    } catch {}
  }
  if (typeof msg === "string") {
    await helper.echo(denops, msg);
  } else {
    await helper.echo(denops, msg.join("\n"));
  }
}

export async function toggleOption(
  denops: Denops,
  option: string,
  global = false,
) {
  if (global) {
    await vars.globalOptions.set(
      denops,
      option,
      !(await vars.globalOptions.get(denops, option)),
    );
  } else {
    await vars.localOptions.set(
      denops,
      option,
      !(await vars.localOptions.get(denops, option)),
    );
  }
}

export async function reviewMode(denops: Denops, stop = false) {
  if (stop) {
    await option.relativenumber.set(denops, true);
    if (await fn.exists(denops, ":GuiWindowOpacity")) {
      await helper.execute(denops, "GuiWindowOpacity 0.95");
    }
    if (await fn.exists(denops, "g:neovide")) {
      await vars.g.set(denops, "neovide_transparency", 0.9);
    }
    await denops.cmd(`EnableRandomColorscheme`);
    await denops.cmd(`EnableAutoCursorColumn`);
    await denops.cmd(`IlluminateResume`);
    await denops.cmd(`SmoothCursorFancyOn`);
    await denops.cmd(`QuickScopeToggle`);
    await denops.cmd(`silent! FontReset`);
  } else {
    await option.wrap.set(denops, true);
    await option.relativenumber.set(denops, false);
    if (await fn.exists(denops, ":GuiWindowOpacity")) {
      await helper.execute(denops, "GuiWindowOpacity 1.00");
    }
    if (await fn.exists(denops, "g:neovide")) {
      await vars.g.set(denops, "neovide_transparency", 1.0);
    }
    await denops.cmd(`DisableRandomColorscheme`);
    await denops.cmd(`DisableAutoCursorColumn`);
    await denops.cmd(`IlluminatePause`);
    await denops.cmd(`SmoothCursorFancyOff`);
    await denops.cmd(`QuickScopeToggle`);
    await denops.cmd(`colorscheme oceanic_material`);
    await helper.execute(denops, `silent! FontSizeUp 3`);
  }
}

async function wsl2win(path: string): Promise<string> {
  const cmd = new Deno.Command("wslpath", {
    args: ["-w", path],
  });
  const { stdout } = await cmd.output();
  return new TextDecoder().decode(stdout).trim();
}

export async function openBufDir(denops: Denops) {
  const bufname = await fn.bufname(denops);
  let bufdir = await fn.fnamemodify(denops, bufname, ":p:h");
  if (await fn.has(denops, "wsl")) {
    bufdir = await wsl2win(bufdir);
    (new Deno.Command("explorer.exe", {
      args: [bufdir],
    })).output();
  } else {
    console.log({ bufdir });
    if (await fs.exists(bufdir)) {
      systemopen(bufdir);
    }
  }
}

export async function focusFloating(denops: Denops) {
  // https://github.com/yuki-yano/dotfiles/blob/main/.vim/lua/rc/keymaps.lua
  await helper.execute(
    denops,
    `
      lua << EOB
        vim.keymap.set({ 'n' }, '<C-w><C-w>', function()
          if vim.fn.empty(vim.api.nvim_win_get_config(vim.fn.win_getid()).relative) == 0 then
            vim.cmd([[wincmd p]])
            return
          end

          for winnr = 1, vim.fn.winnr('$') do
            local winid = vim.fn.win_getid(winnr)
            local conf = vim.api.nvim_win_get_config(winid)
            if conf.focusable and vim.fn.empty(conf.relative) == 0 then
              vim.fn.win_gotoid(winid)
              return
            end
          end
          vim.cmd([[normal! <C-w><C-w>]])
        end)
      EOB
  `,
  );
}

export async function removeShada(denops: Denops) {
  const shadaDir = join(ensure(await nvimFn.stdpath(denops, "state"), is.String), "shada");
  await Deno.remove(shadaDir, { recursive: true });
}
