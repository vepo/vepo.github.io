---
title: Tudo é um Arquivo
permalink: /posts/linux-tudo-e-um-arquivo
published: true
description: No Linux, tudo é um arquivo. Esse é o primeiro ensinamento para você entender o funcionamento do Linux
tags: [Linux]
cover_image: /assets/images/penguins-100-42.jpg
series: Aprendendo Linux
publish_date: 2021-03-03 18:00:00 +0300
---

## Primeira Lição

Para aprender sobre o Kernel do Linux, a primeira lição é saber que tudo é um arquivo. Por exemplo, se você quiser ver quais são os processos rodando, ao invés de abrir o Gerenciador de Processos, você pode simplesmente abrir a pasta `/proc`. Você pode controlar tudo que está rodando apenas lendo e escrevendo em arquivos.

```
$ ls /proc/
1    145  151  1589  1615  191   2110  222   2640  472  7    cgroups  cpuinfo      interrupts  meminfo  net   stat  tty     version
144  146  153  1600  184   1932  217   2596  2664  6    bus  cmdline  filesystems  loadavg     mounts   self  sys   uptime  version_signature
```

Por exemplo:

| Diretório | Conteúdo |
|--------|---------|
| `/proc` | Todas as informações dos processos em execução  |
| `/dev` | Todos os dispositivos disponíveis  |
| `/sys` | O sysfs é usado por programas como o udev para acessar informações do dispositivo e do driver do dispositivo. |
| `/var` | A pasta padrão onde o sistema escreve dados durante o curso de sua operação. |
| `/usr` | Este é um dos diretórios mais importantes do sistema, pois contém todos os binários do usuário, sua documentação, bibliotecas, arquivos de cabeçalho, etc... |
| `/bin` | Esta pasta contém comandos ou scripts ou executáveis que podem ser executados para realizar uma tarefa. |

Um bom ponto de inicio é explocar a pasta `/proc`. Esta pasta contém todas as informações de todos os processos em execução. Cada processo tem um identificador único chamado **PID**, que significa **Process IDentification**. Vamos supor que temos um processo com PID `472`, podemos saber dele:

```bash
$ ls  /proc/472
attr  auxv  cgroup  cmdline  comm  cwd  environ  exe  fd  gid_map  limits  maps  mountinfo  mounts  mountstats  net  ns  oom_adj  oom_score_adj  root  schedstat  setgroups  smaps  stat  statm  status  task  uid_map
$ cat  /proc/472/cmdline 
java-classpath/home/vepo/.vscode-server/extensions/adamvoss.vscode-languagetool-3.8.0/lib/languagetool-languageserver/build/install/languagetool-languageserver/lib/*:/home/vepo/.vscode-server/extensions/adamvoss.vscode-languagetool-pt-3.8.0/lib/*App54469
ls -l /proc/472/cwd
lrwxrwxrwx 1 vepo vepo 0 Mar  1 08:20 /proc/184/cwd -> '/mnt/c/Users/victoro/AppData/Local/Programs/Microsoft VS Code'
```

--- 

![Pinguins](/assets/images/pexels-dick-hoskins-6969512.jpg)
Foto de Dick Hoskins no Pexels
