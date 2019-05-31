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
## Amazon EC2

Neste projeto optamos por utilizar o AWS Cloud, pela praticidade que temos envolvendo todas as plataformas que utilizamos neste projeto, tendo uma fácil configuração entre o GitHub, Docker, Jenkins e Kubernetes, dessa forma agilizando nosso processo de configuração da Cloud e assim criando um ambiente seguro, prático e integro para a utilização deste projeto.

Iremos focar em uma infraestrutura pequena, de baixo custo e que atenda todas as especificação deste projeto, sendo assim:

```
1 - EC2 t2.micro(Free Tier) - Jenkins Master
1 - EC2 t2.micro(Free Tier) - Jenkins Slave
1 - EC2 t3.small - MiniKube
```

Recomendo que utilize também o Google Cloud, pela fácilidade de sua configuração e pelos seus custos reduzidos, o que em médio e longo prazo, pode trazer um retorno muito maior para a empresa/pessoa fisíca, do que os valores que a AWS cobra. Como este projeto utiliza somente ferramentas OpenSource, você fica livre de utilizar a Cloud que você preferir.

## GitHub

O GitHub foi selecionado para ser o nosso gerenciador de versão, pois é uma das ferramentas mais completas do mercado hoje em dia, tendo uma vasta gama de utilizadores, sendo apoiado por uma das maiores empresas de tecnologia atuais, a Microsoft. 

Com todo o tempo de vida do GitHub, ele pode ser muito bem trabalhado, desenvolvido e criado formas de se gerenciar suas versões da aplicação de forma mais prática e fácil, dessa forma facilitando quando se precisa dar um RollBack, ou até mesmo verificar certos tipos de modificações feitas apartir com o tempo.

Com uma boa gestão de versionamento, pode fazer com que toda a equipe saia ganhando, e agilizando o processo de desenvolvimento até o momento do Deployment.

## Docker

O Docker foi selecionado para a geração de Build na Integração Contínua pela praticidade e facilidade que ele nos apresentar, ao ser fácilmente passado de uma Máquina para outra, sendo necessário apenas o pull da imagem para que você possa inicializar a aplicação.

Com o Docker você tem uma fácilidade de inicializar uma nova instância da aplicação(Escalabilidade), fácil criação de ambiente de desenvolvimento/produção padronizados, padronização na forma em que os programadores trabalham e por ser suportado e desenvolvido pela comunidade, sendo uma aplicação Open Source de grande aceitação pelas empresas.

Instalação do Docker:

[Docker](https://docs.docker.com/install/linux/docker-ce/ubuntu/)

## DockerHub

O DockerHub foi selecionado como Repositorio de Imagens por ser um repositório público, de ampla utilização, e de fácil configuração, dessa forma seus projetos podem ser suportados pela comunidade, além de não precisar pagar, economizando e armazenando suas imagens, para utilizar sempre que for necessário.

## Jenkins

O Jenkins foi selecionado para a geração da imagem na Integração Contínua pela praticidade de se utilizar essa ferramenta com outras ferramentas, como por exemplo o Git, Docker, Kubernets. Com essa ferramenta podemos gerar Builds automatizadas, o que faz com que todo o ambiente de desenvolvimento e produção, flua de uma forma mais rápida, segura e de difícil falhas, sendo possível descrever Pipelines novas para cada aplicação que se deseja automatizar a Build, dessa forma padronizando todo o processo e ganhando em velocidade de entregas para o Cliente e para os desenvolvedores.

Optamos por armazenar nossas imagens geradas em um repositório do DockerHub, por questão de praticidade que temos utilizando este repositório publico. Assim o Kubernets pode subir fácilmente uma imagem proveniente da Build automatizada.

No Jenkins podemos optar por gerar um nuvem automática, proveniente da AWS EC2, dessa forma podemos gerar varias Builds simultâneas sem termos problema com recursos. Única problema de trabalharmos dessa forma é que poderemos perder o controle de quantas Builds estamos gerando, o que pode ocasionar em um custo muito elevado de recursos. Recomendo que faça alguns controles pelo próprios Jenkins para evitar esse tipo de situação.

Para a configuração deste projeto no Jenkins, é necessário criar um "Job" - "Pipeline", configurar contendo os seguintes "parâmetros" ou variáveis de ambiente:

PORT: Parâmetro String -> Porta padrão de execução da sua aplicação.
MIX_ENV: Parâmetro String -> Environment de execução da sua aplicação.
docker_login: Parâmetro String -> Usuário de conexão ao DockerHub que será hospedado a sua imagem.
docker_password: Parâmetro de Senha -> Senha de conexão, referente ao usuário do DockerHub, necessária para a autenticação.
name_project: Parâmetro String -> Nome do repositório criado no DockerHub, para armazenar as imagens criadas.
environment: Parâmetro String -> Environment para Taggear sua imagem da maneira correta.
repository_name: Parâmetro String -> Nome do hub-user que será enviado no DockerHub, provavelmente o mesmo do docker_login.

É necessário também configurar um Jenkins Slave, contendo a Label "docker", que é o que o nosso Pipelina utiliza para selecionar em qual node será utilizado para a geração da Build. Nesta configuração eu geralmente opto em utilizar o plugin do Jenkins "Amazon EC2 (Plugin)", pela praticidade de se utilizar esse plugin e por poder configurar facilmente uma máquina EC2, quando necessária, e desativa-lá quando não for utiliza-lá novamente. Outras formas de fazermos esse processo é utilizando o Kubernetes para automatizar a criação de Slaves do Jenkins, uma prática muito utilizada em ambientes de produção e que a maioria das maiores empresas utilizam hoje em dia, porém para este passo-a-passo iremos utilizar o plugin relatado acima graças a sua praticidade de configurar. Segue um link de configuração do plugin "Amazon EC2 (Plugin)":

[Amazon EC2 Plugin](https://plugins.jenkins.io/ec2)

Segue um Init Script que será utilizado neste projeto:

```
# Install Docker
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io
sudo usermod -aG docker $USER
sudo apt-get install -y openjdk-8-jdk
```

Recomendo que você utilize uma imagem docker do Jenkins para facilitar a configuração do seu ambiente! Obs: Um Jenkins bem configurado, mesmo que o Container morra no processo, você não perde as configurações já realizadas, para isso no site do DockerHub do Jenkins eles demonstram como é feita essa configuração. Docker Hub Jenkins:

[Jenkins DockerHub](https://hub.docker.com/_/jenkins/)

Se caso preferir, pode instalar o Jenkins diretamente no EC2:

[Jenkins](https://jenkins.io/doc/book/installing/)

## Kubernets (MiniKube)

O Kubernets foi selecionado como ferramenta de Deployment para esta aplicação, pois é o mais usado hoje na comunidade, pela praticidade que temos ao se utilizar essa ferramenta, pela quantidade de Plugins e formas diferentes de se trabalhar com ele, por ser uma ferramentas OpenSource e apoiada por toda comunidade, sendo inicialmente criada pela Google em cima de seu sistema Borg.

Nesta aplicação optamos por utilizar o MiniKube, por se tratar de uma demonstração e não de fato uma aplicação em produção. Para se utilizar em uma aplicação em produção, recomendo que você utilize o Kubernets de forma completa, sendo preferêncialmente instalado pelo KubeAdm, dessa forma já configurando seu Kubernets com algumas pendências já resolvidas. Recomendo que leia o site do Kubernets para maiores informações:

[Kubernets](https://kubernetes.io/pt/)