# sre-challenge


## A aplicação

É uma aplicação escrita em [Elixir](https://elixir-lang.org/) que possui apenas 3 endpoints:

### API REST

1. HealthCheck

Request:

| PATH        | METHOD |
| ----------- | ------ |
| /api/health | GET

Response:

| CODE | BODY |
| ---- | ---- |
| 200  | `""`   |

2. Hello

Request:

| PATH       | METHOD |
| ---------- | ------ |
| /api/hello | GET

Response:

| CODE | BODY               |
| ---- | ------------------ |
| 200  | `{ msg: "hello" }` |

3. World

Request:

| PATH       | METHOD |
| ---------- | ------ |
| /api/world | GET

Response:

| CODE | BODY               |
| ---- | ------------------ |
| 200  | `{ msg: "world" }` |

### Tarefa/Job

A aplicação também possui uma tarefa que pode ser invocada ao executar o comando:

```bash
$ mix talk
```

ps: Essa documentação possui uma parte que ensina todos os passos para instalação e configuração dessa aplicação.


## Desafio

O candidato deve colocar essa aplicação disponível online, preferencialmente utilizando ferramentas de integração contínua.
Você deve fazer um _fork_ desse repositório, fazer as alterações necessárias e enviar o link desse novo repositório.
Pedimos que documente todas as decisões feitas, detalhando as tecnologias, ferramentas e arquitetura escolhida.
Coloque também na documentação o link para a aplicação online.

### Extra

Existe um job/tarefa implementado nessa aplicação como descrito acima. Crie uma solução para executar essa tarefa a cada 30 minutos, documente suas decisões.


## Instalação

### Elixir

Siga as instruções no [link](https://elixir-lang.org/install.html) para instalação da linguagem [Elixir](https://elixir-lang.org/)

ps: utilizamos a versão `1.8`

### Phoenix

[Phoenix](https://phoenixframework.org/) é um framework web para Elixir, para instalação siga as instruções nesse [link](https://hexdocs.pm/phoenix/installation.html)

ps: utilizamos a versão `1.4.3`


## Execução

Após a instalação utilize o comando:

1. `mix local.hex --force`
2. `mix local.rebar --force`
3. `mix deps.get` para fazer o download de todas as dependências
4. `mix phx.server` para executar a aplicação em modo de `desenvolvimento`

A aplicação ficará disponível localmente na porta `4000`.
Execute o comando `curl http://127.0.0.1:4000` e obterá uma resposta da aplicação

Para executar a aplicação em modo de `produção` primeiramente faça a cópia do arquivo `prod.secret.exs.example` para `prod.secret.exs`:

```bash
$ cp config/prod.secret.exs.example config/prod.secret.exs
```

Agora basta configurar a variável de ambiente `MIX_ENV` com o valor `prod` e executar o mesmo comando para iniciar a aplicação `mix phx.server`:

```bash
$ MIX_ENV=prod mix phx.server
```

Dessa forma a aplicação responderá localmente na porta `4000` como anteriormente.


## Testes unitários

Para executar os testes presentes na aplicação basta aplicar o comando:

```bash
$ MIX_ENV=test mix test
```
