defmodule Mix.Tasks.Talk do
  use Mix.Task

  @shortdoc "Just say something"
  def run(_) do
    IO.puts "say something"
  end
end
