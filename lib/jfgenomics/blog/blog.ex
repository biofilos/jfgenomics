defmodule Jfgenomics.Blog do
  @moduledoc """
  Blog metadata registry. Each post is a plain map with keys:
  - :id        - URL slug (hyphens)
  - :template  - atom matching the embedded template function name (underscores)
  - :title     - post title
  - :author    - author name
  - :date      - ~D[] date
  - :description - short description
  - :tags      - list of tag strings
  """

  defmodule NotFoundError do
    defexception [:message, plug_status: 404]
  end

  @posts [
           %{
             id: "elixir-gff_parser",
             template: :elixir_gff_parser,
             title: "Learn Elixir's data structures by building a GFF3 parser",
             author: "Juan Felipe Ortiz",
             date: ~D[2025-05-02],
             description:
               "Learn and practice how basic data structures in Elixir work, we will build a program that transform a GFF3 file of genomic annotations into an object that we can sort and query more efficiently.",
             tags: ~w(bioinformatics elixir programming)
           }
         ]
         |> Enum.sort_by(& &1.date, {:desc, Date})

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
