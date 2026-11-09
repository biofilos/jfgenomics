defmodule JfgenomicsWeb.PageControllerTest do
  use JfgenomicsWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, ~p"/")
    assert html_response(conn, 200) =~ "Juan Felipe Ortiz"
    assert html_response(conn, 200) =~ "Bioinformatician, cloud advocate, food nerd"
  end

  test "GET /education", %{conn: conn} do
    conn = get(conn, ~p"/education")
    assert html_response(conn, 200) =~ "Education"
    assert html_response(conn, 200) =~ "Vanderbilt University"
    assert html_response(conn, 200) =~ "Awards and Grants"
    assert html_response(conn, 200) =~ "Courses and Workshops"
    assert html_response(conn, 200) =~ "https://doi.org/10.18475/cjos.v46i2.a19"
  end

  test "GET /publications", %{conn: conn} do
    conn = get(conn, ~p"/publications")
    assert html_response(conn, 200) =~ "Publications"
    assert html_response(conn, 200) =~ "CTDGFinder"
  end

  test "GET /experience", %{conn: conn} do
    conn = get(conn, ~p"/experience")
    assert html_response(conn, 200) =~ "Experience"
    assert html_response(conn, 200) =~ "Paratus Sciences"
  end
end
