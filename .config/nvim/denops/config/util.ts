import type { Denops } from "./dep.ts";
import { echo, execute, has } from "./dep.ts";

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
