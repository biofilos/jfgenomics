defmodule JfgenomicsWeb.FeedController do
  @moduledoc """
  Serves the blog's Atom feed (`/blog/feed.xml`) and the site's XML
  sitemap (`/sitemap.xml`), both generated from `Jfgenomics.Blog`.
  """
  use JfgenomicsWeb, :controller

  alias Jfgenomics.Blog
  alias Plug.HTML

  @static_pages ~w(/ /education /publications /experience /blog)

  def atom(conn, _params) do
    posts = Blog.all_posts()
    base_url = JfgenomicsWeb.Endpoint.url()

    entries =
      Enum.map(posts, fn post ->
        url = "#{base_url}/blog/#{post.id}"
        updated = to_iso8601(post.date)

        """
          <entry>
            <title>#{escape(post.title)}</title>
            <link href="#{url}"/>
            <id>#{url}</id>
            <published>#{updated}</published>
            <updated>#{updated}</updated>
            <summary>#{escape(post.description)}</summary>
            <author><name>#{escape(post.author)}</name></author>
          </entry>
        """
      end)

    feed_updated = posts |> List.first() |> Map.fetch!(:date) |> to_iso8601()

    xml = """
    <?xml version="1.0" encoding="utf-8"?>
    <feed xmlns="http://www.w3.org/2005/Atom">
      <title>JF Genomics Blog</title>
      <subtitle>Stories on, about, and around doing computational biology in the cloud.</subtitle>
      <link href="#{base_url}/blog/feed.xml" rel="self"/>
      <link href="#{base_url}/blog"/>
      <id>#{base_url}/blog</id>
      <updated>#{feed_updated}</updated>
      <author><name>Juan Felipe Ortiz</name></author>
    #{entries}
    </feed>
    """

    conn
    |> put_resp_content_type("application/atom+xml")
    |> send_resp(200, xml)
  end

  def sitemap(conn, _params) do
    base_url = JfgenomicsWeb.Endpoint.url()

    static_urls =
      Enum.map(@static_pages, fn path ->
        "  <url><loc>#{base_url}#{path}</loc></url>"
      end)

    post_urls =
      Enum.map(Blog.all_posts(), fn post ->
        """
          <url>
            <loc>#{base_url}/blog/#{post.id}</loc>
            <lastmod>#{Date.to_iso8601(post.date)}</lastmod>
          </url>
        """
        |> String.trim_trailing()
      end)

    xml = """
    <?xml version="1.0" encoding="UTF-8"?>
    <urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
    #{Enum.join(static_urls ++ post_urls, "\n")}
    </urlset>
    """

    conn
    |> put_resp_content_type("application/xml")
    |> send_resp(200, xml)
  end

  defp to_iso8601(%Date{} = date) do
    date
    |> DateTime.new!(~T[00:00:00], "Etc/UTC")
    |> DateTime.to_iso8601()
  end

  defp escape(text), do: HTML.html_escape(text)
end
