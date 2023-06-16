import * as fn from "https://deno.land/x/denops_std@v5.0.0/function/mod.ts";
import * as fs from "https://deno.land/std@0.192.0/fs/mod.ts";
import * as helper from "https://deno.land/x/denops_std@v5.0.0/helper/mod.ts";
import * as option from "https://deno.land/x/denops_std@v5.0.0/option/mod.ts";
import * as vars from "https://deno.land/x/denops_std@v5.0.0/variable/mod.ts";
import type { Denops } from "https://deno.land/x/denops_std@v5.0.0/mod.ts";

export async function notify(
  denops: Denops,
  msg: string | string[],
  opt?: { timeout?: number },
) {
  if (await fn.has(denops, "nvim")) {
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
    if (typeof msg === "string") {
      await helper.echo(denops, msg);
    } else {
      await helper.echo(denops, msg.join("\n"));
    }
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
    await helper.execute(denops, "GuiWindowOpacity 0.95");
    await denops.cmd(`EnableRandomColorscheme`);
    await denops.cmd(`EnableAutoCursorColumn`);
    await denops.cmd(`IlluminateResume`);
    await denops.cmd(`SmoothCursorFancyOn`);
    await denops.cmd(`QuickScopeToggle`);
    await denops.cmd(`silent! FontReset`);
  } else {
    await option.wrap.set(denops, true);
    await option.relativenumber.set(denops, false);
    await helper.execute(denops, "GuiWindowOpacity 1.00");
    await denops.cmd(`DisableRandomColorscheme`);
    await denops.cmd(`DisableAutoCursorColumn`);
    await denops.cmd(`IlluminatePause`);
    await denops.cmd(`SmoothCursorFancyOff`);
    await denops.cmd(`QuickScopeToggle`);
    await denops.cmd(`colorscheme oceanic_material`);
    await helper.execute(denops, `silent! FontSizeUp 3`);
  }
}

export async function openBufDir(denops: Denops) {
  const bufname = await fn.bufname(denops);
  const bufdir = await fn.fnamemodify(denops, bufname, ":h");
  console.log({ bufdir });
  if (await fs.exists(bufdir)) {
    if (Deno.build.os === "windows") {
      const args = [bufdir];
      const cmd = new Deno.Command("explorer", { args });
      return await cmd.output();
    }
    if (Deno.build.os === "darwin") {
      const args = ["-a", bufdir];
      const cmd = new Deno.Command("open", { args });
      return await cmd.output();
    }
  }
}
