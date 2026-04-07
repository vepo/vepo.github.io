---
title: Criando um serviço Linux
permalink: /posts/criando-um-servico-linux
published: true
description: Linux tem um excelente suporte a serviço. Vamos tentar demonstrar rapidamente como criar um serviço.
tags: [Linux, Java, Serviços]
image: /assets/images/penguins-100-42.jpg
series: Aprendendo Linux
publish_date: 2021-08-17 16:55:00 +0300
---

Antes de criar um serviço, precisamos preparar o ambiente. Vamos instalar todas as dependências. No caso que estou trabalhando é um bot simples em Java, por isso preciso instalar o git, Java 11 e Maven. Farei a build na própria máquina, esse ambiente é para validação de um conceito, uma PoC que provavelmente vai virar ambiente de produção. MAS... como é um bot, posso transformar ele em uma imagem docker.

Então o primeiro passo é deixar o ambiente redondo para a execução. Instalei o GIT, Java 11, Maven. Coloquei todas as variáveis de ambiente necessárias configuradas pelo `/etc/bashrc`.

Então eu descubro que a versão do Quarkus.io do bot estava completamente desatualizada! 😳

Mas consegui criar executável Java para meu bot, sua tarefa é executar a cada 10s uma operação de atualização. Para isso usei Quakus.

## Serviços Linux

Através do comando `systemctl` o Linux expõe uma série de serviços. Para criar um, basta criar um arquivo texto, mas antes vamos explorar um pouco o próprio comando.

Vamos listar todos os serviços disponiveis?

```bash
$ sudo systemctl list-unit-files
UNIT FILE                                     STATE
proc-sys-fs-binfmt_misc.automount             static
acpid.service                                 enabled
arp-ethers.service                            disable
grub-boot-indeterminate.service               static
grub2-systemd-integration.service             static
sshd-keygen.service                           static
sshd.service                                  enabled
sshd@.service                                 static
network.target                                static
nfs-client.target                             enabled
```

Ora vemos alguns serviços interessantes como o `sshd`, `network` e o `nfs-client`. `sshd` é o daemon do servidor SSH, pelo qual estou conectado. Se eu quiser saber o status do `sshd`?

```bash
$ sudo systemctl status sshd
● sshd.service - OpenSSH server daemon
   Loaded: loaded (/usr/lib/systemd/system/sshd.service; enabled; vendor preset: enabled)
   Active: active (running) since Tue 2021-08-17 19:32:20 UTC; 3h 27min ago
     Docs: man:sshd(8)
           man:sshd_config(5)
 Main PID: 3152 (sshd)
   CGroup: /system.slice/sshd.service
           └─3152 /usr/sbin/sshd -D

Aug 17 22:46:33 ip-172-31-44-73.us-east-2.compute.internal sshd[9447]: Received disconnect from 134.122.63.163 port 34174:11: Normal Shutdown, Thank you for playing [preauth]
Aug 17 22:46:33 ip-172-31-44-73.us-east-2.compute.internal sshd[9447]: Disconnected from 134.122.63.163 port 34174 [preauth]
Aug 17 22:47:45 ip-172-31-44-73.us-east-2.compute.internal sshd[9475]: Invalid user user from 134.122.63.163 port 42936
Aug 17 22:47:45 ip-172-31-44-73.us-east-2.compute.internal sshd[9475]: input_userauth_request: invalid user user [preauth]
Aug 17 22:47:45 ip-172-31-44-73.us-east-2.compute.internal sshd[9475]: Received disconnect from 134.122.63.163 port 42936:11: Normal Shutdown, Thank you for playing [preauth]
Aug 17 22:47:45 ip-172-31-44-73.us-east-2.compute.internal sshd[9475]: Disconnected from 134.122.63.163 port 42936 [preauth]
Aug 17 22:48:55 ip-172-31-44-73.us-east-2.compute.internal sshd[9547]: Invalid user user from 134.122.63.163 port 51822
Aug 17 22:48:55 ip-172-31-44-73.us-east-2.compute.internal sshd[9547]: input_userauth_request: invalid user user [preauth]
Aug 17 22:48:55 ip-172-31-44-73.us-east-2.compute.internal sshd[9547]: Received disconnect from 134.122.63.163 port 51822:11: Normal Shutdown, Thank you for playing [preauth]
Aug 17 22:48:55 ip-172-31-44-73.us-east-2.compute.internal sshd[9547]: Disconnected from 134.122.63.163 port 51822 [preauth]
```

