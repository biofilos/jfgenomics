defmodule JfgenomicsWeb.PageController do
  use JfgenomicsWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
