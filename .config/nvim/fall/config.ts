// =============================================================================
// File        : config.ts
// Author      : yukimemi
// Last Change : 2024/11/17 19:34:10.
// =============================================================================

import type { Entrypoint } from "jsr:@vim-fall/config@^0.17.3";
import {
  composeRenderers,
  defineSource,
  refineCurator,
  refineSource,
  Source,
} from "jsr:@vim-fall/std@^0.8.0";
import * as builtin from "jsr:@vim-fall/std@^0.8.0/builtin";
import { SEPARATOR } from "jsr:@std/path@^1.0.8/constants";
// import { TextLineStream } from "jsr:@std/streams@1.0.8/text-line-stream";

// NOTE:
//
// Install https://github.com/BurntSushi/ripgrep to use 'builtin.curator.rg'
// Install https://www.nerdfonts.com/ to use 'builtin.renderer.nerdfont'
// Install https://github.com/thinca/vim-qfreplace to use 'Qfreplace'
//

const myPathActions = {
  ...builtin.action.defaultOpenActions,
  ...builtin.action.defaultSystemopenActions,
  ...builtin.action.defaultCdActions,
};

const myQuickfixActions = {
  ...builtin.action.defaultQuickfixActions,
  // Install https://github.com/thinca/vim-qfreplace to use this action
  "quickfix:qfreplace": builtin.action.quickfix({
    after: "Qfreplace",
  }),
};

const myMiscActions = {
  ...builtin.action.defaultEchoActions,
  ...builtin.action.defaultYankActions,
  ...builtin.action.defaultSubmatchActions,
};

const myFilterFile = (path: string) => {
  const excludes = [
    ".7z",
    ".DS_Store",
    ".avi",
    ".avi",
    ".bmp",
    ".class",
    ".dll",
    ".dmg",
    ".doc",
    ".docx",
    ".dylib",
    ".ear",
    ".exe",
    ".fla",
    ".flac",
    ".flv",
    ".gif",
    ".ico",
    ".id_ed25519",
    ".id_rsa",
    ".iso",
    ".jar",
    ".jpeg",
    ".jpg",
    ".key",
    ".mkv",
    ".mov",
    ".mp3",
    ".mp4",
    ".mpeg",
    ".mpg",
    ".o",
    ".obj",
    ".ogg",
    ".pdf",
    ".png",
    ".ppt",
    ".pptx",
    ".rar",
    ".so",
    ".swf",
    ".tar.gz",
    ".war",
    ".wav",
    ".webm",
    ".wma",
    ".wmv",
    ".xls",
    ".xlsx",
    ".zip",
  ];
  for (const exclude of excludes) {
    if (path.endsWith(exclude)) {
      return false;
    }
  }
  return true;
};

const myFilterDirectory = (path: string) => {
  const excludes = [
    "$RECYVLE.BIN",
    ".git",
    ".hg",
    ".ssh",
    ".svn",
    "__pycache__", // Python
    "build", // C/C++
    "node_modules", // Node.js
    "target", // Rust
  ];
  for (const exclude of excludes) {
    if (path.includes(`${SEPARATOR}${exclude}${SEPARATOR}`)) {
      return false;
    }
  }
  return true;
};

type Detail = {
  /**
   * Absolute path of the file.
   */
  path: string;
};
type ChronicleOptions = "read" | "write";

function chronicle(options: Readonly<ChronicleOptions> = "read"): Source<Detail> {
  return defineSource(async function* (denops, { args }, { signal }) {
    const filepath = options == "write"
      ? "~/.cache/chronicle/write"
      : options == "read"
      ? "~/.cache/chronicle/read"
      : args[0];
    // const file = await Deno.open(await denops.eval("fnamemodify(expand(path), ':p')", { path: filepath }) as string);
    // const lineStream = file.readable
    //   .pipeThrough(new TextDecoderStream())
    //   .pipeThrough(new TextLineStream());

    const fileContent = await Deno.readTextFile(
      await denops.eval("fnamemodify(expand(path), ':p')", { path: filepath }) as string,
    );
    const lines = fileContent.split("\n").reverse();

    let id = 0;
    // for await (const line of lineStream) {
    for await (const line of lines) {
      signal?.throwIfAborted();
      yield {
        id: id++,
        value: line,
        detail: { path: line },
      };
    }
  });
}