Eu poderia até reiniciar o sshd com o comando abaixo. MAS não seria uma boa ideia...

```bash
sudo systemctl status sshd
```

Para controlar um serviço, podemos usar os seguintes comandos `status`, `start`, `stop`, `reload`, `restart`, `try-restart` e `kill`. Caso queria saber mais sobre essas funcionalidades, execute: 

```bash
sudo systemctl --help
```

## Criando um serviço para um processo Java

Para criar um serviço tempos que escrever um arquivo Unit. Uma documentação detalhada pode ser encontrada em _[How to create systemd service unit in Linux](https://linuxconfig.org/how-to-create-systemd-service-unit-in-linux)_.

Para nosso arquivo vamos colocar todos os binários compilados pelo quarkus em `/opt/meu-bot`, para que eu nunca erre na atualização, criei um script bem simples.

```bash
#!/bin/bash -e
mvn clean package

mkdir -p /opt/meu-bot
sudo rm -R /opt/meu-bot/*

sudo cp -R target/quarkus-app/* /opt/meu-bot/
sudo cp tools/meu-bot.service /etc/systemd/system/
sudo chown -R ec2-user:ec2-user /opt/meu-bot/

sudo systemctl daemon-reload
sudo systemctl restart meu-bot
```

Quem define o serviço é o arquivo `meu-bot.service` que deve ficar na pasta `/etc/systemd/system`. Depois de atualizado o arquivo, precisamos rodar o comando `systemctl daemon-reload` e então é só iniciar o serviço `systemctl restart meu-bot`.

Assim o conteúdo do serviço será:

```
[Unit]
Description=Meu Bot Service
Requires=network.target
After=network.target
StartLimitIntervalSec=0

[Service]
Type=simple
Restart=always
User=ec2-user
ExecStart=/usr/lib/jvm/java-11-openjdk-11.0.11.0.9-1.amzn2.0.1.x86_64/bin/java -jar /opt/meu-bot/quarkus-run.jar
WorkingDirectory=/opt/meu-bot/

[Install]
WantedBy=multi-user.target
```

Observe que preciso definir alguns parâmetros obrigatórios como `User`, `ExecStart` e `Requires`. Outros são opcionais como `WorkingDirectory`. Para os outros, eu não validei a necessidade, mas é bom sempre usar. Um detalhe importante nesse arquivo é que todos os executáveis devem ser referênciados pelo caminho absolutor, por isso não usei apenas `java`. Foi necessário buscar o caminho real do executável Java no sistema, nada que usando `whereis java` não resolva.

Agora é só verificar se o serviço está de pé:

```bash
$ systemctl status meu-bot
● meu-bot.service - Meu Bot Service
   Loaded: loaded (/etc/systemd/system/meu-bot.service; enabled; vendor preset: disabled)
   Active: active (running) since Tue 2021-08-17 22:49:26 UTC; 22min ago
 Main PID: 9565 (java)
   CGroup: /system.slice/meu-bot.service
           └─9565 /usr/lib/jvm/java-11-openjdk-11.0.11.0.9-1.amzn2.0.1.x86_64/bin/java -jar /opt/meu-bot/quarkus-run.jar
```

## Acessando o log do serviço

Observe que não falamos de log!

Quando fazemos um serviço, existe várias formas de log. Você pode direcionar o log para um arquivo, ou pode deixar que o sistema operacional cuide dele. Caso deixe para o sistema, pode acessar usando

```
journalctl -f -u meu-bot.service
```

## Conclusão

Criar um serviço é fácil usando Linux. Precisa só de um arquivo texto e seu programa compilado. É a melhor abordagem se você precisa de um programa sempre em execução. Caso seu programa termine a execução ao encontrar qualquer erro, você terá o próprio sistema reinicializando ele.