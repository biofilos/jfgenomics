defmodule JfgenomicsWeb.Devicon do
  @moduledoc """
  Provides a function component for rendering devicon SVGs inline.

  SVGs are read at compile time from `assets/vendor/devicon/icons/`.
  Multi-color SVGs keep their original fills. Single-color SVGs
  inherit `currentColor` so they adapt to the surrounding text color.
  """

  use Phoenix.Component

  @icons Path.expand("../../assets/vendor/devicon/icons", __DIR__)
         |> Path.join("**/*.svg")
         |> Path.wildcard()
         |> Enum.map(fn path ->
           basename = Path.basename(path, ".svg")
           content = File.read!(path)

           content =
             if String.contains?(content, "fill=") do
               content
             else
               String.replace(content, ~r/<svg/, ~s(<svg fill="currentColor"))
             end

           {basename, content}
         end)
         |> Map.new()

  @doc """
  Renders a devicon SVG inline.

  ## Attributes
  - `name` - the icon name (e.g., "elixir")
  - `variant` - the icon variant (e.g., "original", "plain", "original-wordmark")
  - `class` - optional additional CSS classes
  """
  attr :name, :string, required: true
  attr :variant, :string, default: "original"
  attr :class, :string, default: "w-8 h-8 inline-block"

  def devicon(assigns) do
    key = "#{assigns.name}-#{assigns.variant}"

    assigns =
      assign(
        assigns,
        :svg,
        case Map.get(@icons, key) do
          nil -> ""
          content -> Phoenix.HTML.raw(content)
        end
      )

    ~H"""
    <span class={[@class, "inline-flex items-center justify-center"]} aria-hidden="true">
      {@svg}
    </span>
    """
  end
end
