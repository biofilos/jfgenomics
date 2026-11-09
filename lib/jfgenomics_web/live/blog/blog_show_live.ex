defmodule JfgenomicsWeb.BlogShowLive do
  use JfgenomicsWeb, :live_view

  import JfgenomicsWeb.BlogComponents

  alias Jfgenomics.Blog

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    post = Blog.get_post_by_id(id)

    {:ok,
     socket
     |> assign(:page_title, post.title)
     |> assign(:meta_description, post.description)
     |> assign(:og_type, "article")
     |> assign(:post, post)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <div class="max-w-4xl mx-auto">
        <nav class="mb-8">
          <.link
            navigate={~p"/blog"}
            class="inline-flex items-center gap-1.5 text-sm text-base-content/60 hover:text-primary transition-colors duration-200"
          >
            <.icon name="hero-arrow-left" class="w-4 h-4" /> All posts
          </.link>
        </nav>

        <header class="mb-10">
          <h1 class="text-3xl md:text-4xl font-bold tracking-tight leading-tight">
            {@post.title}
          </h1>
          <div class="mt-4 flex items-center gap-3 text-sm text-base-content/60">
            <time datetime={Date.to_iso8601(@post.date)}>
              {Calendar.strftime(@post.date, "%B %d, %Y")}
            </time>
            <span>&middot;</span>
            <span>{@post.author}</span>
          </div>
          <div class="mt-3 flex flex-wrap gap-2">
            <.tag_chip :for={tag <- @post.tags} tag={tag} />
          </div>
        </header>

        <div class="blog-content">
          <article class="prose prose-invert max-w-none">
            {apply(JfgenomicsWeb.BlogPosts, @post.template, [assigns])}
          </article>
        </div>
      </div>
    </Layouts.app>
    """
  end
end
