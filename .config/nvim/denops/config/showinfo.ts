// =============================================================================
// File        : showinfo.ts
// Author      : yukimemi
// Last Change : 2025/05/03 08:23:30.
// =============================================================================

import * as fn from "jsr:@denops/std@7.6.0/function";
import * as op from "jsr:@denops/std@7.6.0/option";
import * as vars from "jsr:@denops/std@7.6.0/variable";
import type { Denops } from "jsr:@denops/std@7.6.0";
import { notify } from "./util.ts";
import { z } from "npm:zod@4.0.16";

type LspClient = {
  id: number;
  name: string;
  [key: string]: unknown;
};

export async function notifyinfo(denops: Denops) {
  await notify(denops, [
    "Show info",
    "------------------------------",
    `colorscheme: [${await vars.g.get(denops, "colors_name")}], priority: [${await vars.g.get(
      denops,
      "lumiris_priority",
    )}]`,
    `pwd: [${await fn.getcwd(denops)}]`,
    `path: [${await fn.expand(denops, "%:p")}]`,
    `encoding: [${await op.fileencoding.get(denops)}]`,
    `fileformat: [${await op.fileformat.get(denops)}]`,
    `filetype: [${await op.filetype.get(denops)}]`,
    `lsp: [${await getLspNamesLua(denops)}]`,
    `bomb: [${await op.bomb.get(denops)}]`,
  ], { timeout: 60000, type: "snacks" });
}

export async function getLspNames(denops: Denops): Promise<string> {
  const bufnr = await fn.bufnr(denops);
  const clients = await denops.call(`luaeval`, `vim.lsp.get_clients(_A)`, { bufnr }) as LspClient[];
  console.log({ clients });
  const names = clients.map((client) => client.name);
  return names.join(", ");
}

export async function getLspNamesLua(denops: Denops): Promise<string> {
  return z.string().parse(
    await denops.call(
      `luaeval`,
      `(function()
        local bufnr = vim.api.nvim_get_current_buf()
        local clients = vim.lsp.get_clients({ bufnr = bufnr })
        local names = {}
        for _, client in ipairs(clients) do
          table.insert(names, client.name)
        end
        return vim.fn.join(names, ",")
      end)()`,
    ),
  );
}
