import type { Denops } from "https://deno.land/x/denops_std@v4.3.3/mod.ts";
import {
  echo,
  execute,
} from "https://deno.land/x/denops_std@v4.3.3/helper/mod.ts";
import { has } from "https://deno.land/x/denops_std@v4.3.3/function/mod.ts";

export async function notify(denops: Denops, msg: string) {
  if (await has(denops, "nvim")) {
    await execute(
      denops,
      `lua vim.notify("${msg}", vim.log.levels.INFO)`,
    );
  } else {
    await echo(denops, msg);
  }
}
