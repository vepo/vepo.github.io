---
layout: default
title: CSV Viewer
tags: [CSV Viewer, Linux, Open Source]
permalink: /projects/csv-viewer
description: CSV Viewer is a CLI application to enable reading CSV files on Linux.
comments: true
github: "https://github.com/vepo/csv-viewer"
---

# The purpose
Build a CLI tool for reading CSV files.

# The Tools

For this project it was used:
* C Language
* NCurses
* GNU autotools
* Unit Test for C

# Installer

To install it, just execute:

```bash
curl https://vepo.github.io/assets/bin/get-csvi | sudo bash
```

Then you can easily see your csv files with:

```bash
csvi some-file.csv
```

```
$ csvi -h
csvi - CSV Viewer 0.0.1

Usage: csvi [options] file
Options:                                                      Default Values
  --separator    -s     Cell Separator                        ;
  --help         -h     Print this message
  --version      -v     Print the version of this build

Any questions: @vepo
```

# Results

![csvi](/assets/images/pet-projects/csv-viewer/sample-data.png)
