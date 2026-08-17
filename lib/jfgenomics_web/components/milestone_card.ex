defmodule JfgenomicsWeb.MilestoneCard do
  @moduledoc """
  Card component for career/education milestones: a photo on top,
  a descriptive body (which may contain links), a divider, and a
  footer with a title (e.g. degree) and subtitle (e.g. institution).
  """
  use Phoenix.Component

  @doc """
  Renders a milestone card.

  ## Attributes
  - `image` - path to the card photo (required)
  - `image_alt` - alt text for the photo
  - `title` - footer heading, e.g. "BSc. Biology" (required)
  - `subtitle` - footer trailing text, e.g. "U. Nacional. Colombia"
  - `class` - optional additional CSS classes

  ## Slots
  - `inner_block` - the body text; may contain markup such as links

  ## Examples

      <.milestone_card
        image={~p"/images/unal_green.jpg"}
        image_alt="Jardín Botánico de San Andrés"
        title="BSc. Biology"
        subtitle="U. Nacional. Colombia"
      >
        As part of my thesis for Biology at the
        <.link href="https://unal.edu.co" class="link link-primary">National University of Colombia</.link>,
        I started my career working on drift algae and their taxonomy.
      </.milestone_card>
  """
  attr :image, :string, required: true
  attr :image_alt, :string, default: ""
  attr :title, :string, required: true
  attr :subtitle, :string, default: nil
  attr :class, :string, default: ""

  slot :inner_block, required: true

  def milestone_card(assigns) do
    ~H"""
    <article class={[
      "group flex flex-col overflow-hidden rounded-box border border-base-300 bg-base-100 shadow-sm transition-shadow duration-300 hover:shadow-md",
      @class
    ]}>
      <div class="overflow-hidden">
        <img
          src={@image}
          alt={@image_alt}
          class="aspect-[4/3] w-full object-cover transition-transform duration-500 group-hover:scale-105"
        />
      </div>
      <div class="flex flex-1 flex-col">
        <p class="p-6 pb-8 text-lg leading-relaxed text-base-content/90">
          {render_slot(@inner_block)}
        </p>
        <div class="mt-auto">
          <hr class="mx-6 border-base-300" />
          <footer class="flex flex-wrap items-baseline justify-between gap-x-4 gap-y-1 p-6">
            <span class="text-2xl font-medium">{@title}</span>
            <span :if={@subtitle} class="text-lg text-base-content/80">{@subtitle}</span>
          </footer>
        </div>
      </div>
    </article>
    """
  end
end
