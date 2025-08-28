// =============================================================================
// File        : todo.ts
// Author      : yukimemi
// Last Change : 2025/02/01 13:35:37.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@7.1.0";

import * as fn from "jsr:@denops/std@8.0.0/function";
import { ensureFile } from "jsr:@std/fs@1.0.19/ensure-file";
import { z } from "npm:zod@4.1.4";

export const todo: Plug[] = [
  {
    url: "https://github.com/arnarg/todotxt.nvim",
    after: async ({ denops }) => {
      const todo_path = z.string().parse(await fn.expand(denops, "~/.todo.txt"));
      await ensureFile(todo_path);
      await denops.call(`luaeval`, `require("todotxt-nvim").setup(_A)`, {
        todo_file: todo_path,
      });
    },
  },
];
