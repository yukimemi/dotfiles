// =============================================================================
// File        : todo.ts
// Author      : yukimemi
// Last Change : 2025/09/21 17:10:50.
// =============================================================================

import type { Plug } from "@yukimemi/dvpm";

import * as fn from "@denops/std/function";
import { ensureFile } from "@std/fs/ensure-file";
import { z } from "zod";

export const todo: Plug[] = [
  {
    url: "https://github.com/arnarg/todotxt.nvim",
    after: async ({ denops }) => {
      const todo_path = z.string().parse(
        await fn.expand(denops, "~/.todo.txt"),
      );
      await ensureFile(todo_path);
      await denops.call(`luaeval`, `require("todotxt-nvim").setup(_A)`, {
        todo_file: todo_path,
      });
    },
  },
];
