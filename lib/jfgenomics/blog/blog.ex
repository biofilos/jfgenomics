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
             id: "rust-gff_parser",
             template: :rust_gff_parser,
             title: "Learn Rust's data structures by building a GFF parser",
             author: "Juan Felipe Ortiz",
             date: ~D[2025-10-19],
             description:
               "Learn and practice how basic data structures in Rust work, we will build a program that transform a GFF3 file of genomic annotations into an object that we can sort and query more efficiently.",
             tags: ~w(bioinformatics rust programming)
           },
           %{
             id: "elixir-gff_parser",
             template: :elixir_gff_parser,
             title: "Learn Elixir's data structures by building a GFF3 parser",
             author: "Juan Felipe Ortiz",
             date: ~D[2025-05-02],
             description:
               "Learn and practice how basic data structures in Elixir work, we will build a program that transform a GFF3 file of genomic annotations into an object that we can sort and query more efficiently.",
             tags: ~w(bioinformatics elixir programming)
           },
           %{
             id: "python-gff_parser",
             template: :python_gff_parser,
             title: "Learn Python's daa structures by building a GFF parser",
             author: "Juan Felipe Ortiz",
             date: ~D[2025-05-02],
             description:
               "Learn and practice how basic data structures in Python work, we will build a program that transform a GFF3 file of genomic annotations into an object that we can sort and query more efficiently.",
             tags: ~w(bioinformatics python programing)
           },
           %{
             id: "mirlangs_intro",
             template: :mirlangs_intro,
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
                   %{name: "elixir", variant: "original", post: "elixir-gff_parser"},
                   %{name: "python", variant: "original", post: "python-gff_parser"},
                   %{name: "rust", variant: "original", post: "rust-gff_parser"}
                 ]
               }
             ]
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
