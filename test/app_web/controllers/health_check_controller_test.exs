defmodule SreChallengeWeb.HealthCheckControllerTest do
  use SreChallengeWeb.ConnCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "health check", %{conn: conn} do
      conn = get conn, Routes.health_check_path(conn, :index)
      assert response(conn, 200)
    end
  end
end
