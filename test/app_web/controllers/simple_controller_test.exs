defmodule SreChallengeWeb.SimpleControllerTest do
  use SreChallengeWeb.ConnCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "hello" do
    test "returns hello message", %{conn: conn} do
      conn = get(conn, Routes.simple_path(conn, :hello))

      assert json_response(conn, 200) == %{"msg" => "hello"}
    end
  end

  describe "world" do
    test "returns world message", %{conn: conn} do
      conn = get(conn, Routes.simple_path(conn, :world))

      assert json_response(conn, 200) == %{"msg" => "world"}
    end
  end
end
