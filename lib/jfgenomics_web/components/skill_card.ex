defmodule JfgenomicsWeb.SkillCard do
  @moduledoc """
  Card component for a skill category: a header with a heroicon and the
  category name, and a body of chips with each skill's icon and name.

  Skill icons are devicons by default; a skill whose icon starts with
  `"hero-"` is rendered as a heroicon instead (useful for tools that have
  no devicon, e.g. Cromwell). A skill may also carry a `:badge` (e.g.
  "learning").
  """
  use Phoenix.Component

  import JfgenomicsWeb.CoreComponents, only: [icon: 1]
  import JfgenomicsWeb.Devicon, only: [devicon: 1]

  @doc """
  Renders a skill category card.

  ## Attributes
  - `title` - category name, e.g. "Cloud, DevOps" (required)
  - `icon` - heroicon name for the category header (required)
  - `skills` - list of `%{name:, icon:}` maps; `icon` is a devicon name
    or a `"hero-*"` heroicon name. Optional `:badge` key, e.g. "learning"
  - `class` - optional additional CSS classes

  ## Examples

      <.skill_card
        title="Workflow Managers"
        icon="hero-arrow-path"
        skills={[
          %{name: "Cromwell", icon: "hero-document-text"},
          %{name: "Nextflow", icon: "nextflow"}
        ]}
      />
  """
  attr :title, :string, required: true
  attr :icon, :string, required: true
  attr :skills, :list, required: true
  attr :class, :string, default: ""

  def skill_card(assigns) do
    ~H"""
    <article class={[
      "flex flex-col gap-5 rounded-box border border-base-300 bg-base-100 p-6 shadow-sm transition-shadow duration-300 hover:shadow-md",
      @class
    ]}>
      <header class="flex items-center gap-3">
        <span class="flex size-10 shrink-0 items-center justify-center rounded-lg bg-primary/10 text-primary">
          <.icon name={@icon} class="size-6" />
        </span>
        <h3 class="text-xl font-semibold">{@title}</h3>
      </header>
      <ul class="flex flex-wrap content-start gap-2">
        <li
          :for={skill <- @skills}
          class="flex items-center gap-2 rounded-full border border-base-300 bg-base-200/60 px-3 py-1.5 text-sm font-medium transition-all duration-200 hover:-translate-y-0.5 hover:border-primary/50 hover:shadow-sm"
        >
          <.skill_icon icon={skill.icon} />
          <span>{skill.name}</span>
          <span
            :if={skill[:badge]}
            class="rounded-full bg-primary/15 px-1.5 py-0.5 text-[0.65rem] font-semibold uppercase tracking-wider text-primary"
          >
            {skill.badge}
          </span>
        </li>
      </ul>
    </article>
    """
  end

  attr :icon, :string, required: true

  defp skill_icon(%{icon: "hero-" <> _} = assigns) do
    ~H"""
    <.icon name={@icon} class="size-5 shrink-0 text-base-content/80" />
    """
  end

  defp skill_icon(assigns) do
    ~H"""
    <.devicon name={@icon} class="size-5 shrink-0" />
    """
  end
end
