import markdownItHighlightjs from "https://cdn.skypack.dev/markdown-it-highlightjs";
import markdownItEmoji from "https://cdn.skypack.dev/markdown-it-emoji";
import markdownItMermaid from "https://cdn.skypack.dev/@mogamitsuchikawa/markdown-it-mermaid";
import MarkdownIt from "https://cdn.skypack.dev/markdown-it";

export function createMarkdownRenderer(md: MarkdownIt): MarkdownIt {
  return md.use(markdownItEmoji).use(markdownItMermaid).use(
    markdownItHighlightjs,
  );
}
