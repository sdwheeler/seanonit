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
date: 2025-03-18
index: true
---
<!-- markdownlint-disable MD041 -->

![How to solve the authoring problem][01]

The **platyPS** module was created to make writing PowerShell documentation easier. Development of
the module started 10-years ago as a hackathon project by a few members of the PowerShell team. The
idea was to create a tool that could create a Markdown files a command, since writing in Markdown is
much easier simpler. The tool could then convert the Markdown files to the MAML needed for
PowerShell Help.

At that time, Markdown was gaining popularity and had spawn dozens of variants. But there was no
standard for the Markdown syntax and no standard libraries for parsing Markdown. The project was
forced to create its own Markdown parser and MAML writer.

The project evolved over the years, adding features and fixing bugs. It succeeded in making it
easier to write documentation for PowerShell commands. But, it was never intended to be a production
tool. It was a hackathon project that escaped into production.

The **platyPS** module has several limitations:

- The workflow is monolithic. It only supports file operations and has no pipelining.
- Because there were not standard library available, they had to create their own Markdown, YAML,
  and MAML libraries.
- The structure of the Markdown is, essentially, hard-coded. It's easy to violate the schema, which
  breaks the build.
- The design of the data module is weak. All objects are internal. You only get files.
- Lack of developer resources has left us with many long-standing bugs:
  - Incomplete metadata discovery
  - Incomplete representation of command data (e.g. parameter set metadata)
  - Script-based commands = slow performance

<!-- link references -->
[01]: images/platypsv1/04-problem.png
