import { Denops } from "https://deno.land/x/denops_core@v5.0.0/denops.ts";
import type { Plug } from "https://deno.land/x/dvpm@0.3.3/mod.ts";
import * as autocmd from "https://deno.land/x/denops_std@v5.0.0/autocmd/mod.ts";

export const filetypes: Plug[] = [
  {
    url: "aklt/plantuml-syntax",
    before: async (denops: Denops) => {
      await autocmd.group(denops, "MyPlantUml", (helper) => {
        helper.remove("*");
        helper.define(
          ["BufNew", "BufRead"],
          ["*.uml", "*.plantuml"],
          "setl ft=plantuml"
        );
      });
    },
  },
];
