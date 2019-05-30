# Elixir-Docker-Jenkins


## A aplicação

Está aplicação é uma aplicação em Elixir, criada para a demonstração da utilização de Integração Contínua com Jenkins e Docker. Com ela você pode analisar e verificar como é feito uma integração contínua utilizando Docker, o Build sendo gerado apartir do Jenkins e o Deploy da aplicação sendo feito via MiniKube.

Nosso objetivo não é demonstrar como a aplicação funciona internamente, sendo apenas com o objetivo de demonstrar como o Build é feito com a aplicação.

Abaixo descrevo os Endpoints que estão presentes nesta aplicação.

### API REST

1. HealthCheck

Request:

| PATH        | METHOD      |
| ----------- | ----------- |
| /api/health | GET         |

Response:

| CODE | BODY               |
| ---- | ------------------ |
| 200  | `""`               |

2. Hello

Request:

| PATH       | METHOD       |
| ---------- | ------------ |
| /api/hello | GET          |

Response:

| CODE | BODY               |
| ---- | ------------------ |
| 200  | `{ msg: "hello" }` |

3. World

Request:

| PATH       | METHOD       |
| ---------- | ------------ |
| /api/world | GET          |

Response:

| CODE | BODY               |
| ---- | ------------------ |
| 200  | `{ msg: "world" }` |

### Tarefa/Job

A aplicação também possui uma tarefa que pode ser invocada ao executar o comando:

```bash
$ mix talk
```

## GitHub

O GitHub foi selecionado para ser o nosso gerenciador de versão, pois é uma das ferramentas mais completas do mercado hoje em dia, tendo uma vasta gama de utilizadores, sendo apoiado por uma das maiores empresas de tecnologia atuais, a Microsoft. 

Com todo o tempo de vida do GitHub, ele pode ser muito bem trabalhado, desenvolvido e criado formas de se gerenciar suas versões da aplicação de forma mais prática e fácil, dessa forma facilitando quando se precisa dar um RollBack, ou até mesmo verificar certos tipos de modificações feitas apartir com o tempo.

Com uma boa gestão de versionamento, pode fazer com que toda a equipe saia ganhando, e agilizando o processo de desenvolvimento até o momento do Deployment.

## Docker

O Docker foi selecionado para a geração de Build na Integração Contínua pela praticidade e facilidade que ele nos apresentar, ao ser fácilmente passado de uma Máquina para outra, sendo necessário apenas o pull da imagem para que você possa inicializar a aplicação.

Com o Docker você tem uma fácilidade de inicializar uma nova instância da aplicação(Escalabilidade), fácil criação de ambiente de desenvolvimento/produção padronizados, padronização na forma em que os programadores trabalham e por ser suportado e desenvolvido pela comunidade, sendo uma aplicação Open Source de grande aceitação pelas empresas.

Instalação do Docker:

[Docker](https://docs.docker.com/install/linux/docker-ce/ubuntu/)

## Jenkins

O Jenkins foi selecionado para a geração da imagem na Integração Contínua pela praticidade de se utilizar essa ferramenta com outras ferramentas, como por exemplo o Git, Docker, Kubernets. Com essa ferramenta podemos gerar Builds automatizadas, o que faz com que todo o ambiente de desenvolvimento e produção, flua de uma forma mais rápida, segura e de difícil falhas, sendo possível descrever Pipelines novas para cada aplicação que se deseja automatizar a Build, dessa forma padronizando todo o processo e ganhando em velocidade de entregas para o Cliente e para os desenvolvedores.

Optamos por armazenar nossas imagens geradas em um repositório do DockerHub, por questão de praticidade que temos utilizando este repositório publico. Assim o Kubernets pode subir fácilmente uma imagem proveniente da Build automatizada.

No Jenkins podemos optar por gerar um nuvem automática, proveniente da AWS EC2, dessa forma podemos gerar varias Builds simultâneas sem termos problema com recursos. Única problema de trabalharmos dessa forma é que poderemos perder o controle de quantas Builds estamos gerando, o que pode ocasionar em um custo muito elevado de recursos. Recomendo que faça alguns controles pelo próprios Jenkins para evitar esse tipo de situação.

Recomendo que você utilize uma imagem docker do Jenkins para facilitar a configuração do seu ambiente! Obs: Um Jenkins bem configurado, mesmo que o Container morra no processo, você não perde as configurações já realizadas, para isso no site do DockerHub do Jenkins eles demonstram como é feita essa configuração. Docker Hub Jenkins:

[Jenkins DockerHub](https://hub.docker.com/_/jenkins/)

Instalação do Jenkins:

[Jenkins](https://jenkins.io/doc/book/installing/)

## Kubernets (MiniKube)

O Kubernets foi selecionado como ferramenta de Deployment para esta aplicação, pois é o mais usado hoje na comunidade, pela praticidade que temos ao se utilizar essa ferramenta, pela quantidade de Plugins e formas diferentes de se trabalhar com ele, por ser uma ferramentas OpenSource e apoiada por toda comunidade, sendo inicialmente criada pela Google em cima de seu sistema Borg.

Nesta aplicação optamos por utilizar o MiniKube, por se tratar de uma demonstração e não de fato uma aplicação em produção. Para se utilizar em uma aplicação em produção, recomendo que você utilize o Kubernets de forma completa, sendo preferêncialmente instalado pelo KubeAdm, dessa forma já configurando seu Kubernets com algumas pendências já resolvidas. Recomendo que leia o site do Kubernets para maiores informações:

[Kubernets](https://kubernetes.io/pt/)