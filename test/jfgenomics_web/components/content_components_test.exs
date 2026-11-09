defmodule JfgenomicsWeb.ContentComponentsTest do
  use JfgenomicsWeb.ConnCase, async: true

  import Phoenix.Component
  import Phoenix.LiveViewTest

  import JfgenomicsWeb.Card
  import JfgenomicsWeb.ExtLink
  import JfgenomicsWeb.IconListItem
  import JfgenomicsWeb.PublicationCard

  alias Jfgenomics.Publications

  # Collapses whitespace so assertions don't depend on template line breaks
  defp text_of(lazy_html) do
    lazy_html |> LazyHTML.text() |> String.replace(~r/\s+/, " ") |> String.trim()
  end

  test "ext_link always opens externally with noopener" do
    assigns = %{}

    doc =
      rendered_to_string(~H"""
      <.ext_link href="https://example.com">Example</.ext_link>
      """)
      |> LazyHTML.from_fragment()

    [link] = LazyHTML.query(doc, "a") |> Enum.to_list()

    assert LazyHTML.attribute(link, "href") == ["https://example.com"]
    assert LazyHTML.attribute(link, "target") == ["_blank"]
    assert LazyHTML.attribute(link, "rel") == ["noopener noreferrer"]
    assert text_of(link) == "Example"
  end

  test "card renders content inside the shared shell" do
    assigns = %{}

    doc =
      rendered_to_string(~H"""
      <.card class="flex">Card body</.card>
      """)
      |> LazyHTML.from_fragment()

    [card] = LazyHTML.query(doc, "article") |> Enum.to_list()

    assert LazyHTML.attribute(card, "class") |> hd() =~ "rounded-box"
    assert LazyHTML.attribute(card, "class") |> hd() =~ "flex"
    assert text_of(card) == "Card body"
  end

  test "icon_list_item renders title, subtitle, and badges" do
    assigns = %{}

    doc =
      rendered_to_string(~H"""
      <.icon_list_item
        icon="hero-trophy"
        title="Best Poster"
        subtitle="Some Conference"
        badges={["2024", "USA"]}
      />
      """)
      |> LazyHTML.from_fragment()

    assert Enum.any?(LazyHTML.query(doc, "li"))
    assert text_of(doc) =~ "Best Poster"
    assert text_of(doc) =~ "Some Conference"
    assert text_of(doc) =~ "2024"
    assert text_of(doc) =~ "USA"
  end

  test "publication_card renders the reference and a collapsible abstract" do
    assigns = %{pub: Publications.list() |> List.first()}

    doc =
      rendered_to_string(~H"""
      <.publication_card pub={@pub} />
      """)
      |> LazyHTML.from_fragment()

    pub = assigns.pub

    assert Enum.any?(LazyHTML.query(doc, "article"))
    assert text_of(doc) =~ pub.title
    assert text_of(doc) =~ "#{pub.journal} #{pub.volume} (#{pub.number}): #{pub.pages}"
    assert Enum.any?(LazyHTML.query(doc, "details summary"))
  end

  test "publication_card omits the page range when pages is nil" do
    assigns = %{pub: Publications.list() |> Enum.find(&is_nil(&1.pages))}

    doc =
      rendered_to_string(~H"""
      <.publication_card pub={@pub} />
      """)
      |> LazyHTML.from_fragment()

    pub = assigns.pub

    assert text_of(doc) =~ "#{pub.journal} #{pub.volume} (#{pub.number})"
    refute text_of(doc) =~ "(#{pub.number}):"
  end
end
