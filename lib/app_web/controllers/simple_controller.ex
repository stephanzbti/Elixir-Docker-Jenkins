defmodule SreChallengeWeb.SimpleController do
  use SreChallengeWeb, :controller

  def hello(conn, _params) do
    json(conn, %{msg: "hello"})
  end

  def world(conn, _params) do
    json(conn, %{msg: "world"})
  end
end
