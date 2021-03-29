---
title: Everything is a file
permalink: /posts/linux-everything-is-a-file
published: true
description: On Linux everything is a file. This is the starting point to learn Linux
tags: [Linux]
cover_image: /assets/images/pexels-dick-hoskins-6969512.jpg
series: Learning Linux
publish_date: 2021-03-03 18:00:00 +0300
---

## Starting point

To learn about the Linux Kernel, the starting point is knowing that everything is a file. Instead of opening the Task Manager, you can inspect the content of `/proc` folder. You can control everything on your running Linux instance only by inspecting some files.

For example:

| Folder | Content |
|--------|---------|
| `/proc` | All running process information |
| `/dev` | All available devices |
| `/sys` | The sysfs is used by programs such as udev to access device and device driver information. |
| `/var` | The standard folder where system writes data during the course of its operation. |
| `/usr` | This is one of the most important directories in the system as it contains all the user binaries, their documentation, libraries, header files, etc.... |
| `/bin` | This folder contains commands or scripts or executable which can be executed to accomplish a task. |

A good starting point is exploring `/proc` folder. This folder has all information about all running process. All running process has a unique identifier called PID, that means **Process IDentification**. If you have a process with PID `472`, you can get all information about it using:

```bash
$ ls  /proc/472
attr  auxv  cgroup  cmdline  comm  cwd  environ  exe  fd  gid_map  limits  maps  mountinfo  mounts  mountstats  net  ns  oom_adj  oom_score_adj  root  schedstat  setgroups  smaps  stat  statm  status  task  uid_map
$ cat  /proc/472/cmdline 
java-classpath/home/vepo/.vscode-server/extensions/adamvoss.vscode-languagetool-3.8.0/lib/languagetool-languageserver/build/install/languagetool-languageserver/lib/*:/home/vepo/.vscode-server/extensions/adamvoss.vscode-languagetool-pt-3.8.0/lib/*App54469
```

--- 

![Pinguims](/assets/images/pexels-dick-hoskins-6969512.jpg)
Picture by Dick Hoskins on Pexels
