defmodule JfgenomicsWeb.IconListItem do
  @moduledoc """
  List row with a leading icon tile, a title/subtitle, and trailing
  pill badges. Used for the Awards and Courses lists on the Education
  page.

  Wrap the items in a `<ul>` with divide/border styles:

      <ul class="mt-6 divide-y divide-base-300 rounded-box border border-base-300 bg-base-100 shadow-sm">
        <.icon_list_item
          :for={award <- @awards}
          icon="hero-trophy"
          title={award.name}
          subtitle={award.institution}
          badges={[award.time]}
        />
      </ul>
  """
  use Phoenix.Component

  import JfgenomicsWeb.CoreComponents, only: [icon: 1]

  @doc """
  Renders an icon list row.

  ## Attributes
  - `icon` - heroicon name for the leading tile, e.g. `"hero-trophy"` (required)
  - `title` - main row text, e.g. an award or course name (required)
  - `subtitle` - secondary row text, e.g. the institution
  - `badges` - list of strings rendered as trailing pills, e.g. `["2020 - 2021"]`
  - `class` - optional additional CSS classes
  """
  attr :icon, :string, required: true
  attr :title, :string, required: true
  attr :subtitle, :string, default: nil
  attr :badges, :list, default: []
  attr :class, :string, default: ""

  def icon_list_item(assigns) do
    ~H"""
    <li class={["flex flex-wrap items-center gap-x-4 gap-y-1 p-4 sm:p-5", @class]}>
      <span class="flex size-10 shrink-0 items-center justify-center rounded-lg bg-primary/10 text-primary">
        <.icon name={@icon} class="size-6" />
      </span>
      <div class="min-w-0 flex-1">
        <p class="font-semibold">{@title}</p>
        <p :if={@subtitle} class="text-sm text-base-content/70">{@subtitle}</p>
      </div>
      <div class="flex flex-wrap items-center gap-2">
        <span
          :for={badge <- @badges}
          class="rounded-full border border-base-300 bg-base-200/60 px-3 py-1 text-sm font-medium"
        >
          {badge}
        </span>
      </div>
    </li>
    """
  end
end
