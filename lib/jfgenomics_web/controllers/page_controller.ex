defmodule JfgenomicsWeb.PageController do
  use JfgenomicsWeb, :controller

  alias Jfgenomics.Content

  def home(conn, _params) do
    render(conn, :home,
      skill_sets: Content.skills(),
      recent_posts: Jfgenomics.Blog.recent_posts(3)
    )
  end

  def education(conn, _params) do
    render(conn, :education,
      page_title: "Education",
      education: Content.education(),
      awards: Content.awards(),
      courses: Content.courses()
    )
  end

  def publications(conn, _params) do
    render(conn, :publications,
      page_title: "Publications",
      publications: Content.publications()
    )
  end

  def experience(conn, _params) do
    render(conn, :experience,
      page_title: "Experience",
      experience: Content.experience()
    )
  end
end
