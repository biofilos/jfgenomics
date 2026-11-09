defmodule JfgenomicsWeb.BlogComponents do
  @moduledoc """
  Reusable components for blog posts and blog pages: code blocks,
  remote code, inline code, and tag chips.

  Code blocks are syntax-highlighted client-side by the `HighlightCode`
  JS hook (see `assets/js/hooks/highlight_code.js`), but the code
  itself is always part of the rendered HTML.
  """
  use Phoenix.Component

  use Phoenix.VerifiedRoutes,
    endpoint: JfgenomicsWeb.Endpoint,
    router: JfgenomicsWeb.Router,
    statics: JfgenomicsWeb.static_paths()

  import JfgenomicsWeb.ExtLink

  alias Jfgenomics.Blog.SourceCode

  @doc """
  Renders a code block, syntax-highlighted client-side with Shiki.

  ## Attributes
  - `lang` - the language for syntax highlighting (e.g., "elixir", "rust")
  - `class` - optional additional CSS classes
  - `code` - the code as a string. Alternative to the `inner_block` slot,
    useful when the code contains literal `{`/`}` characters that would
    otherwise need `phx-no-curly-interpolation`

  ## Slots
  - inner_block - the raw code content
  """
  attr :lang, :string, required: true
  attr :class, :string, default: ""
  attr :code, :string, default: nil

  slot :inner_block

  def code_block(assigns) do
    ~H"""
    <div
      id={"code-block-#{System.unique_integer([:positive])}"}
      phx-hook="HighlightCode"
      phx-update="ignore"
      data-lang={@lang}
      class={["code-block-container", @class]}
    >
      <pre><code>{if @code, do: @code, else: render_slot(@inner_block)}</code></pre>
    </div>
    """
  end

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

  @doc """
  Renders source code fetched server-side from a raw URL (see
  `Jfgenomics.Blog.SourceCode`), syntax-highlighted client-side.

  When the source cannot be fetched, renders a fallback box with a link
  to the original file instead.

  ## Attributes
  - `url` - the raw source URL to fetch
  - `lang` - the language for syntax highlighting
  - `class` - optional additional CSS classes
  """
  attr :url, :string, required: true
  attr :lang, :string, required: true
  attr :class, :string, default: ""

  def remote_code(assigns) do
    assigns = assign(assigns, :source, SourceCode.fetch(assigns.url))

    ~H"""
    <%= case @source do %>
      <% {:ok, code} -> %>
        <.code_block lang={@lang} class={@class}>{code}</.code_block>
      <% {:error, _reason} -> %>
        <div class={[
          "my-5 rounded-lg border border-base-300 bg-base-200/60 p-4 text-sm",
          @class
        ]}>
          <p class="text-base-content/70">The source code could not be loaded inline.</p>
          <.ext_link href={@url} class="mt-1 inline-block font-medium">
            View the source file on GitHub
          </.ext_link>
        </div>
    <% end %>
    """
  end

  @doc """
  Renders a small tag chip linking to the tag-filtered blog index.

  ## Attributes
  - `tag` - the tag string (required)
  """
  attr :tag, :string, required: true

  def tag_chip(assigns) do
    ~H"""
    <.link
      navigate={~p"/blog?tag=#{@tag}"}
      class="px-2 py-0.5 rounded text-xs font-medium bg-base-200 text-base-content/70 hover:bg-primary/10 hover:text-primary transition-colors"
    >
      {@tag}
    </.link>
    """
  end
end
