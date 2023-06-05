import * as fn from "https://deno.land/x/denops_std@v5.0.0/function/mod.ts";
import type { Denops } from "https://deno.land/x/denops_std@v5.0.0/mod.ts";
import {
  echo,
  execute,
} from "https://deno.land/x/denops_std@v5.0.0/helper/mod.ts";

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
      await echo(denops, msg);
    } else {
      await echo(denops, msg.join("\n"));
    }
  }
}
