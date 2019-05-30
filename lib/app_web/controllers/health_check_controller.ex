defmodule SreChallengeWeb.HealthCheckController do
  use SreChallengeWeb, :controller

  def index(conn, _params) do
    send_resp(conn, :ok, "")
  end
end
