// =============================================================================
// File        : wsl.ts
// Author      : yukimemi
// Last Change : 2024/07/27 22:23:12.
// =============================================================================

import type { Denops } from "jsr:@denops/std@7.3.2";
import * as vars from "jsr:@denops/std@7.3.2/variable";

import * as fn from "jsr:@denops/std@7.3.2/function";

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
