// =============================================================================
// File        : util.ts
// Author      : yukimemi
// Last Change : 2025/05/03 08:23:24.
// =============================================================================

import * as buffer from "jsr:@denops/std@7.6.0/buffer";
import * as fn from "jsr:@denops/std@7.6.0/function";
import * as fs from "jsr:@std/fs@1.0.19";
import * as helper from "jsr:@denops/std@7.6.0/helper";
import * as nvimFn from "jsr:@denops/std@7.6.0/function/nvim";
import * as option from "jsr:@denops/std@7.6.0/option";
import * as vars from "jsr:@denops/std@7.6.0/variable";
import type { Denops } from "jsr:@denops/std@7.6.0";
import { format } from "jsr:@std/datetime@0.225.5";
import { join } from "jsr:@std/path@1.1.1/join";
import { systemopen } from "jsr:@lambdalisue/systemopen@1.0.0";
import { z } from "npm:zod@4.0.10";

export async function notify(
  denops: Denops,
  msg: string | string[],
  opt?: { timeout?: number; type?: string },
) {
  if (denops.meta.host === "nvim") {
    try {
      if (opt?.type === "nvim-notify") {
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
      } else if (opt?.type === "snacks") {
        await denops.call(
          `luaeval`,
          `Snacks.notify.notify(_A.msg, _A.opts)`,
          {
            msg,
            opts: { timeout: opt?.timeout || 5000 },
          },
        );
      } else {
        const result = z.array(z.string()).safeParse(msg);
        const message = result.success ? result.data.join("\r") : msg;
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
    await denops.cmd(`silent! EnableLumiris`);
    await denops.cmd(`silent! EnableAutoCursorColumn`);
    await denops.cmd(`silent! IlluminateResume`);
    await denops.cmd(`silent! SmoothCursorFancyOn`);
    await denops.cmd(`silent! QuickScopeToggle`);
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
    await denops.cmd(`silent! DisableLumiris`);
    await denops.cmd(`silent! DisableAutoCursorColumn`);
    await denops.cmd(`silent! IlluminatePause`);
    await denops.cmd(`silent! SmoothCursorFancyOff`);
    await denops.cmd(`silent! QuickScopeToggle`);
    await denops.cmd(`silent! colorscheme oceanic_material`);
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
  const shadaDir = join(z.string().parse(await nvimFn.stdpath(denops, "state")), "shada");
  await Deno.remove(shadaDir, { recursive: true });
  console.log(`shada dir remove done !`);
}

export async function execCommand(denops: Denops, command: string, args: string[], cwd?: string) {
  const cmd = new Deno.Command(command, { args, cwd });
  console.log(`» ${command} ${args.join(" ")}`);
  const output = await cmd.output();
  if (output.stdout.length) {
    await notify(denops, new TextDecoder().decode(output.stdout));
  }
  if (output.stderr.length) {
    console.error(new TextDecoder().decode(output.stderr));
  }
}

export async function zennCreate(denops: Denops, title: string, type = "tech") {
  const date = format(new Date(), "yyyy-MM-dd");
  const slug = `${date}_${title}`;
  const cmd = new Deno.Command("deno", {
    args: [
      "run",
      "-A",
      "npm:zenn-cli@latest",
      "new:article",
      "--slug",
      slug,
      "--type",
      type,
    ],
  });
  const { stdout } = await cmd.output();
  console.log(new TextDecoder().decode(stdout).trim());
  const gitRoot = (await (new Deno.Command("git", {
    args: ["rev-parse", "--show-toplevel"],
    cwd: await fn.getcwd(denops),
  })).output()).stdout;
  const article = join(new TextDecoder().decode(gitRoot).trim(), "articles", `${slug}.md`);
  await buffer.open(denops, article);
}

export async function zennPreview(denops: Denops) {
  const bufname = await fn.bufname(denops);
  await helper.execute(
    denops,
    `
      bo term deno run -A --unstable-fs npm:zenn-cli@latest preview
      sleep
      OpenBrowser localhost:8000
    `,
  );
  await buffer.open(denops, bufname);
}

export async function openLog(denops: Denops, path: string) {
  await buffer.open(denops, path);
}
