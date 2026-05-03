defmodule JfgenomicsWeb.BlogIndexLive do
  use JfgenomicsWeb, :live_view

  alias Jfgenomics.Blog

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Blog")
     |> assign(:all_tags, Blog.all_tags())
     |> assign(:active_tag, nil)
     |> assign(:posts_empty?, false)
     |> stream(:posts, [])}
  end

  @impl true
  def handle_params(params, _uri, socket) do
    tag = params["tag"]

    cond do
      is_nil(tag) ->
        {:noreply,
         socket
         |> assign(:active_tag, nil)
         |> assign(:posts_empty?, false)
         |> stream(:posts, Blog.all_posts(), reset: true)}

      tag in Blog.all_tags() ->
        posts = Blog.get_posts_by_tag(tag)

        {:noreply,
         socket
         |> assign(:active_tag, tag)
         |> assign(:posts_empty?, posts == [])
         |> stream(:posts, posts, reset: true)}

      true ->
        {:noreply,
         socket
         |> put_flash(:error, "Tag #{tag} not found")
         |> push_navigate(to: ~p"/blog")}
    end
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <div class="max-w-4xl mx-auto">
        <header class="mb-12">
          <h1 class="text-4xl font-bold tracking-tight">JF Genomics</h1>
          <p class="mt-2 text-base-content/70">
            Stories on, about,and around doing computational biology in the cloud.
          </p>
        </header>

        <h2 class="text-3xl font-bold tracking-tight">Latest posts</h2>
        <nav class="mt-4 mb-8 flex flex-wrap gap-2" aria-label="Filter by tag">
          <.link
            patch={~p"/blog"}
            class={[
              "px-3 py-1.5 rounded-full text-sm font-medium transition-all duration-200",
              if(@active_tag == nil,
                do: "bg-primary text-primary-content shadow-sm",
                else: "bg-base-200 text-base-content hover:bg-base-300"
              )
            ]}
          >
            All
          </.link>
          <.link
            :for={tag <- @all_tags}
            patch={~p"/blog?tag=#{tag}"}
            class={[
              "px-3 py-1.5 rounded-full text-sm font-medium transition-all duration-200",
              if(@active_tag == tag,
                do: "bg-primary text-primary-content shadow-sm",
                else: "bg-base-200 text-base-content hover:bg-base-300"
              )
            ]}
          >
            {tag}
          </.link>
        </nav>

        <div
          :if={@posts_empty?}
          class="text-center py-12 text-base-content/50"
        >
          No posts found.
        </div>
        <div id="blog-posts" phx-update="stream" class={["space-y-8", @posts_empty? && "hidden"]}>
          <article
            :for={{dom_id, post} <- @streams.posts}
            id={dom_id}
            class="group border border-base-300 rounded-xl p-6 hover:border-primary/30 hover:shadow-md transition-all duration-200"
          >
            <.link navigate={~p"/blog/#{post.id}"} class="block">
              <h2 class="text-xl font-semibold group-hover:text-primary transition-colors duration-200">
                {post.title}
              </h2>
              <div class="mt-2 flex items-center gap-3 text-sm text-base-content/60">
                <time datetime={Date.to_iso8601(post.date)}>
                  {Calendar.strftime(post.date, "%B %d, %Y")}
                </time>
                <span>&middot;</span>
                <span>{post.author}</span>
              </div>
              <p class="mt-3 text-base-content/80 leading-relaxed">
                {post.description}
              </p>
            </.link>
            <div class="mt-4 flex flex-wrap gap-2">
              <.link
                :for={tag <- post.tags}
                patch={~p"/blog?tag=#{tag}"}
                class="px-2 py-0.5 rounded text-xs font-medium bg-base-200 text-base-content/70 hover:bg-primary/10 hover:text-primary transition-colors"
              >
                {tag}
              </.link>
            </div>
          </article>
        </div>
      </div>
    </Layouts.app>
    """
  end
end
