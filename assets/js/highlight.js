import { createHighlighterCore } from "shiki/core";
import { createJavaScriptRegexEngine } from "shiki/engine/javascript";
import githubDark from "shiki/themes/github-dark.mjs";
import langElixir from "shiki/langs/elixir.mjs";
import langRust from "shiki/langs/rust.mjs";
import langBash from "shiki/langs/bash.mjs";
import langPython from "shiki/langs/python.mjs";

let highlighterPromise = null;

function getHighlighter() {
  if (!highlighterPromise) {
    highlighterPromise = createHighlighterCore({
      themes: [githubDark],
      langs: [langElixir, langRust, langBash, langPython],
      engine: createJavaScriptRegexEngine(),
    });
  }
  return highlighterPromise;
}

/**
 * Highlights code using Shiki with dual theme support.
 * Returns the highlighted HTML string.
 */
export async function highlightCode(code, lang) {
  const highlighter = await getHighlighter();
  const loadedLangs = highlighter.getLoadedLanguages();

  // Fall back to plaintext if the requested lang isn't loaded
  const effectiveLang = loadedLangs.includes(lang) ? lang : "text";

  return highlighter.codeToHtml(code, {
    lang: effectiveLang,
    theme: "github-dark",
  });
}

// Expose globally so colocated hooks can access it
window.__highlightCode = highlightCode;
