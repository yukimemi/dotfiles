import {
  BaseConfig,
  ConfigReturn,
  ContextBuilder,
  Dpp,
  Plugin,
} from "https://deno.land/x/dpp_vim@v0.0.5/types.ts";
import { Denops, fn } from "https://deno.land/x/dpp_vim@v0.0.5/deps.ts";

type Toml = {
  hooks_file?: string;
  ftplugins?: Record<string, string>;
  plugins: Plugin[];
};

type LazyMakeStateResult = {
  plugins: Plugin[];
  stateLines: string[];
};

export class Config extends BaseConfig {
  override async config(args: {
    denops: Denops;
    contextBuilder: ContextBuilder;
    basePath: string;
    dpp: Dpp;
  }): Promise<ConfigReturn> {
    const hasNvim = args.denops.meta.host === "nvim";
    const hasWindows = await fn.has(args.denops, "win32");

    const inlineVimrcs = [
      "$BASE_DIR/options.vim",
      "$BASE_DIR/mappings.vim",
      "$BASE_DIR/filetype.vim",
    ];
    if (hasNvim) {
      inlineVimrcs.push("$BASE_DIR/neovim.vim");
    } else if (await fn.has(args.denops, "gui_running")) {
      inlineVimrcs.push("$BASE_DIR/gui.vim");
    }
    if (hasWindows) {
      inlineVimrcs.push("$BASE_DIR/windows.vim");
    } else {
      inlineVimrcs.push("$BASE_DIR/unix.vim");
    }

    args.contextBuilder.setGlobal({
      inlineVimrcs,
      extParams: {
        installer: {
          checkDiff: true,
        },
      },
      protocols: ["git"],
    });

    const [context, options] = await args.contextBuilder.get(args.denops);

    // Load toml plugins
    const tomls: Toml[] = [];
    for (
      const toml of [
        "$BASE_DIR/toml/merge.toml",
        "$BASE_DIR/toml/dpp.toml",
      ]
    ) {
      tomls.push(await args.dpp.extAction(
          args.denops,
          context,
          options,
          "toml",
          "load",
          {
            path: toml,
            options: {
              lazy: false,
            },
          },
        ) as Toml,
      );
    }
    for (
      const toml of [
        "$BASE_DIR/toml/lazy.toml",
        "$BASE_DIR/toml/textobj.toml",
        "$BASE_DIR/toml/operator.toml",
        "$BASE_DIR/toml/denops.toml",
        "$BASE_DIR/toml/ddc.toml",
        "$BASE_DIR/toml/ddu.toml",
        "$BASE_DIR/toml/neovim.toml",
        "$BASE_DIR/toml/colorscheme.toml",
        "$BASE_DIR/toml/ui.toml",
      ]
    ) {
      tomls.push(await args.dpp.extAction(
          args.denops,
          context,
          options,
          "toml",
          "load",
          {
            path: toml,
            options: {
              lazy: true,
            },
          },
        ) as Toml,
      );
    }

    // Merge toml results
    const recordPlugins: Record<string, Plugin> = {};
    const ftplugins: Record<string, string> = {};
    const hooksFiles: string[] = [];
    for (const toml of tomls) {
      for (const plugin of toml.plugins) {
        recordPlugins[plugin.name] = plugin;
      }

      if (toml.ftplugins) {
        for (const filetype of Object.keys(toml.ftplugins)) {
          if (ftplugins[filetype]) {
            ftplugins[filetype] += `\n${toml.ftplugins[filetype]}`;
          } else {
            ftplugins[filetype] = toml.ftplugins[filetype];
          }
        }
      }

      if (toml.hooks_file) {
        hooksFiles.push(toml.hooks_file);
      }
    }

    const lazyResult = await args.dpp.extAction(
      args.denops,
      context,
      options,
      "lazy",
      "makeState",
      {
        plugins: Object.values(recordPlugins),
      },
    ) as LazyMakeStateResult;

    return {
      checkFiles: await fn.globpath(
        args.denops,
        Deno.env.get("BASE_DIR"),
        "*",
        1,
        1,
      ) as unknown as string[],
      ftplugins,
      hooksFiles,
      plugins: lazyResult.plugins,
      stateLines: lazyResult.stateLines,
    };
  }
}
