defmodule JfgenomicsWeb.Card do
  @moduledoc """
  Shared card shell used across the site: a bordered, padded `<article>`
  with a subtle hover shadow. Content-specific cards (education, skills,
  publications, blog teasers) compose this instead of repeating the
  shell classes.
  """
  use Phoenix.Component

  @doc """
  Renders the card shell.

  ## Attributes
  - `class` - optional additional CSS classes (e.g. layout classes like
    `"flex flex-col gap-4"`); accepts a string or a class list

  ## Slots
  - `inner_block` - the card content

  ## Examples

      <.card class="flex flex-col gap-4">
        <h3 class="text-xl font-semibold">Title</h3>
        <p>Body</p>
      </.card>
  """
  attr :class, :any, default: ""
  attr :rest, :global

  slot :inner_block, required: true

  def card(assigns) do
    ~H"""
    <article
      class={[
        "rounded-box border border-base-300 bg-base-100 p-6 shadow-sm transition-shadow duration-300 hover:shadow-md",
        @class
      ]}
      {@rest}
    >
      {render_slot(@inner_block)}
    </article>
    """
  end
end
