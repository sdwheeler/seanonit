---
title: How to solve the authoring problem
weight: 4
navWeight: 7
featured: false
draft: false
comment: false
toc: true
pinned: false
postDate: false
date: 2026-03-23
index: true
---
<!-- markdownlint-disable MD041 -->

![How to solve the authoring problem][01]

## platyPS - A first attempt

The **platyPS** module was created to make writing PowerShell documentation easier. Development of
the module started in 2016 as a hackathon project by a few members of the PowerShell team. The idea
was to create a tool that allowed you to author documentation in Markdown, a much simpler format
than MAML, and then convert the Markdown to MAML.

At that time, Markdown was gaining popularity and had spawned dozens of variants. But there was no
standard for the Markdown syntax and no standard libraries for parsing Markdown. The project was
forced to create its own Markdown parser and MAML writer.

The project evolved over the years, adding features and fixing bugs. It succeeded in making it
easier to write documentation for PowerShell commands. But, it was never intended to be a production
tool. It was a hackathon project that escaped into production.

The **platyPS** module has several limitations:

- The workflow is monolithic. It only supports file operations and has no pipelining.
- Because no standard libraries existed, they had to create their own Markdown, YAML, and MAML
  libraries.
- The structure of the Markdown is, essentially, hard-coded. It's easy to violate the schema, which
  breaks the build.
- The design of the data module is weak. All objects are internal. You only get files.
- Lack of developer resources has left us with many long-standing bugs:
  - Incomplete metadata discovery
  - Incomplete representation of command data (e.g. parameter set metadata)
  - Script-based commands = slow performance

**platyPS v0.14.2** is the last version of PlatyPS published by Microsoft. Microsoft has no plans to
support or maintain this version of the module.

<!-- link references -->
[01]: images/platyps/04-problem.png
