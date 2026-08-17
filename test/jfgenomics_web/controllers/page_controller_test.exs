defmodule JfgenomicsWeb.PageControllerTest do
  use JfgenomicsWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, ~p"/")
    assert html_response(conn, 200) =~ "Juan Felipe Ortiz"
    assert html_response(conn, 200) =~ "Bioinformatician, cloud advocate, food nerd"
  end
end
