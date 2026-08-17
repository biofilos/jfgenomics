defmodule JfgenomicsWeb.TimelineItem do
  @moduledoc """
  Timeline entry component: a marker on a vertical line, a header with a
  title and badges, a prose body (which may contain links), and a row of
  highlight chips.

  Entries must be wrapped in an element with a left border that acts as
  the timeline's line:

      <ol class="ms-6 flex flex-col gap-10 border-s-2 border-primary/25">
        <.timeline_item title="Senior Bioinformatics Engineer · Lifebit" badges={["Current"]}>
          At <.link href="https://lifebit.ai">Lifebit</.link>, ...
        </.timeline_item>
      </ol>
  """
  use Phoenix.Component

  import JfgenomicsWeb.CoreComponents, only: [icon: 1]

  @doc """
  Renders a timeline entry.

  ## Attributes
  - `title` - heading, e.g. a role or organization (required)
  - `icon` - heroicon name for the marker (default `"hero-briefcase"`)
  - `badges` - list of strings rendered as pills next to the title,
    e.g. `["Current"]`
  - `highlights` - list of short takeaways rendered as chips under the
    body, e.g. `["Team leadership"]`
  - `class` - optional additional CSS classes

  ## Slots
  - `inner_block` - the body text; may contain markup such as links
  """
  attr :title, :string, required: true
  attr :icon, :string, default: "hero-briefcase"
  attr :badges, :list, default: []
  attr :highlights, :list, default: []
  attr :class, :string, default: ""

  slot :inner_block, required: true

  def timeline_item(assigns) do
    ~H"""
    <li class={["group relative ps-12", @class]}>
      <span class="absolute -start-[21px] top-0 flex size-10 items-center justify-center rounded-full border border-primary/40 bg-base-100 text-primary transition-transform duration-300 group-hover:scale-110">
        <.icon name={@icon} class="size-5" />
      </span>
      <header class="flex flex-wrap items-center gap-x-3 gap-y-2">
        <h3 class="text-xl font-semibold">{@title}</h3>
        <span
          :for={badge <- @badges}
          class="rounded-full bg-primary/15 px-2 py-0.5 text-xs font-semibold uppercase tracking-wider text-primary"
        >
          {badge}
        </span>
      </header>
      <div class="pt-2 leading-relaxed text-base-content/90">
        {render_slot(@inner_block)}
      </div>
      <ul :if={@highlights != []} class="flex flex-wrap gap-2 pt-3">
        <li
          :for={highlight <- @highlights}
          class="rounded-full border border-base-300 bg-base-200/60 px-3 py-1 text-xs font-medium transition-colors duration-200 hover:border-primary/50"
        >
          {highlight}
        </li>
      </ul>
    </li>
    """
  end
end
