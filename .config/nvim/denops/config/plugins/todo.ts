// =============================================================================
// File        : todo.ts
// Author      : yukimemi
// Last Change : 2023/09/25 01:22:03.
// =============================================================================

import type { Plug } from "https://deno.land/x/dvpm@3.7.2/mod.ts";

import * as fn from "https://deno.land/x/denops_std@v5.2.0/function/mod.ts";
import { ensureFile } from "https://deno.land/std@0.211.0/fs/ensure_file.ts";
import { ensure, is } from "https://deno.land/x/unknownutil@v3.11.0/mod.ts";

export const todo: Plug[] = [
  {
    url: "https://github.com/arnarg/todotxt.nvim",
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
