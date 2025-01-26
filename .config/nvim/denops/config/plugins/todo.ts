// =============================================================================
// File        : todo.ts
// Author      : yukimemi
// Last Change : 2025/01/26 11:38:37.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@6.1.1";

import * as fn from "jsr:@denops/std@7.4.0/function";
import { ensureFile } from "jsr:@std/fs@1.0.10/ensure-file";
import { z } from "npm:zod@3.24.1";

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
