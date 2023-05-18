import type { Denops } from "./dep.ts";
import { globals, has } from "./dep.ts";

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
