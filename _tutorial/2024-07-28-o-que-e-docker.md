---
layout: "tutorial"
title: O que é Docker
published: true
description: Nesse tutorial vou ensinar o que é o docker e como usar Docker para distribuir aplicações.
tags: [Docker]
publish_date: 2024-07-28 22:00:00 +0300
permalink: /tutorial/o-que-e-docker
cover_image: /assets/images/chaplin-modern-times-100-42.webp
---

Esse tutorial está armazenado em 

{% github https://github.com/vepo/docker-tutorial %}

Antes de começa precisamos primeiro definir o que é Docker. Seria?

1. Uma empresa?
2. Uma tecnologia?
3. Um produto?
4. Um padrão?

A respota certa são todas as respostas acima. Docker é uma tecnologia de conteinerização _(2)_ criada pela empresa Docker Inc. _(1)_ que acabou gerando uma série de produtos como Docker Hub _(3)_, mas posteriormente foi aberto para CNCF como um padrão chamado [containerd.io](https://containerd.io/) _(4)_.

Ao contrário da virtualização, a conteinerização consiste em se criar processos isolados dentro de um sistema operacional usando uma série de tecnologias do proprio Kernel do SO. Como falamos de Kernel, já estamos afirmando que ele surgiu no ambiente Linux, mas sistemas operacionais como o Windows já se mostraram capazes de criar containeres, mesmo não sendo popular.

Um container é um padrão de componente que permite o empacotamento de aplicações e suas dependências em uma forma de fácil distribuição. Ao executar uma aplicação baseada em containers, não dependemos de nenhuma dependência além da plataforma de conteinerização.

## Quais são essas tecnologias?

Docker se baseia em algumas tecnologias já existentes no Linux.
* [COW - Copy On Write](https://pt.wikipedia.org/wiki/C%C3%B3pia_em_grava%C3%A7%C3%A3o)
* [cgroups](https://en.wikipedia.org/wiki/Cgroups)
* [iptables](https://pt.wikipedia.org/wiki/Iptables)
* [Linux Namespaces](https://en.wikipedia.org/wiki/Linux_namespaces)

### COW

_Copy On Write_ é uma técnica que permite a criação de uma estrutura de arquivos por camada. Cada camada altera a anterior e camadas podem ser compartilhadas com processos diferentes.

### cgroups

_cgroups_ é uma feature do Linux que permite controlar o tanto de recurso (CPU, Memória, I/O) que um processo pode utilizar.

### iptables

_iptables_ é um programa Linux que permite criar regras de redirecionamento de portas dentro do Linux.

### Linux Namespaces

_Linux Namespaces_ permite o compartilhamento, e o isolamento, de recursos do SO dentro do Linux. Similar ao _cgroups_, mas se refere a outros tipos de recursos. Por exemploe: PIDs, nomes de arquivos, hostnames, etc...

## Docker Building Blocks

Gosto do conceito de Building Blocks, quando me refiro a ele estou definindo elementos básicos para algo. Assim em Docker podemos definir alguns building blocks.

Para o desenvolvimento de qualquer aplicação Docker, é necessário entender o que são cada um desses elementos.

* Imagem
    * TAGs
* Container
    * Volume
    * Network
* Registry
* Dockerfile

### Imagem

Uma Imagem é uma foto do Container em seu momento inicial. Se formos comparar com os conceitos de máquinas virtuais, a Imagem seria um SNAPSHOT.

Uma Imagem é usada para gerar um Container. Uma Imagem pode ser gerada a partir de um Container. Uma Imagem tem algumas propriedades que extendem o conceito de Snapshot, podemos definir qual comando a Imagem irá executar assim que ela iniciar.

Uma Imagem é preferencialmente construida a partir de um Dockerfile.

#### TAGs

Uma Imagem pode ter uma ou mais TAG associada. Cada imagem possui um nome, este nome pode estar associado a várias TAGs. 

Por exemplo, se formos criar um container do MariaDB, sabemos que o nome dele é `mariadb`. Mas se referenciarmos apenas esse nome, será baixada a image `mariadb:latest`, o que não é tão bom, visto que não sabemos exatamente qual versão será executada. No caso do MariaDB, temos as seguintes TAGs:
* 10.4.10-bionic, 10.4-bionic, 10-bionic, bionic, 10.4.10, 10.4, 10, latest
* 10.3.20-bionic, 10.3-bionic, 10.3.20, 10.3
* 10.2.29-bionic, 10.2-bionic, 10.2.29, 10.2
* 10.1.43-bionic, 10.1-bionic, 10.1.43, 10.1

Uma boa opção, seria utilizar `mariadb:10.4` para escolher a versão **10.4.10** ou qualquer versão futura com bug fixes.

### Container

Um Container é uma instância de uma aplicação. Pode haver vários Containers rodando com a partir da mesma Imagem. Ao se executar um Container é preciso uma Imagem e um conjunto de informações:
* Volumes
* Variáveis de Ambiente
* Portas
* etc...

#### Volume

O Sistema de Arquivo de um Container é descartável. Assim, ao se remover o container, todos os arquivos dele são removidos. Um Volume é um mapeamento entre um diretório da máquina hospedeira para o container. Usando COW, o diretório, ou arquivo, dentro container é sobrescrito. 

#### Network

Quando um container é executado, pode pertencer a uma ou várias Networks. Por padrão, ele pertence a Network Default. Para cada Network associada, ele terá um IP NAT associado. 

Uma Network serve para criar uma VPC. Dois containers só podem se comunicar se pertencerem a mesma Network. Uma Network contém DNS que resolve o IP através do nome do container. Assim, se um container tentar acessar `container-1:8080` estará tentando acessar a porta **8080** do container com nome **container-1**.

### Registry

Um Registry é um servidor web para armazenar uma Imagem. No ciclo de vida de uma Imagem, ela pode ser gerada ou baixada de um Registry. 

O padrão é o [Docker Hub](https://hub.docker.com/), sempre que possível procure imagens lá. No Docker Hub há imagens verificadas e não verificadas. Procure usar as imagens verificadas, caso contrário você pode estar correndo o risco de expor seus dados.


### Dockerfile

Dockerfile é o script de criação de uma Imagem. Uma Imagem deve ser construida através de um script, e pode ser reconstruida em qualquer máquina.

## Criando um Servidor Web

Nessa passo vamos criar um servidor Web usando Nginx:

```bash
$ docker search nginx
NAME                              DESCRIPTION                                     STARS     OFFICIAL   AUTOMATED
nginx                             Official build of Nginx.                        15820     [OK]
jwilder/nginx-proxy               Automated Nginx reverse proxy for docker con…   2094                 [OK]
richarvey/nginx-php-fpm           Container running Nginx + PHP-FPM capable of…   818                  [OK]
jc21/nginx-proxy-manager          Docker container for managing Nginx proxy ho…   275
linuxserver/nginx                 An Nginx container, brought to you by LinuxS…   159
tiangolo/nginx-rtmp               Docker image with Nginx using the nginx-rtmp…   145                  [OK]
jlesage/nginx-proxy-manager       Docker container for Nginx Proxy Manager        143                  [OK]
alfg/nginx-rtmp                   NGINX, nginx-rtmp-module and FFmpeg from sou…   110                  [OK]
nginxdemos/hello                  NGINX webserver that serves a simple page co…   77                   [OK]
privatebin/nginx-fpm-alpine       PrivateBin running on an Nginx, php-fpm & Al…   60                   [OK]
nginx/nginx-ingress               NGINX and  NGINX Plus Ingress Controllers fo…   57
nginxinc/nginx-unprivileged       Unprivileged NGINX Dockerfiles                  54
staticfloat/nginx-certbot         Opinionated setup for automatic TLS certs lo…   25                   [OK]
nginxproxy/nginx-proxy            Automated Nginx reverse proxy for docker con…   24
nginx/nginx-prometheus-exporter   NGINX Prometheus Exporter for NGINX and NGIN…   22
schmunk42/nginx-redirect          A very simple container to redirect HTTP tra…   19                   [OK]
centos/nginx-112-centos7          Platform for running nginx 1.12 or building …   16
centos/nginx-18-centos7           Platform for running nginx 1.8 or building n…   13
bitwarden/nginx                   The Bitwarden nginx web server acting as a r…   11
flashspys/nginx-static            Super Lightweight Nginx Image                   11                   [OK]
mailu/nginx                       Mailu nginx frontend                            9                    [OK]
sophos/nginx-vts-exporter         Simple server that scrapes Nginx vts stats a…   7                    [OK]
ansibleplaybookbundle/nginx-apb   An APB to deploy NGINX                          3                    [OK]
wodby/nginx                       Generic nginx                                   1                    [OK]
arnau/nginx-gate                  Docker image with Nginx with Lua enabled on …   1                    [OK]
```

```bash
$ docker run --name hello-world -p 8080:80 -d nginx
Unable to find image 'nginx:latest' locally
7d63c13d9b9b: Pull complete
5cb019b641b5: Pull complete
d477de77abf8: Pull complete
c60e7d4c1c30: Pull complete
365a49996569: Pull complete
039c6e901970: Pull complete
Digest: sha256:d1ce0f99f6a8acc9162c29497014716c44d126f1d41deee40a2c13e3d9d9b02a
Status: Downloaded newer image for nginx:latest
afc52ea50894abea646ccbeff935b77206e68b53bb05b32b4c5679e5b014743b
```

Agora o NGIX está rodando e pode ser usado através da porta 8080, mesmo internamente expondo a porta 80.

```bash
$ curl localhost:8080 -s
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
html { color-scheme: light dark; }
body { width: 35em; margin: 0 auto;
font-family: Tahoma, Verdana, Arial, sans-serif; }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
```

Esse container está rodando com a imagem base do NGIX, para verificar quais containeres estão em execução, execute `docker ps`:

```bash
$ docker ps
CONTAINER ID   IMAGE     COMMAND                  CREATED         STATUS         PORTS                                   NAMES
afc52ea50894   nginx     "/docker-entrypoint.…"   6 minutes ago   Up 6 minutes   0.0.0.0:8080->80/tcp, :::8080->80/tcp   hello-world
```

Através do CLI do docker é possível verificar as estatísticas do container em execução.


```bash
$ docker stats --no-stream
CONTAINER ID   NAME          CPU %     MEM USAGE / LIMIT     MEM %     NET I/O           BLOCK I/O   PIDS
afc52ea50894   hello-world   0.00%     6.719MiB / 12.26GiB   0.05%     2.56kB / 2.47kB   0B / 0B     9
```

Os recursos podem ser limitados ao iniciar o container, se quisermos limitar  a memória em 12MB e CPU em 1, basta executar:

```bash
$ docker run --name hello-world --memory 12MB  --cpus 1 -p 8080:80 -d nginx
43848a573db629515d2a73a26eb7293eb2421de937240197f3dfcde97aa26cb6

$ docker stats --no-stream
CONTAINER ID   NAME          CPU %     MEM USAGE / LIMIT   MEM %     NET I/O     BLOCK I/O   PIDS
43848a573db6   hello-world   0.00%     6.652MiB / 12MiB    55.44%    696B / 0B   0B / 0B     9
```

O próximo passo é alterar o container em execução, para isso:

```bash
$ docker cp index.html hello-world:/usr/share/nginx/html/index.html

$ curl localhost:8080 -s
<html>
    <body>
        <h1>My First Container!!!</h1>
    </body>
</html>
```

## Controlando um container

Containers tem um ciclo de vida. Eles nascem e morrem. Mas o pronto principal é que containers tem um processo principal, quando esse processo termina, o container para. Você pode controlar o ciclo de vida de um container pelos comandos `docker start`, `docker stop` e `docker rm`.

Abaixo podemos ver que ao verificar que programa o programa sendo executado pelo processo 1 é o nginx, se esse processo morrer, o container para.

```bash
$ docker run --name hello-world -p 8080:80 -d nginx
f32f770597d5d97f0600c9382dee67e9728f3c5fba9ae82ab2df632ae2977246

$ docker exec -it hello-world bash
root@f32f770597d5:/# ls -lah /proc/1/exe
lrwxrwxrwx 1 root root 0 Nov 22 13:08 /proc/1/exe -> /usr/sbin/nginx
```

Para ter maior familiaridade com a linha de comando docker, execute alguns containers e leia um pouco da documentação do proprio docker.

```bash
$ docker help

Usage:  docker [OPTIONS] COMMAND

A self-sufficient runtime for containers

Options:
      --config string      Location of client config files (default
                           "/home/vepo/.docker")
  -c, --context string     Name of the context to use to connect to the
                           daemon (overrides DOCKER_HOST env var and
                           default context set with "docker context use")
  -D, --debug              Enable debug mode
  -H, --host list          Daemon socket(s) to connect to
  -l, --log-level string   Set the logging level
                           ("debug"|"info"|"warn"|"error"|"fatal")
                           (default "info")
      --tls                Use TLS; implied by --tlsverify
      --tlscacert string   Trust certs signed only by this CA (default
                           "/home/vepo/.docker/ca.pem")
      --tlscert string     Path to TLS certificate file (default
                           "/home/vepo/.docker/cert.pem")
      --tlskey string      Path to TLS key file (default
                           "/home/vepo/.docker/key.pem")
      --tlsverify          Use TLS and verify the remote
  -v, --version            Print version information and quit

Management Commands:
  builder     Manage builds
  buildx*     Build with BuildKit (Docker Inc., v0.6.3)
  compose*    Docker Compose (Docker Inc., v2.1.1)
  config      Manage Docker configs
  container   Manage containers
  context     Manage contexts
  image       Manage images
  manifest    Manage Docker image manifests and manifest lists
  network     Manage networks
  node        Manage Swarm nodes
  plugin      Manage plugins
  scan*       Docker Scan (Docker Inc., 0.9.0)
  secret      Manage Docker secrets
  service     Manage services
  stack       Manage Docker stacks
  swarm       Manage Swarm
  system      Manage Docker
  trust       Manage trust on Docker images
  volume      Manage volumes

Commands:
  attach      Attach local standard input, output, and error streams to a running container
  build       Build an image from a Dockerfile
  commit      Create a new image from a container's changes
  cp          Copy files/folders between a container and the local filesystem
  create      Create a new container
  diff        Inspect changes to files or directories on a container's filesystem
  events      Get real time events from the server
  exec        Run a command in a running container
  export      Export a container's filesystem as a tar archive
  history     Show the history of an image
  images      List images
  import      Import the contents from a tarball to create a filesystem image
  info        Display system-wide information
  inspect     Return low-level information on Docker objects
  kill        Kill one or more running containers
  load        Load an image from a tar archive or STDIN
  login       Log in to a Docker registry
  logout      Log out from a Docker registry
  logs        Fetch the logs of a container
  pause       Pause all processes within one or more containers
  port        List port mappings or a specific mapping for the container
  ps          List containers
  pull        Pull an image or a repository from a registry
  push        Push an image or a repository to a registry
  rename      Rename a container
  restart     Restart one or more containers
  rm          Remove one or more containers
  rmi         Remove one or more images
  run         Run a command in a new container
  save        Save one or more images to a tar archive (streamed to STDOUT by default)
  search      Search the Docker Hub for images
  start       Start one or more stopped containers
  stats       Display a live stream of container(s) resource usage statistics
  stop        Stop one or more running containers
  tag         Create a tag TARGET_IMAGE that refers to SOURCE_IMAGE
  top         Display the running processes of a container
  unpause     Unpause all processes within one or more containers
  update      Update configuration of one or more containers
  version     Show the Docker version information
  wait        Block until one or more containers stop, then print their exit codes

Run 'docker COMMAND --help' for more information on a command.

To get more help with docker, check out our guides at https://docs.docker.com/go/guides/
```

## Imagens e Repositório

O docker é baseado em uma imagem. Uma imagem é o ponto de inicio de um container. Ao se criar um container a partir de uma imagem, ela permanece imutável. Se você alterar um container, a imagem não é alterada.

Containers em execução podem ser salvos como uma nova imagem, para isso use o comando `docker commit`, veja a documentação abaixo:

```bash
$ docker commit --help

Usage:  docker commit [OPTIONS] CONTAINER [REPOSITORY[:TAG]]

Create a new image from a container's changes

Options:
  -a, --author string    Author (e.g., "John Hannibal Smith
                         <hannibal@a-team.com>")
  -c, --change list      Apply Dockerfile instruction to the created image
  -m, --message string   Commit message
  -p, --pause            Pause container during commit (default true)

```

Apesar de existir o comando `docker commit`, não use ele para gerar imagens, prefira o Dockerfile que vamos falar mais a frente.

Imagens são construida em camadas, que podem ser compartilhada entre vários containers. Para verificar o histórico e as informações de uma imagem, use `docker history <image>`.

```bash
$ docker history nginx
IMAGE          CREATED       CREATED BY                                      SIZE      COMMENT
e9ce56a96f8e   5 days ago    /bin/sh -c #(nop)  CMD ["nginx" "-g" "daemon…   0B
<missing>      5 days ago    /bin/sh -c #(nop)  STOPSIGNAL SIGQUIT           0B
<missing>      5 days ago    /bin/sh -c #(nop)  EXPOSE 80                    0B
<missing>      5 days ago    /bin/sh -c #(nop)  ENTRYPOINT ["/docker-entr…   0B
<missing>      5 days ago    /bin/sh -c #(nop) COPY file:09a214a3e07c919a…   4.61kB
<missing>      5 days ago    /bin/sh -c #(nop) COPY file:0fd5fca330dcd6a7…   1.04kB
<missing>      5 days ago    /bin/sh -c #(nop) COPY file:0b866ff3fc1ef5b0…   1.96kB
<missing>      5 days ago    /bin/sh -c #(nop) COPY file:65504f71f5855ca0…   1.2kB
<missing>      5 days ago    /bin/sh -c set -x     && addgroup --system -…   61.1MB
<missing>      12 days ago   /bin/sh -c #(nop)  ENV PKG_RELEASE=1~bullseye   0B
<missing>      12 days ago   /bin/sh -c #(nop)  ENV NJS_VERSION=0.7.0        0B
<missing>      12 days ago   /bin/sh -c #(nop)  ENV NGINX_VERSION=1.21.4     0B
<missing>      12 days ago   /bin/sh -c #(nop)  LABEL maintainer=NGINX Do…   0B
<missing>      5 weeks ago   /bin/sh -c #(nop)  CMD ["bash"]                 0B
<missing>      5 weeks ago   /bin/sh -c #(nop) ADD file:16dc2c6d1932194ed…   80.4MB
```

Imagens podem ser amarzenadas localmente, mas podem ser amarzenadas em um repositório. Ao executar o comando `docker run`, o docker vai procurar a imagem socilitada localmente, se não encontrar vai procurar remotamente. Nos nossos exemplos usamos imagens do repositório padrão do docker, o (hub.docker.com)[https://hub.docker.com/], mas quando há um prefixo na image terminado em `/` significa que esse prefix é a URL do repositório. Isso que dizer que se usassemos a image `quay.io/bitnami/nginx` estariamos usando a imagem armazenada no [quay.io](https://quay.io/) e não no hub.docker.com.

Caso você queira baixar uma imagem, pode fazer isso pelo comando `docker pull quay.io/bitnami/nginx`. Caso você queira fazer o upload de uma imagem, pode usar o comando `docker push <nome da imagem>`. O upload vai seguir a mesma lógica do download, usando o nome da imagem para escolher o repositório.

Imagens podem ser renomeadas e versionadas. Para isso use o comando `docker tag`, veja a documentação abaixo: 

```bash 
$ docker tag --help

Usage:  docker tag SOURCE_IMAGE[:TAG] TARGET_IMAGE[:TAG]

Create a tag TARGET_IMAGE that refers to SOURCE_IMAGE
```

## Criando uma imagem

Agora para finalizar precisamos vamos descrever o melhor método de se criar uma imagem. Vamos supor que queremos criar uma imagem de um servidor Java. Como eu devo começar?

Para se criar imagem, devemos partir de uma outra imagem. Um erro comum de alguns desenvolvedores é usarem imagens das distribuições mais famosas do Linux, mas isso irá gerar uma imagem grande. Prefira imagens menores, se você precisa partir de um Linux básico, prefira o [Alpine Linux](https://www.alpinelinux.org/). Você pode verificar abaixo que um Centos tem 231MB enquanto um Alpine apenas 5,61MB.

```bash
$ docker image ls
REPOSITORY                         TAG         IMAGE ID       CREATED        SIZE
alpine                             latest      0a97eee8041e   9 days ago     5.61MB
centos                             latest      5d0da3dc9764   2 months ago   231MB
```

Como vamos criar um servidor Java, vamos usar a imagem oficial do [openjdk](https://hub.docker.com/_/openjdk). Essa imagem tem várias tags que são usadas para se escolher tanto a versão do Java que vamos usar quanto o sistema operacional que ela contém. Vamos escolher a **openjdk:17-alpine** por dois motivos, o primeiro é que a versão 17 do Java é a Long Term Support (LST), isso signifca mais estabildiade, e por ser menor o que implica que o download dela é mais rápido.

```bash
$ docker image ls
REPOSITORY                         TAG         IMAGE ID       CREATED        SIZE
openjdk                            17-oracle   1b3756d6df61   3 days ago     471MB
openjdk                            17-alpine   264c9bdce361   5 months ago   326MB
```

Agora com essa imagem podemos contruir o nosso Dockerfile. Um Dockerfile é um arquivo descritivo que contém todos os comandos necessários para se contruir uma imagem. É um arquivo texto e o processo de build é feito passo por passo. Para cada passo, o docker inicia um container, aplica o novo comando e salva uma imagem. Isso significa que o Dockerfile não é um script, um processo iniciado em um passo anterior não está ativo no próximo passo. Vamos ao exemplo mais simples?

```Dockerfile
FROM openjdk:17-alpine

ADD target/my-server.jar my-server.jar

EXPOSE 8080/tcp
ENV HTTP_PORT="8080"

ENTRYPOINT ["java", "-jar", "my-server.jar"]
```

A partir desse arquivo podemos gerar uma imagem usando o comando `docker build -t my-server:1.0.0 .`. Observe que o último paramêtro é diretório onde o Dockerfile está localizado. Para conhecer melhor um Dockerfile, recomendo ler a [documentação](https://docs.docker.com/engine/reference/builder) e o guia de [boas práticas](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/) dele.

Caso você não queira ter o Java instalado na sua máquina e fazer toda a build usando o docker, é possível fazer uma _multi stage build_ sem comprometer sua imagem com camadas desncessárias.

```Dockerfile
# Passo 1: Build e Package
FROM maven:3.8.3-openjdk-17 as builder

WORKDIR /build

ADD pom.xml   /build/pom.xml
RUN mvn dependency:go-offline

ADD src       /build/src
RUN mvn package

# Passo 2: create image
FROM openjdk:17-alpine

ADD  --from=target /build/target/my-server.jar my-server.jar

EXPOSE 8080/tcp
ENV HTTP_PORT="8080"

ENTRYPOINT ["java", "-jar", "my-server.jar"]
```

Finalizada a imagem, é só subir para algum repositório: `docker push my-server:1.0.0`. É muito provavel que você tenha que fazer login no repoisótio, isso pode ser feito usando `docker login` (para o hub.docker.com) e `docker login <repo>` para demais.
