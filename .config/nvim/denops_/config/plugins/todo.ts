// =============================================================================
// File        : todo.ts
// Author      : yukimemi
// Last Change : 2023/09/25 01:22:03.
// =============================================================================

import type { Plug } from "https://deno.land/x/dvpm@3.3.4/mod.ts";

import * as fn from "https://deno.land/x/denops_std@v5.0.1/function/mod.ts";
import { ensureFile } from "https://deno.land/std@0.204.0/fs/ensure_file.ts";
import { ensure, is } from "https://deno.land/x/unknownutil@v3.10.0/mod.ts";

export const todo: Plug[] = [
  {
    url: "arnarg/todotxt.nvim",
    // deno-lint-ignore require-await
    enabled: async ({ denops }) => denops.meta.host === "nvim",
    after: async ({ denops }) => {
      const todo_path = ensure(await fn.expand(denops, "~/.todo.txt"), is.String);
      await ensureFile(todo_path);
      await denops.call(`luaeval`, `require("todotxt-nvim").setup(_A)`, {
        todo_file: todo_path,
      });
    },
  },
];
