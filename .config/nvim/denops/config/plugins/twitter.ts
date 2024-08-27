// =============================================================================
// File        : twitter.ts
// Author      : yukimemi
// Last Change : 2023/07/16 00:38:51.
// =============================================================================

import type { Plug } from "jsr:@yukimemi/dvpm@4.0.2";

import { batch } from "jsr:@denops/std@7.1.0/batch";
import * as autocmd from "jsr:@denops/std@7.1.0/autocmd";
import * as lambda from "jsr:@denops/std@7.1.0/lambda";
import * as mapping from "jsr:@denops/std@7.1.0/mapping";

export const twitter: Plug[] = [
  {
    url: "https://github.com/skanehira/denops-twihi.vim",
    enabled: false,
    clone: false,
    after: async ({ denops }) => {
      await mapping.map(denops, "<space>Th", "<cmd>TwihiHome<cr>", {
        mode: "n",
      });
      await mapping.map(denops, "<space>Tm", "<cmd>TwihiMentions<cr>", {
        mode: "n",
      });
      await autocmd.group(denops, "MyTwihiSetting", (helper) => {
        helper.remove("*");
        helper.define(
          "FileType",
          "twihi-timeline",
          `call <SID>${denops.name}_notify("${
            lambda.register(
              denops,
              async () => {
                await batch(denops, async (denops) => {
                  await mapping.map(denops, "y", "<Plug>(twihi:tweet:yank)", {
                    mode: "n",
                    buffer: true,
                  });
                  await mapping.map(denops, "l", "<Plug>(twihi:tweet:like)", {
                    mode: "n",
                    buffer: true,
                  });
                  await mapping.map(denops, "o", "<Plug>(twihi:tweet:open)", {
                    mode: "n",
                    buffer: true,
                  });
                  await mapping.map(denops, "r", "<Plug>(twihi:reply)", {
                    mode: "n",
                    buffer: true,
                  });
                  await mapping.map(denops, "R", "<Plug>(twihi:retweet)", {
                    mode: "n",
                    buffer: true,
                  });
                  await mapping.map(
                    denops,
                    "T",
                    "<Plug>(twihi:retweet:comment)",
                    { mode: "n", buffer: true },
                  );
                  await mapping.map(denops, "J", "<Plug>(twihi:tweet:next)", {
                    mode: "n",
                    buffer: true,
                  });
                  await mapping.map(denops, "K", "<Plug>(twihi:tweet:prev)", {
                    mode: "n",
                    buffer: true,
                  });
                  await mapping.map(denops, "s", "<cmd>TwihiTweet<cr>", {
                    mode: "n",
                    buffer: true,
                  });
                  await mapping.map(denops, "S", ":<c-u>TwihiSearch<space>", {
                    mode: "n",
                    buffer: true,
                  });
                });
              },
            )
          }", [])`,
        );
      });
    },
  },
];
