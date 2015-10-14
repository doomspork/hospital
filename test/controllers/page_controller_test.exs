defmodule Hospital.PageControllerTest do
  use Hospital.ConnCase

  test "GET /" do
    conn = get conn(), "/"
    assert html_response(conn, 200) =~ ~s(<div id="root")
  end
end
