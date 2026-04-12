// =============================================================================
// File        : todo.ts
// Author      : yukimemi
// Last Change : 2025/12/01 00:54:57.
// =============================================================================

import type { Plug } from "@yukimemi/dvpm";

import * as fn from "@denops/std/function";
import { ensureFile } from "@std/fs/ensure-file";
import { z } from "zod";

export const todo: Plug[] = [
  {
    url: "https://github.com/arnarg/todotxt.nvim",
    profiles: ["todo"],
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
