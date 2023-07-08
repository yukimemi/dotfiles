import MarkdownIt from "https://esm.sh/markdown-it";
import markdownItEmoji from "https://esm.sh/markdown-it-emoji";
import markdownItHighlightjs from "https://esm.sh/markdown-it-highlightjs";
import markdownItMermaid from "https://esm.sh/@mogamitsuchikawa/markdown-it-mermaid";

export function createMarkdownRenderer(md: MarkdownIt): MarkdownIt {
  return md.use([markdownItEmoji, markdownItHighlightjs, markdownItMermaid]);
}
