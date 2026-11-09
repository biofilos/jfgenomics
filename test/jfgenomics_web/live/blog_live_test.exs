defmodule JfgenomicsWeb.BlogLiveTest do
  use JfgenomicsWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  alias Jfgenomics.Blog

  describe "blog index" do
    test "lists all posts", %{conn: conn} do
      {:ok, view, _html} = live(conn, ~p"/blog")

      for post <- Blog.all_posts() do
        assert has_element?(view, "#blog-posts article", post.title)
      end
    end

    test "renders a filter pill for every known tag", %{conn: conn} do
      {:ok, view, _html} = live(conn, ~p"/blog")

      for tag <- Blog.all_tags() do
        assert has_element?(view, "#tag-filters a", tag)
      end
    end

    test "filters posts by tag", %{conn: conn} do
      {:ok, view, _html} = live(conn, ~p"/blog?tag=rust")

      assert has_element?(view, "#blog-posts article", "Rust")
      refute has_element?(view, "#blog-posts article", "Python")
    end

    test "redirects with a flash message for unknown tags", %{conn: conn} do
      assert {:error, {:live_redirect, %{to: "/blog", flash: flash}}} =
               live(conn, ~p"/blog?tag=nope")

      assert flash["error"] =~ "nope"
    end
  end

  describe "blog show" do
    test "renders a post with its tags", %{conn: conn} do
      post = Blog.get_post_by_id("mirlangs-intro")
      {:ok, view, _html} = live(conn, ~p"/blog/#{post.id}")

      assert has_element?(view, "h1", post.title)

      for tag <- post.tags do
        assert has_element?(view, "header a", tag)
      end
    end

    test "raises a 404 for unknown posts", %{conn: conn} do
      assert_raise Blog.NotFoundError, fn ->
        live(conn, ~p"/blog/no-such-post")
      end
    end

    test "remote code falls back to an external link when fetching is disabled", %{conn: conn} do
      # Fetching is disabled in the test env (see config/test.exs)
      {:ok, view, _html} = live(conn, ~p"/blog/rust-gff-parser")

      assert has_element?(
               view,
               ~s(a[href^="https://raw.githubusercontent.com/"]),
               "View the source file on GitHub"
             )
    end
  end
end
