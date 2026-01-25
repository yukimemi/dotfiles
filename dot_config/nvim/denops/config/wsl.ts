// =============================================================================
// File        : wsl.ts
// Author      : yukimemi
// Last Change : 2025/09/21 17:06:55.
// =============================================================================

import type { Denops } from "@denops/std";
import * as vars from "@denops/std/variable";

import * as fn from "@denops/std/function";

export async function setWsl(denops: Denops) {
  if (!(await fn.has(denops, "wsl"))) {
    return;
  }

  await vars.g.set(denops, "clipboard", {
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
