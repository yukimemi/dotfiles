// =============================================================================
// File        : keymap.ts
// Author      : yukimemi
// Last Change : 2023/12/03 18:52:09.
// =============================================================================

import * as lambda from "jsr:@denops/std@7.0.0/lambda";
import * as mapping from "jsr:@denops/std@7.0.0/mapping";
import type { Denops } from "jsr:@denops/std@7.0.0";
import { batch } from "jsr:@denops/std@7.0.0/batch";
import * as vars from "jsr:@denops/std@7.0.0/variable";
import * as autocmd from "jsr:@denops/std@7.0.0/autocmd";
import { focusFloating, openBufDir, reviewMode } from "./util.ts";

export async function setKeymapPre(denops: Denops) {
  await batch(denops, async (denops: Denops) => {
    await vars.g.set(denops, "mapleader", " ");
    await vars.g.set(denops, "maplocalleader", "\\");

    // keymaps.
    await mapping.map(denops, "<leader><leader>", "<cmd>update<cr>", {
      mode: "n",
      silent: true,
    });
    await mapping.map(denops, "<esc>", "<C-\\><C-n>", {
      mode: "t",
      silent: true,
    });

    await mapping.map(denops, "<esc><esc>", "<cmd>nohlsearch<cr>", {
      mode: "n",
      silent: true,
    });

    await mapping.map(denops, "j", "gj", { mode: ["n", "x"], silent: true });
    await mapping.map(denops, "k", "gk", { mode: ["n", "x"], silent: true });
    await mapping.map(denops, "<tab>", "%", { mode: ["n", "x"], silent: true });
    await mapping.map(denops, "gh", "^", { mode: ["n", "x"], silent: true });
    await mapping.map(denops, "gl", "$", { mode: ["n", "x"], silent: true });

    await mapping.map(denops, "<c-l>", "<c-g>U<right>", {
      mode: "i",
      silent: true,
    });

    // `s` prefix mappings.
    await mapping.map(denops, "s", "<Nop>", { mode: "n", silent: true });
    await mapping.map(denops, "s0", "<cmd>only<cr>", {
      mode: "n",
      silent: true,
    });
    await mapping.map(denops, "s=", "<c-w>=", { mode: "n", silent: true });
    await mapping.map(denops, "sH", "<c-w>H", { mode: "n", silent: true });
    await mapping.map(denops, "sJ", "<c-w>J", { mode: "n", silent: true });
    await mapping.map(denops, "sK", "<c-w>K", { mode: "n", silent: true });
    await mapping.map(denops, "sL", "<c-w>L", { mode: "n", silent: true });
    await mapping.map(denops, "sO", "<cmd>tabonly<cr>", {
      mode: "n",
      silent: true,
    });
    await mapping.map(denops, "sQ", "<cmd>qa<cr>", { mode: "n", silent: true });
    await mapping.map(denops, "sbk", "<cmd>bd!<cr>", {
      mode: "n",
      silent: true,
    });
    await mapping.map(denops, "sbq", "<cmd>q!<cr>", {
      mode: "n",
      silent: true,
    });
    await mapping.map(denops, "sn", "<cmd>bn<cr>", { mode: "n", silent: true });
    await mapping.map(denops, "so", "<c-w>_<c-w>|", {
      mode: "n",
      silent: true,
    });
    await mapping.map(denops, "sp", "<cmd>bp<cr>", { mode: "n", silent: true });
    await mapping.map(denops, "sq", "<cmd>q<cr>", { mode: "n", silent: true });
    await mapping.map(denops, "sr", "<c-w>r", { mode: "n", silent: true });
    await mapping.map(denops, "sh", "<cmd>sp<cr>", { mode: "n", silent: true });
    await mapping.map(denops, "st", "<cmd>tabnew<cr>", {
      mode: "n",
      silent: true,
    });
    await mapping.map(denops, "sv", "<cmd>vs<cr>", { mode: "n", silent: true });
    // await mapping.map(denops, "sw", "<c-w>w", { mode: "n", silent: true });

    await mapping.map(denops, "<c-h>", "<c-w>h", { mode: "n", silent: true });
    await mapping.map(denops, "<c-l>", "<c-w>l", { mode: "n", silent: true });
    await mapping.map(denops, "<c-j>", "<c-w>j", { mode: "n", silent: true });
    await mapping.map(denops, "<c-k>", "<c-w>k", { mode: "n", silent: true });

    await mapping.map(denops, "<c-p>", "<up>", { mode: "c" });
    await mapping.map(denops, "<c-n>", "<down>", { mode: "c" });
    await mapping.map(denops, "<c-f>", "<right>", { mode: "c" });
    await mapping.map(denops, "<c-b>", "<left>", { mode: "c" });
    await mapping.map(denops, "<c-a>", "<home>", { mode: "c" });
    await mapping.map(denops, "<c-e>", "<end>", { mode: "c" });

    await mapping.map(denops, "<c-n>", "gt", { mode: "n" });
    await mapping.map(denops, "<c-p>", "gT", { mode: "n" });

    autocmd.group(denops, "MyQuickfixMapping", (helper) => {
      helper.remove("*");
      helper.define(
        "FileType",
        "qf",
        `call <SID>${denops.name}_notify("${
          lambda.register(denops, async () => {
            await mapping.map(denops, "<c-n>", "<cmd>cnewer<cr>", { mode: "n", buffer: true });
            await mapping.map(denops, "<c-p>", "<cmd>colder<cr>", { mode: "n", buffer: true });
          })
        }", [])`,
      );
    });

    await focusFloating(denops);
  });
}

export async function setKeymapPost(denops: Denops) {
  await batch(denops, async (denops: Denops) => {
    await mapping.map(
      denops,
      "<leader>Rb",
      `<cmd>call <SID>${denops.name}_notify("${
        lambda.register(denops, async () => await reviewMode(denops))
      }", [])<cr>`,
      { mode: "n" },
    );
    await mapping.map(
      denops,
      "<leader>Re",
      `<cmd>call <SID>${denops.name}_notify("${
        lambda.register(denops, async () => await reviewMode(denops, true))
      }", [])<cr>`,
      { mode: "n" },
    );

    await mapping.map(
      denops,
      "<leader>o",
      `<cmd>call <SID>${denops.name}_notify("${
        lambda.register(denops, async () => await openBufDir(denops))
      }", [])<cr>`,
      { mode: "n" },
    );
  });
}
