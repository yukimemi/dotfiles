// =============================================================================
// File        : todo.ts
// Author      : yukimemi
// Last Change : 2024/07/27 22:22:06.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@4.0.2";

import * as fn from "jsr:@denops/std@7.0.0/function";
import { ensureFile } from "jsr:@std/fs@1.0.0/ensure-file";
import { z } from "npm:zod@3.23.8";

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
