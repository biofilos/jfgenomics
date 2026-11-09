defmodule JfgenomicsWeb.ExtLink do
  @moduledoc """
  External link component: always opens in a new tab with
  `rel="noopener noreferrer"` and consistent styling, so call sites
  only provide the URL and the link text.
  """
  use Phoenix.Component

  @doc """
  Renders an external link.

  ## Attributes
  - `href` - the external URL (required)
  - `class` - CSS classes (default `"link link-primary"`)

  ## Slots
  - `inner_block` - the link text; may contain markup such as icons

  ## Examples

      <.ext_link href="https://riken.jp">RIKEN</.ext_link>

      <.ext_link href={@url} class="text-sm font-medium text-primary">
        View source
      </.ext_link>
  """
  attr :href, :string, required: true
  attr :class, :string, default: "link link-primary"
  attr :rest, :global

  slot :inner_block, required: true

  def ext_link(assigns) do
    ~H"""
    <a href={@href} target="_blank" rel="noopener noreferrer" class={@class} {@rest}>
      {render_slot(@inner_block)}
    </a>
    """
  end
end
