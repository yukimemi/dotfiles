import type { Denops } from "https://deno.land/x/denops_std@v4.3.3/mod.ts";
import { globals } from "https://deno.land/x/denops_std@v4.3.3/variable/mod.ts";
import { has } from "https://deno.land/x/denops_std@v4.3.3/function/mod.ts";

export async function setWsl(denops: Denops) {
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
}