FROM elixir:1.8

RUN wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb && dpkg -i erlang-solutions_1.0_all.deb
RUN apt-get update
RUN apt-get install -y esl-erlang

WORKDIR /usr/src/app

COPY . .

RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix deps.get

ENTRYPOINT ["mix", "phx.server"]