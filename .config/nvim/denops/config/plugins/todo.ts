// =============================================================================
// File        : todo.ts
// Author      : yukimemi
// Last Change : 2024/03/30 14:31:48.
// =============================================================================

import type { Plug } from "https://deno.land/x/dvpm@3.10.1/mod.ts";

import * as fn from "https://deno.land/x/denops_std@v6.4.0/function/mod.ts";
import { ensureFile } from "https://deno.land/std@0.223.0/fs/ensure_file.ts";
import { z } from "https://deno.land/x/zod@v3.23.3/mod.ts";

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
