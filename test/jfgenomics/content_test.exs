defmodule Jfgenomics.ContentTest do
  use ExUnit.Case, async: true

  alias Jfgenomics.{Awards, Content, Courses, Education, Experience, Publications, Skills}

  describe "Jfgenomics.Content facade" do
    test "accessors delegate to the section modules" do
      assert Content.awards() == Awards.list()
      assert Content.courses() == Courses.list()
      assert Content.education() == Education.list()
      assert Content.experience() == Experience.list()
      assert Content.publications() == Publications.list()
      assert Content.skills() == Skills.list()
    end
  end

  describe "section data" do
    test "all sections use atom keys" do
      entries =
        Awards.list() ++
          Courses.list() ++
          Education.list() ++
          Experience.list() ++
          Publications.list() ++
          Skills.list()

      for entry <- entries, {key, _value} <- entry do
        assert is_atom(key), "expected atom keys, got string key #{inspect(key)}"
      end
    end

    test "education citations are derived from Publications" do
      for entry <- Education.list() do
        pub = Publications.get_by_link(entry.pub_link)
        assert pub, "no publication matches #{entry.pub_link}"
        assert entry.publication == Publications.citation(pub)
      end
    end
  end

  describe "Publications.citation/1" do
    test "includes the page range when present" do
      pub = Publications.list() |> Enum.find(& &1.pages)
      assert Publications.citation(pub) =~ "(#{pub.number}): #{pub.pages}"
    end

    test "omits the page range when pages is nil" do
      pub = Publications.list() |> Enum.find(&is_nil(&1.pages))
      refute Publications.citation(pub) =~ "(#{pub.number}):"
    end
  end

  describe "Jfgenomics.Blog registry" do
    alias Jfgenomics.Blog

    test "slugs are lowercase and hyphenated" do
      for post <- Blog.all_posts() do
        assert post.id == String.downcase(post.id)
        refute post.id =~ "_"
      end
    end

    test "get_post_by_id/1 raises NotFoundError for unknown slugs" do
      assert_raise Blog.NotFoundError, fn -> Blog.get_post_by_id("nope") end
    end

    test "recent_posts/1 returns at most the requested number of posts" do
      assert length(Blog.recent_posts(3)) == 3
      assert Blog.recent_posts(100) == Blog.all_posts()
    end
  end
end
