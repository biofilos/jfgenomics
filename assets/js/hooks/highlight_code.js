// Syntax-highlights the <code> inside the hook element with Shiki
// (via window.__highlightCode, see assets/js/highlight.js).
//
// The code itself is always rendered server-side; this hook only
// replaces the element's content with the highlighted version.
export default {
  async mounted() {
    const codeEl = this.el.querySelector("code")
    if (!codeEl) return

    try {
      const html = await window.__highlightCode(codeEl.textContent, this.el.dataset.lang)
      this.el.innerHTML = html
    } catch (e) {
      console.warn("Shiki highlighting failed:", e)
    }
  },
}
