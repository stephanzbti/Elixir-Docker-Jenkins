# Elixir-Docker-Jenkins

## A aplicação

Está aplicação é uma aplicação em Elixir, criada para a demonstração da utilização de Integração Contínua com Jenkins e Docker. Com ela você pode analisar e verificar como é feito uma integração contínua utilizando Docker, o Build sendo gerado apartir do Jenkins e o Deploy da aplicação sendo feito via MiniKube.

Nosso objetivo não é demonstrar como a aplicação funciona internamente, sendo apenas com o objetivo de demonstrar como o Build é feito com a aplicação.

Exemplo da aplicação online:

[Exemplo Aplicação](http://54.242.185.255:31873)

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

Neste projeto optamos por utilizar a AWS Cloud, pela praticidade que temos envolvendo todas as plataformas que utilizamos neste projeto, tendo uma fácil configuração entre o GitHub, Docker, Jenkins e Kubernetes, dessa forma agilizando nosso processo de configuração da Cloud e assim criando um ambiente seguro, prático e integro para a utilização deste projeto.

Iremos focar em uma infraestrutura pequena, de baixo custo e que atenda todas as especificação deste projeto, sendo assim:

```
1 - EC2 t2.micro(Free Tier) - Jenkins Master
1 - EC2 t2.micro(Free Tier) - Jenkins Slave
1 - EC2 t3.small - MiniKube
```

Recomendo que utilize também o Google Cloud, pela fácilidade de sua configuração e pelos seus custos reduzidos, o que em médio e longo prazo, pode trazer um retorno muito maior para a empresa/pessoa fisíca, do que os valores que a AWS cobra. Como este projeto utiliza somente ferramentas OpenSource, você fica livre de utilizar a Cloud que você preferir.

## GitHub

O GitHub foi selecionado para ser o nosso gerenciador de versão, pois é uma das ferramentas mais completas do mercado hoje em dia, tendo uma vasta gama de utilizadores, sendo apoiado por uma das maiores empresas de tecnologia atuais, a Microsoft. 

Com todo o tempo de vida do GitHub, ele pode ser muito bem trabalhado, desenvolvido e criado formas de se gerenciar suas versões da aplicação de forma mais prática e fácil, dessa forma facilitando quando se precisa dar um RollBack, ou até mesmo verificar certos tipos de modificações feitas apartir do tempo.

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

É necessário também configurar um Jenkins Slave, contendo a Label "docker", que é o que o nosso Pipeline utiliza para selecionar em qual node será utilizado para a geração da Build. Nesta configuração, demonstração, eu geralmente opto em utilizar o plugin do Jenkins "Amazon EC2 (Plugin)", pela praticidade de se utilizar esse plugin e por poder configurar facilmente uma máquina EC2, quando necessária, e desativa-lá quando não for utiliza-lá novamente. Outras formas de fazermos esse processo é utilizando o Kubernetes para automatizar a criação de Slaves do Jenkins, uma prática muito utilizada em ambientes de produção e que a maioria das maiores empresas utilizam hoje em dia, porém para este passo-a-passo iremos utilizar o plugin relatado acima graças a sua praticidade de configurar e o seu custo reduzido. Segue um link de configuração do plugin "Amazon EC2 (Plugin)":

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
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
```

Para fazermos o Deployment de nossa aplicação, utilizamos o MiniKube, e para isso criamos em nosso repositório uma pasta chamada .kube, pelo qual é reponsável por armazenar as informações de autenticação do Host Kubernetes. Com a autenticação é possível fazer deployments automáticos direto no MiniKube.

Recomendo que você utilize uma imagem docker do Jenkins para facilitar a configuração do seu ambiente! Obs: Um Jenkins bem configurado, mesmo que o Container morra no processo, você não perde as configurações já realizadas, para isso no site do DockerHub do Jenkins eles demonstram como é feita essa configuração. Docker Hub Jenkins:

[Jenkins DockerHub](https://hub.docker.com/_/jenkins/)

Se caso preferir, pode instalar o Jenkins diretamente no EC2:

[Jenkins](https://jenkins.io/doc/book/installing/)

### Firewall

Para que a aplicação do Jenkins funcione corretamente é necessário liberar as seguintes portas:

80/TCP -> HTTP Connection
50000/TCP -> Jenkins Connection

## Kubernets (MiniKube)

O Kubernets foi selecionado como ferramenta de Deployment para esta aplicação, pois é o mais usado hoje na comunidade, pela praticidade que temos ao se utilizar essa ferramenta, pela quantidade de Plugins e formas diferentes de se trabalhar com ele, por ser uma ferramentas OpenSource e apoiada por toda comunidade, sendo inicialmente criada pela Google em cima de seu sistema Borg.

Nesta aplicação optamos por utilizar o MiniKube, por se tratar de uma demonstração e não de fato uma aplicação em produção. Para se utilizar em uma aplicação em produção, recomendo que você utilize o Kubernets de forma completa, sendo preferêncialmente instalado pelo KubeAdm, dessa forma já configurando seu Kubernets com algumas pendências já resolvidas. Recomendo que leia o site do Kubernets para maiores informações:

[Kubernets](https://kubernetes.io/pt/)

Optamos em utilizar o kubectl local na máquina de origem por questão da praticidade que temos ao fazermos um deployment utilizando o plugin do Jenkins "Amazon EC2 (Plugin)", porém em um ambiente de produção, recomendo que utilize o próprio Kubernetes para fazer o Build (Jenkins Slave no Kubernetes) e automaticamente fazer o Deployment no próprio Kubernetes, pois da forma que utilizamos nesta aplicação, é necessário armazenar a config dentro do repositório, o que em certos casos pode ser um problema.

É necessário fazer a modificação do config do Kubernetes, pois com ele que iremos fazer o Jenkins Slave, acessar as configurações do Kubernetes Master. Para isso será necessário modificar o arquivo '**config**' que está presente dentro da pasta '**./.kube**', segue o que será necessário modificar:

```
apiVersion: v1
clusters:
- cluster:
    certificate-authority: ./.minikube/ARQUIVO-ca.crt -> Corrigir de acordo com o gerado por seu MiniKube. Se encontra na pasta ~/.minikube/
    server: SERVER_KUBERNETS
  name: minikube
contexts:
- context:
    cluster: minikube
    user: minikube
  name: minikube
current-context: minikube
kind: Config
preferences: {}
users:
- name: minikube
  user:
    client-certificate: ./.minikube/ARQUIVO-client.crt -> Corrigir de acordo com o gerado por seu MiniKube. Se encontra na pasta ~/.minikube/
    client-key: ./.minikube/ARQUIVO-client.key -> Corrigir de acordo com o gerado por seu MiniKube. Se encontra na pasta ~/.minikube/

```

Arquivo YAML que servira para gerar o serviço no Kubernetes, ele se encontra na pasta '**Kubernetes**', dentro do projeto:

```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: elixir-basic-api
  namespace: default
spec:
  replicas: 2
  selector:
    matchLabels:
      app: elixir-basic-api
  template:
    metadata:
      labels:
        app: elixir-basic-api
    spec:
      containers:
      - image: stephanzbti/elixir-basic-api:latest-production
        imagePullPolicy: Always
        name: elixir-basic-api
        env:
          - name: PORT
            value: 80
          - name: MIX_ENV
            value: prod
        ports:
            - containerPort: 80
```

É necessário iniciar o serviço acima, com o comando dentro da pasta Kubernetes deste projeto:

```
kubectl apply -f elixir-basic-api.yaml
```

Para que sua aplicação fique exposta para a rede, é necessário executar o seguinte comando em seu serviço Kubernetes:

```
kubectl expose deployment/elixir-basic-api --type=NodePort
```

Como estamos usando o MiniKube, seria necessário instalar o LoadBalancer Integress para que ele possa gerenciar as rotas para cada aplicação via DNS, mas para adiantar o processo podemos analisar a porta em que a aplicação foi exposta. Será necessário digitar o seguinte comando:

```
kubectl get services
```

Será exibido uma tela parecida com esta:

```
NAME               TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)        AGE
elixir-basic-api   NodePort    10.100.128.159   <none>        80:31873/TCP   5m6s
kubernetes         ClusterIP   10.96.0.1        <none>        443/TCP        178m
```

Neste caso a porta que está dispoível para o projeto, seria 31873/TCP, após libera-lá no Firewall, você já teria acesso a aplicação via navegador/PostMan sem problema.

Caso deseje instalar o LoadBalancer Integress, segue o passo-a-passo abaixo:

[Load Balancer Ingress](https://kubernetes.io/docs/tasks/access-application-cluster/ingress-minikube/)

Lembrando que ao se fazer a configuração inicial do serviço, desde que ela seja bem feita, você não precisará mais da manutenção nela, pois o Build irá subir automaticamente, após o Push do Desenvolvedor.

Obs: Este passo-a-passo, não se aplica a uma aplicação que irá para produção. Fizemos todas essa configuração para criarmos um ambiente facilmente utilizando o MiniKube, e dessa forma podemos criar uma pequena aplicação fácilmente, porém com alguns recursos do Kubernetes reduzidos. Caso deseje fazer uma aplicação para o ambiente de produção, será necessário criar um Kubernetes Master, e seus Nodes! Recomendo que utilize o TerraForm e o Ansible para geração automática, assim que possível irei disponibilizar o TerraForm e o arquivo de configuração do Ansible para a geração completa da infraestructure-as-a-code.

### Firewall

Para que a aplicação Deployada no MiniKube funcione, é necessário liberar as seguintes portas:

8443/TCP -> HTTP Connection Kubernetes
80/TCP -> HTTP Connection