## Gemini Added Memories
- User uses NeoVim with a custom Denops-based plugin manager (Dvpm). Configuration files are largely in `.config/nvim/rc/after`. LSP settings for specific servers are found in `.config/nvim/after/lsp/`. Formatting is handled by `conform.nvim` with LSP fallback.
- The user's name is yukimemi. Address them as 'yukimemi' instead of 'user-sama'.
- The user's blog is built with Lume (Deno static site generator).
- Always respond in Japanese.

# CORE PRINCIPLES

- Follow Kent Beck's Test-Driven Development (TDD) methodology as the preferred approach for all development work.
- Document at the right layer: Code → How, Tests → What, Commits → Why, Comments → Why not
- Keep documentation up to date with code changes
- The codebase contains duplicated `cmdOutToString` functions in `git.ts` and `util.ts`, and `dvpm.ts` has complex methods like `end` and `bufWriteList` that need refactoring.
- Always ask yukimemi for confirmation before committing or running `deno publish`.
- Always update documentation (README.md, type comments, etc.) alongside code changes to ensure they remain consistent and up-to-date.
- Prefer Jujutsu (jj) over Git for all version control operations. The project environment is configured with co-located Git and Jujutsu.