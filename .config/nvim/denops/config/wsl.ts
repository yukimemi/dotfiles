// =============================================================================
// File        : wsl.ts
// Author      : yukimemi
// Last Change : 2023/12/03 18:51:13.
// =============================================================================

import type { Denops } from "https://deno.land/x/denops_std@v6.2.0/mod.ts";
import * as vars from "https://deno.land/x/denops_std@v6.2.0/variable/mod.ts";

import * as fn from "https://deno.land/x/denops_std@v6.2.0/function/mod.ts";

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
