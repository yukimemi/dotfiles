import type { Denops } from "https://deno.land/x/denops_std@v4.3.3/mod.ts";
import type { Plug } from "https://deno.land/x/dvpm@0.3.0/mod.ts";

import * as mapping from "https://deno.land/x/denops_std@v4.3.3/mapping/mod.ts";
import * as option from "https://deno.land/x/denops_std@v4.3.3/option/mod.ts";
import * as fn from "https://deno.land/x/denops_std@v4.3.3/function/mod.ts";
import { globals } from "https://deno.land/x/denops_std@v4.3.3/variable/mod.ts";
import { notify } from "../util.ts";

export const denops: Plug[] = [
  {
    url: "yukimemi/dps-autocursor",
    before: async (denops: Denops) => {
      await globals.set(denops, "autocursor_debug", false);
    },
  },
  {
    url: "yukimemi/dps-autobackup",
    before: async (denops: Denops) => {
      await globals.set(denops, "autobackup_debug", false);
      await globals.set(denops, "autobackup_enable", true);
      await globals.set(denops, "autobackup_write_echo", false);
      await globals.set(denops, "autobackup_use_ui_select", false);
      await globals.set(denops, "autobackup_blacklist_filetypes", [
        "csv",
        "ctrlp",
        "ddu-ff",
        "ddu-ff-filter",
        "ddu-filer",
        "dpswalk",
        "gin-diff",
        "gin-status",
        "list",
        "log",
        "qf",
        "quickfix",
      ]);
    },
  },
  {
    url: "yukimemi/dps-asyngrep",
    before: async (denops: Denops) => {
      await globals.set(denops, "asyngrep_debug", false);
      await globals.set(
        denops,
        "asyngrep_cfg_path",
        await fn.expand(denops, "~/.config/asyngrep/asyngrep.toml")
      );
      await option.grepformat.set(denops, "%f:%l:%c:%m");

      await mapping.map(denops, "<space>ss", "<cmd>Agp<cr>", { mode: "n" });
      await mapping.map(denops, "<space>sr", "<cmd>Agp --tool=ripgrep<cr>", {
        mode: "n",
      });
      await mapping.map(denops, "<space>sp", "<cmd>Agp --tool=pt<cr>", {
        mode: "n",
      });
      await mapping.map(denops, "<space>sj", "<cmd>Agp --tool=jvgrep<cr>", {
        mode: "n",
      });

      await mapping.map(
        denops,
        "<space>sS",
        "<cmd>Agp --tool=default-all<cr>",
        { mode: "n" }
      );
      await mapping.map(
        denops,
        "<space>sR",
        "<cmd>Agp --tool=ripgrep-all<cr>",
        { mode: "n" }
      );
      await mapping.map(denops, "<space>sP", "<cmd>Agp --tool=pt-all<cr>", {
        mode: "n",
      });
      await mapping.map(denops, "<space>sJ", "<cmd>Agp --tool=jvgrep-all<cr>", {
        mode: "n",
      });
    },
  },
  {
    url: "yukimemi/dps-autodate",
    before: async (denops: Denops) => {
      await globals.set(denops, "autodate_debug", false);
      await globals.set(denops, "autodate_config", {
        xml: {
          replace: [
            [
              '/^(.*key="version">)[^<]*(<.*)/i',
              '$1${format(now, "yyyyMMdd_HHmmss")}$2',
            ],
            [
              '/^(.*key="%{task_file}%_version">)[^<]*(<.*)/i',
              '$1${format(now, "yyyyMMdd_HHmmss")}$2',
            ],
            [
              '/^(.*key="%{task_name}%_version">)[^<]*(<.*)/i',
              '$1${format(now, "yyyyMMdd_HHmmss")}$2',
            ],
            [
              '/^(.*key="autobot_version">)[^<]*(<.*)/i',
              '$1${format(now, "yyyyMMdd_HHmmss")}$2',
            ],
          ],
          event: "BufWritePre",
          pat: ["*.xml", "*.xaml"],
          head: 30,
          tail: 5,
        },
        ps1: {
          replace: [
            [
              "/^(s*.Last Change: ).*/i",
              '$1${format(now, "yyyy/MM/dd HH:mm:ss")}',
            ],
            [
              '/^(.*"version", ")[0-9_]+(".*)/i',
              '$1${format(now, "yyyyMMdd_HHmmss")}$2',
            ],
          ],
          event: "BufWritePre",
          pat: ["*.ps1"],
          head: 50,
          tail: 5,
        },
        typescript: {
          replace: [
            [
              '/^(const version = ")[0-9_]+(";)/',
              '$1${format(now, "yyyyMMdd_HHmmss")}$2',
            ],
          ],
          event: "BufWritePre",
          pat: ["*.ts"],
          head: 50,
          tail: 5,
        },
      });
    },
  },
  {
    url: "yukimemi/dps-walk",
    before: async (denops: Denops) => {
      await globals.set(denops, "walk_debug", false);

      await mapping.map(denops, "<space>Wa", "<cmd>DenopsWalk<cr>", {
        mode: "n",
      });

      await mapping.map(denops, "<space>Wa", "<cmd>DenopsWalk<cr>", {
        mode: "n",
      });
      await mapping.map(
        denops,
        "<space>Ws",
        "<cmd>DenopsWalk --path=~/src<cr>",
        { mode: "n" }
      );
      await mapping.map(
        denops,
        "<space>Wd",
        "<cmd>DenopsWalk --path=~/.dotfiles<cr>",
        { mode: "n" }
      );
      await mapping.map(
        denops,
        "<space>Wc",
        "<cmd>DenopsWalk --path=~/.cache<cr>",
        { mode: "n" }
      );
      await mapping.map(
        denops,
        "<space>Wj",
        "<cmd>DenopsWalk --path=~/.cache/junkfile<cr>",
        { mode: "n" }
      );
      await mapping.map(
        denops,
        "<space>Wm",
        "<cmd>DenopsWalk --path=~/.memolist<cr>",
        { mode: "n" }
      );
      await mapping.map(denops, "<space>WD", "<cmd>DenopsWalkBufferDir<cr>", {
        mode: "n",
      });
    },
  },
  {
    url: "yukimemi/dps-randomcolorscheme",
    dependencies: [
      { url: "rafi/awesome-vim-colorschemes" },
      {
        url: "RRethy/nvim-base16",
        enabled: async (denops: Denops) => await fn.has(denops, "nvim"),
      },
      {
        url: "catppuccin/nvim",
        enabled: async (denops: Denops) => await fn.has(denops, "nvim"),
      },
    ],
    before: async (denops: Denops) => {
      await globals.set(denops, "randomcolorscheme_debug", false);
      await globals.set(denops, "randomcolorscheme_echo", true);
      await globals.set(denops, "randomcolorscheme_interval", 77);
      await globals.set(denops, "randomcolorscheme_disables", [
        "evening",
        "default",
        "blue",
      ]);
      await globals.set(
        denops,
        "randomcolorscheme_path",
        await fn.expand(denops, "~/.config/randomcolorscheme/colorscheme.toml")
      );
      await globals.set(denops, "randomcolorscheme_notmatch", "[Ll]ight");
      await globals.set(denops, "randomcolorscheme_background", "dark");

      await mapping.map(denops, "<space>ro", "<cmd>ChangeColorscheme<cr>", {
        mode: "n",
      });
      await mapping.map(
        denops,
        "<space>rd",
        "<cmd>DisableThisColorscheme<cr>",
        { mode: "n" }
      );
      await mapping.map(denops, "<space>rl", "<cmd>LikeThisColorscheme<cr>", {
        mode: "n",
      });
      await mapping.map(denops, "<space>rh", "<cmd>HateThisColorscheme<cr>", {
        mode: "n",
      });
    },
  },
  {
    url: "yukimemi/dps-hitori",
    before: async (denops: Denops) => {
      await globals.set(denops, "hitori_debug", false);
      await globals.set(denops, "hitori_enable", true);
      await globals.set(denops, "hitori_quit", true);

      await globals.set(denops, "hitori_blacklist_patterns", [
        ".tmp$",
        ".diff$",
        "(COMMIT_EDIT|TAG_EDIT|MERGE_|SQUASH_)MSG$",
      ]);
    },
    after: async (denops: Denops) => {
      await notify(denops, "dps-hitori loaded");
    },
  },
];
