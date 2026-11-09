defmodule Jfgenomics.Blog do
  @moduledoc """
  Blog metadata registry. Each post is a plain map with keys:
  - :id        - URL slug (lowercase, hyphens only)
  - :title     - post title
  - :author    - author name
  - :date      - ~D[] date
  - :description - short description
  - :tags      - list of tag strings

  The `:template` atom used to render a post is derived from `:id`
  (hyphens become underscores) and must match a template embedded by
  `JfgenomicsWeb.BlogPosts` — this is validated at compile time, so a
  registry entry without a matching template (or vice versa) fails the
  build instead of raising at runtime.
  """

  defmodule NotFoundError do
    defexception [:message, plug_status: 404]
  end

  @posts [
           %{
             id: "rust-gff-parser",
             title: "Learn Rust's data structures by building a GFF parser",
             author: "Juan Felipe Ortiz",
             date: ~D[2025-10-19],
             description:
               "Learn and practice how basic data structures in Rust work, we will build a program that transform a GFF3 file of genomic annotations into an object that we can sort and query more efficiently.",
             tags: ~w(bioinformatics rust programming)
           },
           %{
             id: "elixir-gff-parser",
             title: "Learn Elixir's data structures by building a GFF3 parser",
             author: "Juan Felipe Ortiz",
             date: ~D[2025-05-02],
             description:
               "Learn and practice how basic data structures in Elixir work, we will build a program that transform a GFF3 file of genomic annotations into an object that we can sort and query more efficiently.",
             tags: ~w(bioinformatics elixir programming)
           },
           %{
             id: "python-gff-parser",
             title: "Learn Python's data structures by building a GFF parser",
             author: "Juan Felipe Ortiz",
             date: ~D[2025-05-02],
             description:
               "Learn and practice how basic data structures in Python work, we will build a program that transform a GFF3 file of genomic annotations into an object that we can sort and query more efficiently.",
             tags: ~w(bioinformatics python programming)
           },
           %{
             id: "mirlangs-intro",
             title: "Learn new programming languages using Bioinformatics as an excuse",
             author: "Juan Felipe Ortiz",
             date: ~D[2025-04-28],
             description:
               "This series reveals how to build solid programming skills while diving into bioinformatics",
             tags: ~w(bioinformatics programming),
             table: [
               %{
                 learn: "Basic data structures",
                 build: "GFF parser",
                 implemented: [
                   %{name: "elixir", variant: "original", post: "elixir-gff-parser"},
                   %{name: "python", variant: "original", post: "python-gff-parser"},
                   %{name: "rust", variant: "original", post: "rust-gff-parser"}
                 ]
               }
             ]
           }
         ]
         # The embedded-template function name is derived from the slug.
         |> Enum.map(fn post ->
           template = post.id |> String.replace("-", "_") |> String.to_atom()
           Map.put(post, :template, template)
         end)
         |> Enum.sort_by(& &1.date, {:desc, Date})
         # Compile-time check that every registered post has a matching
         # template embedded by JfgenomicsWeb.BlogPosts.
         |> tap(fn _ -> Code.ensure_compiled!(JfgenomicsWeb.BlogPosts) end)
         |> Enum.map(fn post ->
           unless function_exported?(JfgenomicsWeb.BlogPosts, post.template, 1) do
             raise """
             blog post #{inspect(post.id)} expects a template named #{inspect(post.template)}, \
             but no blog_posts/#{String.replace(post.id, "-", "_")}.html.heex file exists
             """
           end

           post
         end)

  @tags @posts |> Enum.flat_map(& &1.tags) |> Enum.uniq() |> Enum.sort()

  def all_posts, do: @posts
  def all_tags, do: @tags

  def get_post_by_id(id) do
    Enum.find(all_posts(), &(&1.id == id)) ||
      raise NotFoundError, "post with id=#{id} not found"
  end

  def get_posts_by_tag(tag) do
    Enum.filter(all_posts(), &(tag in &1.tags))
  end

  def recent_posts(num \\ 5), do: Enum.take(@posts, num)
end