export const main: Entrypoint = (
  {
    defineItemPickerFromSource,
    defineItemPickerFromCurator,
    refineGlobalConfig,
  },
) => {
  refineGlobalConfig({
    coordinator: builtin.coordinator.modern,
    theme: builtin.theme.MODERN_THEME,
  });

  defineItemPickerFromCurator(
    "git-grep",
    refineCurator(
      builtin.curator.gitGrep,
      builtin.refiner.relativePath,
    ),
    {
      sorters: [
        builtin.sorter.noop,
        builtin.sorter.lexical,
        builtin.sorter.lexical({ reverse: true }),
      ],
      renderers: [
        builtin.renderer.nerdfont,
        builtin.renderer.noop,
      ],
      previewers: [builtin.previewer.file],
      actions: {
        ...myPathActions,
        ...myQuickfixActions,
        ...myMiscActions,
      },
      defaultAction: "open",
    },
  );

  defineItemPickerFromCurator(
    "rg",
    refineCurator(
      builtin.curator.rg,
      builtin.refiner.relativePath,
    ),
    {
      sorters: [
        builtin.sorter.noop,
        builtin.sorter.lexical,
        builtin.sorter.lexical({ reverse: true }),
      ],
      renderers: [
        builtin.renderer.nerdfont,
        builtin.renderer.noop,
      ],
      previewers: [builtin.previewer.file],
      actions: {
        ...myPathActions,
        ...myQuickfixActions,
        ...myMiscActions,
      },
      defaultAction: "open",
    },
  );

  defineItemPickerFromSource(
    "file",
    refineSource(
      builtin.source.file({
        filterFile: myFilterFile,
        filterDirectory: myFilterDirectory,
      }),
      builtin.refiner.relativePath,
    ),
    {
      matchers: [builtin.matcher.fzf],
      sorters: [
        builtin.sorter.noop,
        builtin.sorter.lexical,
        builtin.sorter.lexical({ reverse: true }),
      ],
      renderers: [
        composeRenderers(
          builtin.renderer.smartPath,
          builtin.renderer.nerdfont,
        ),
        builtin.renderer.nerdfont,
        builtin.renderer.noop,
      ],
      previewers: [builtin.previewer.file],
      actions: {
        ...myPathActions,
        ...myQuickfixActions,
        ...myMiscActions,
      },
      defaultAction: "open",
    },
  );

  defineItemPickerFromSource(
    "file:all",
    refineSource(
      builtin.source.file,
      builtin.refiner.relativePath,
    ),
    {
      matchers: [builtin.matcher.fzf],
      sorters: [
        builtin.sorter.noop,
        builtin.sorter.lexical,
        builtin.sorter.lexical({ reverse: true }),
      ],
      renderers: [
        composeRenderers(
          builtin.renderer.smartPath,
          builtin.renderer.nerdfont,
        ),
        builtin.renderer.nerdfont,
        builtin.renderer.noop,
      ],
      previewers: [builtin.previewer.file],
      actions: {
        ...myPathActions,
        ...myQuickfixActions,
        ...myMiscActions,
      },
      defaultAction: "open",
    },
  );

  defineItemPickerFromSource("line", builtin.source.line, {
    matchers: [builtin.matcher.fzf],
    previewers: [builtin.previewer.buffer],
    actions: {
      ...myQuickfixActions,
      ...myMiscActions,
      ...builtin.action.defaultOpenActions,
      ...builtin.action.defaultBufferActions,
    },
    defaultAction: "open",
  });

  defineItemPickerFromSource(
    "buffer",
    builtin.source.buffer({ filter: "bufloaded" }),
    {
      matchers: [builtin.matcher.fzf],
      sorters: [
        builtin.sorter.noop,
        builtin.sorter.lexical,
        builtin.sorter.lexical({ reverse: true }),
      ],
      previewers: [builtin.previewer.buffer],
      actions: {
        ...myQuickfixActions,
        ...myMiscActions,
        ...builtin.action.defaultOpenActions,
        ...builtin.action.defaultBufferActions,
      },
      defaultAction: "open",
    },
  );

  defineItemPickerFromSource("help", builtin.source.helptag, {
    matchers: [builtin.matcher.fzf],
    sorters: [
      builtin.sorter.noop,
      builtin.sorter.lexical,
      builtin.sorter.lexical({ reverse: true }),
    ],
    previewers: [builtin.previewer.helptag],
    actions: {
      ...myMiscActions,
      ...builtin.action.defaultHelpActions,
    },
    defaultAction: "help",
  });

  defineItemPickerFromSource(
    "chronicle:read",
    refineSource(
      chronicle("read"),
      builtin.refiner.relativePath,
    ),
    {
      matchers: [builtin.matcher.fzf],
      sorters: [
        builtin.sorter.noop,
      ],
      renderers: [
        composeRenderers(
          builtin.renderer.smartPath,
          builtin.renderer.nerdfont,
        ),
        builtin.renderer.nerdfont,
        builtin.renderer.noop,
      ],
      previewers: [builtin.previewer.file],
      actions: {
        ...myPathActions,
        ...myMiscActions,
      },
      defaultAction: "open",
    },
  );
  defineItemPickerFromSource(
    "chronicle:write",
    refineSource(
      chronicle("write"),
      builtin.refiner.relativePath,
    ),
    {
      matchers: [builtin.matcher.fzf],
      sorters: [
        builtin.sorter.noop,
      ],
      renderers: [
        composeRenderers(
          builtin.renderer.smartPath,
          builtin.renderer.nerdfont,
        ),
        builtin.renderer.nerdfont,
        builtin.renderer.noop,
      ],
      previewers: [builtin.previewer.file],
      actions: {
        ...myPathActions,
        ...myMiscActions,
      },
      defaultAction: "open",
    },
  );
};
