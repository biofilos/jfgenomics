defmodule JfgenomicsWeb.FeedControllerTest do
  use JfgenomicsWeb.ConnCase, async: true

  alias Jfgenomics.Blog

  test "GET /blog/feed.xml returns an Atom feed with all posts", %{conn: conn} do
    conn = get(conn, ~p"/blog/feed.xml")

    assert response_content_type(conn, :xml)
    body = response(conn, 200)

    assert body =~ ~s(<feed xmlns="http://www.w3.org/2005/Atom">)

    for post <- Blog.all_posts() do
      assert body =~ "/blog/#{post.id}"
    end
  end

  test "GET /sitemap.xml lists static pages and posts", %{conn: conn} do
    conn = get(conn, ~p"/sitemap.xml")

    assert response_content_type(conn, :xml)
    body = response(conn, 200)
    base_url = JfgenomicsWeb.Endpoint.url()

    for path <- ["/", "/education", "/publications", "/experience", "/blog"] do
      assert body =~ "<loc>#{base_url}#{path}</loc>"
    end

    for post <- Blog.all_posts() do
      assert body =~ "/blog/#{post.id}</loc>"
      assert body =~ "<lastmod>#{Date.to_iso8601(post.date)}</lastmod>"
    end
  end
end
