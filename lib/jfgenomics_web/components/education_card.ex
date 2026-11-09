defmodule JfgenomicsWeb.EducationCard do
  @moduledoc """
  Card component for an education entry: a header with an academic-cap
  icon, the degree title and area, the school, and a footer with the
  degree's representative publication plus a link to it.
  """
  use Phoenix.Component

  import JfgenomicsWeb.CoreComponents, only: [icon: 1]

  @doc """
  Renders an education card.

  ## Attributes
  - `title` - degree name, e.g. "Doctor of Philosophy" (required)
  - `school` - institution name, e.g. "Vanderbilt University" (required)
  - `area` - field of study, e.g. "Biological Sciences" (required)
  - `publication` - representative publication citation (required)
  - `pub_link` - external URL for the publication (required)
  - `class` - optional additional CSS classes

  ## Examples

      <.education_card
        title="Master of Science"
        school="University of Wyoming"
        area="Molecular Biology"
        publication="Ortiz, J. F., et al. (2013). Rapid Evolutionary Dynamics..."
        pub_link="https://doi.org/10.1093/gbe/evt026"
      />
  """
  attr :title, :string, required: true
  attr :school, :string, required: true
  attr :area, :string, required: true
  attr :publication, :string, required: true
  attr :pub_link, :string, required: true
  attr :class, :string, default: ""

  def education_card(assigns) do
    ~H"""
    <article class={[
      "flex flex-col gap-4 rounded-box border border-base-300 bg-base-100 p-6 shadow-sm transition-shadow duration-300 hover:shadow-md",
      @class
    ]}>
      <header class="flex items-center gap-3">
        <span class="flex size-10 shrink-0 items-center justify-center rounded-lg bg-primary/10 text-primary">
          <.icon name="hero-academic-cap" class="size-6" />
        </span>
        <div>
          <h3 class="text-xl font-semibold leading-tight">{@title}</h3>
          <p class="text-base-content/70">{@area}</p>
        </div>
      </header>
      <p class="flex items-center gap-2 font-medium text-base-content/80">
        <.icon name="hero-building-library" class="size-5 shrink-0 text-base-content/60" />
        {@school}
      </p>
      <div class="mt-auto rounded-lg border border-base-300 bg-base-200/60 p-4">
        <p class="text-sm leading-relaxed text-base-content/80">{@publication}</p>
        <.link
          href={@pub_link}
          target="_blank"
          rel="noopener noreferrer"
          class="mt-2 inline-flex items-center gap-1 text-sm font-medium link link-primary"
        >
          Read publication <.icon name="hero-arrow-top-right-on-square" class="size-4" />
        </.link>
      </div>
    </article>
    """
  end
end
