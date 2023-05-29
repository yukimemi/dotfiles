import { Denops } from "https://deno.land/x/denops_core@v5.0.0/denops.ts";
import type { Plug } from "https://deno.land/x/dvpm@0.3.7/mod.ts";

import * as autocmd from "https://deno.land/x/denops_std@v5.0.0/autocmd/mod.ts";
import * as fn from "https://deno.land/x/denops_std@v5.0.0/function/mod.ts";
import { globals } from "https://deno.land/x/denops_std@v5.0.0/variable/mod.ts";

export const filetypes: Plug[] = [
  {
    url: "aklt/plantuml-syntax",
    before: async (denops: Denops) => {
      await autocmd.group(denops, "MyPlantUml", (helper) => {
        helper.remove("*");
        helper.define(
          ["BufNew", "BufRead"],
          ["*.uml", "*.plantuml"],
          "setl ft=plantuml",
        );
      });
    },
  },
  {
    url: "uga-rosa/scorpeon.vim",
    before: async (denops: Denops) => {
      await globals.set(denops, "scorpeon_extensions_path", [
        await fn.expand(denops, "~/.cache/vscode/extensions"),
        await fn.expand(denops, "~/.cache/scorpeon"),
      ]);
      await globals.set(denops, "scorpeon_highlight", {
        enable: ["log", "toml", "nim"],
      });
      await autocmd.group(denops, "MyScorpeon", (helper) => {
        helper.remove("*");
        helper.define(["BufNew", "BufRead"], ["*.log"], "setl ft=log");
        helper.define(["BufNew", "BufRead"], ["*.nim"], "setl ft=nim");
        helper.define(["BufNew", "BufRead"], ["*.toml"], "setl ft=toml");
      });
    },
    dependencies: [
      {
        url: "microsoft/vscode",
        dst: "~/.cache/vscode",
        enabled: false,
      },
      {
        url: "saem/vscode-nim",
        dst: "~/.cache/scorpeon/nim",
        enabled: false,
      },
      {
        url: "oovm/vscode-toml",
        dst: "~/.cache/scorpeon/toml",
        enabled: false,
      },
      {
        url: "emilast/vscode-logfile-highlighter",
        dst: "~/.cache/scorpeon/log",
        enabled: false,
      },
    ],
  },
  {
    url: "tani/glance-vim",
    before: async (denops: Denops) => {
      await globals.set(denops, "glance#markdown_breaks", true);
      await globals.set(denops, "glance#markdown_html", true);

      await globals.set(
        denops,
        "glance#config",
        `file:///${await fn.expand(denops, "~/.config/glance/init.ts")}`,
      );
    },
  },
];
