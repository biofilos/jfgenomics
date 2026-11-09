defmodule JfgenomicsWeb.PublicationCard do
  @moduledoc """
  Card component for a publication: the title (linked to the external
  article), authors, journal reference, and a collapsible abstract.
  """
  use Phoenix.Component

  import JfgenomicsWeb.Card
  import JfgenomicsWeb.CoreComponents, only: [icon: 1]
  import JfgenomicsWeb.ExtLink

  @doc """
  Renders a publication card.

  ## Attributes
  - `pub` - a publication map as returned by `Jfgenomics.Publications.list/0`,
    with keys `:title`, `:authors`, `:journal`, `:volume`, `:number`,
    `:pages` (may be `nil`), `:year`, `:link`, and `:abstract` (required)
  - `class` - optional additional CSS classes

  ## Examples

      <.publication_card :for={pub <- @publications} pub={pub} />
  """
  attr :pub, :map, required: true
  attr :class, :string, default: ""

  def publication_card(assigns) do
    ~H"""
    <.card class={@class}>
      <div class="flex flex-wrap items-start justify-between gap-x-4 gap-y-2">
        <h2 class="text-xl font-semibold leading-snug">
          <.ext_link href={@pub.link} class="transition-colors hover:text-primary">
            {@pub.title}
          </.ext_link>
        </h2>
        <span class="shrink-0 rounded-full bg-primary/15 px-2 py-0.5 text-xs font-semibold uppercase tracking-wider text-primary">
          {@pub.year}
        </span>
      </div>
      <p class="mt-1 text-sm text-base-content/70">{@pub.authors}</p>
      <p class="mt-2 text-sm text-base-content/80">
        <span class="italic">{@pub.journal}</span>
        {@pub.volume} ({@pub.number}){if @pub.pages, do: ": #{@pub.pages}"}
      </p>
      <details class="group mt-3">
        <summary class="inline-flex cursor-pointer list-none items-center gap-1 rounded text-sm font-medium text-primary focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-primary [&::-webkit-details-marker]:hidden">
          Abstract
          <.icon
            name="hero-chevron-down"
            class="size-4 transition-transform duration-200 group-open:rotate-180"
          />
        </summary>
        <p class="mt-2 text-sm leading-relaxed text-base-content/80">{@pub.abstract}</p>
      </details>
    </.card>
    """
  end
end
