defmodule JfgenomicsWeb.PageControllerTest do
  use JfgenomicsWeb.ConnCase

  # These tests assert on page structure (headings, sections, cards)
  # rather than exact prose, so copy edits don't break the suite.

  defp get_document(conn, path) do
    conn
    |> get(path)
    |> html_response(200)
    |> LazyHTML.from_document()
  end

  test "GET /", %{conn: conn} do
    doc = get_document(conn, ~p"/")

    # Hero, content sections, and the recent-posts teaser
    assert Enum.any?(LazyHTML.query(doc, "#hero"))
    assert Enum.any?(LazyHTML.query(doc, "#background"))
    assert Enum.any?(LazyHTML.query(doc, "#skills"))
    assert Enum.any?(LazyHTML.query(doc, "#industry"))

    latest_posts = LazyHTML.query(doc, "#latest-posts article")
    assert length(Enum.to_list(latest_posts)) == 3

    # Every external link must carry target/rel attributes
    for node <- LazyHTML.query(doc, ~s(a[target="_blank"])) do
      assert LazyHTML.attribute(node, "rel") == ["noopener noreferrer"]
    end
  end

  test "GET /education", %{conn: conn} do
    doc = get_document(conn, ~p"/education")

    assert LazyHTML.query(doc, "h1") |> LazyHTML.text() =~ "Education"
    assert length(Enum.to_list(LazyHTML.query(doc, "#education article"))) == 3
    assert length(Enum.to_list(LazyHTML.query(doc, "#awards li"))) == 4
    assert length(Enum.to_list(LazyHTML.query(doc, "#courses li"))) == 4
  end

  test "GET /publications", %{conn: conn} do
    doc = get_document(conn, ~p"/publications")

    assert LazyHTML.query(doc, "h1") |> LazyHTML.text() =~ "Publications"
    assert length(Enum.to_list(LazyHTML.query(doc, "#publications article"))) == 7
    # Each publication card exposes its abstract behind a <details> toggle
    assert length(Enum.to_list(LazyHTML.query(doc, "#publications article details summary"))) == 7
  end

  test "GET /experience", %{conn: conn} do
    doc = get_document(conn, ~p"/experience")

    assert LazyHTML.query(doc, "h1") |> LazyHTML.text() =~ "Experience"
    assert length(Enum.to_list(LazyHTML.query(doc, "main ol > li"))) == 5
  end

  test "pages share the site chrome", %{conn: conn} do
    for path <- [~p"/", ~p"/education", ~p"/publications", ~p"/experience"] do
      doc = get_document(conn, path)

      # Dark theme is hardcoded, navigation and favicon are present
      assert Enum.any?(LazyHTML.query(doc, ~s(html[data-theme="dark"])))
      assert Enum.any?(LazyHTML.query(doc, ~s(nav[aria-label="Main navigation"])))
      assert Enum.any?(LazyHTML.query(doc, ~s(link[rel="icon"])))
      assert Enum.any?(LazyHTML.query(doc, ~s(meta[name="description"])))
    end
  end
end
