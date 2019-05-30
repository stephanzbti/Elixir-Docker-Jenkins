FROM elixir:1.8

RUN wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb && dpkg -i erlang-solutions_1.0_all.deb
RUN apt-get update
RUN apt-get install -y esl-erlang

WORKDIR /usr/src/app

COPY . .

RUN SECRET_KEY_BASE=$(elixir -e ":crypto.strong_rand_bytes(48) |> Base.encode64 |> IO.puts")
RUN sed "s|SECRET+KEY+BASE|$SECRET_KEY_BASE|" config/prod.secret.exs.example > config/prod.secret.exs

RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix deps.get

ENTRYPOINT ["mix", "phx.server"]