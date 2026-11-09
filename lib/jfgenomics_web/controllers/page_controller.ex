defmodule JfgenomicsWeb.PageController do
  use JfgenomicsWeb, :controller

  def home(conn, _params) do
    render(conn, :home, skill_sets: Jfgenomics.Skills.list())
  end

  def education(conn, _params) do
    render(conn, :education,
      education: Jfgenomics.Education.list(),
      awards: Jfgenomics.Awards.list(),
      courses: Jfgenomics.Courses.list()
    )
  end

  def publications(conn, _params) do
    render(conn, :publications, publications: Jfgenomics.Publications.list())
  end

  def experience(conn, _params) do
    render(conn, :experience, experience: Jfgenomics.Experience.list())
  end
end
