defmodule JfgenomicsWeb.BlogComponents do
  @moduledoc """
  Reusable components for blog posts: code blocks, remote code fetching, etc.
  """
  use Phoenix.Component

  @doc """
  Renders a syntax-highlighted code block using Shiki (client-side).

  ## Attributes
  - `lang` - the language for syntax highlighting (e.g., "elixir", "rust")
  - `class` - optional additional CSS classes

  ## Slots
  - inner_block - the raw code content
  """
  attr :lang, :string, required: true
  attr :class, :string, default: ""

  slot :inner_block, required: true

  def code_block(assigns) do
    ~H"""
    <div
      id={System.unique_integer([:positive]) |> Integer.to_string()}
      phx-hook=".CodeBlock"
      phx-update="ignore"
      data-lang={@lang}
      class={["code-block-container", @class]}
    >
      <pre><code>{render_slot(@inner_block)}</code></pre>
    </div>
    <script :type={Phoenix.LiveView.ColocatedHook} name=".CodeBlock">
      export default {
        async mounted() {
          const codeEl = this.el.querySelector("code")
          const lang = this.el.dataset.lang
          const code = codeEl.textContent

          try {
            const html = await window.__highlightCode(code, lang)
            this.el.innerHTML = html
          } catch (e) {
            console.warn("Shiki highlighting failed:", e)
          }
        }
      }
    </script>
    """
  end

  @doc """
  Fetches remote source code and renders it with syntax highlighting.
  The fetch and highlighting happen client-side via a JS hook.

  ## Attributes
  - `url` - the raw source URL to fetch
  - `lang` - the language for syntax highlighting
  - `class` - optional additional CSS classes
  """
  @doc """
  Renders inline code with consistent styling.

  ## Slots
  - inner_block - the code text
  """
  slot :inner_block, required: true

  def icode(assigns) do
    ~H"""
    <code class="text-sm bg-base-300 px-1.5 py-0.5 rounded">{render_slot(@inner_block)}</code>
    """
  end

  attr :url, :string, required: true
  attr :lang, :string, required: true
  attr :class, :string, default: ""

  def remote_code(assigns) do
    ~H"""
    <div
      id={System.unique_integer([:positive]) |> Integer.to_string()}
      phx-hook=".RemoteCode"
      phx-update="ignore"
      data-url={@url}
      data-lang={@lang}
      class={["remote-code-container", @class]}
    >
      <div class="animate-pulse bg-base-300 rounded-lg h-48 flex items-center justify-center">
        <span class="text-base-content/50 text-sm">Loading source code...</span>
      </div>
    </div>
    <script :type={Phoenix.LiveView.ColocatedHook} name=".RemoteCode">
      export default {
        async mounted() {
          const url = this.el.dataset.url
          const lang = this.el.dataset.lang

          try {
            const response = await fetch(url)
            if (!response.ok) throw new Error(`HTTP ${response.status}`)
            const code = await response.text()

            const html = await window.__highlightCode(code, lang)
            this.el.innerHTML = html
          } catch (e) {
            console.warn("Remote code fetch/highlight failed:", e)
            this.el.innerHTML = `<pre class="p-4 bg-base-300 rounded-lg text-error text-sm">Failed to load code from ${url}</pre>`
          }
        }
      }
    </script>
    """
  end
end
