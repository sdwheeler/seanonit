---
title: Microsoft.PowerShell.PlatyPS v1.0
weight: 5
navWeight: 6
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

![Microsoft.PowerShell.PlatyPS v1.0][04]

## The replacement for platyPS

**Microsoft.PowerShell.PlatyPS** (PlatyPS) is a complete rewrite in C#.

Goals

- Address long standing bugs and limitations
- Expand the schema to support more documentation features (e.g parameters and parameter set
  metadata)
- Improve validity checking
- Improve performance and scalability for Microsoft's large projects
- Improve MAML rendering
- Create a more robust object model
- New cmdlets that output objects to the pipeline
- Flexible design that makes it easy to build extensions and solutions

In the intervening years, the [CommonMark][01] organization has created standardized specification
for Markdown. Microsoft uses the .NET library [markdig][03], which supports CommonMark standards and
popular extensions. The module also uses [YamlDotNet][02] for YAML parsing and generation.

Microsoft.PowerShell.PlatyPS released in July 2025 and has replace the old platyPS module in the
Microsoft documentation pipeline. As of April 2026, there are some known issues with MAML conversion
that the PowerShell team is comitted to fixing.

While the design changes were focused on meeting the needs of the internal partners first, this
version should be suitable for generating help for your own projects.

## What does PlatyPS actually do?

Historically, people have misunderstood what PlatyPS does. Some of the common questions I hear
are:

Q: Does it write the documentation for me?

: **A:** No, it creates Markdown templates that you must fill in. You still have to write the
documentation.

Q: Can PlatyPS extract comments from my code to create documentation?

: **A:** PlatyPS can use comment-based help in PowerShell scripts and modules to create
documentation. But it can't extract comments from your code C#.

Q: Can PlatyPS read documentation strings from another source?

: **A:** PlatyPS can't read strings from another source. However, the new PlatyPS creates objects
with properties that you can modify before exporting them to Markdown. This means you can write your
own code to read strings from another source and add them to the objects.

**There are two immutable truths about using PlatyPS:**

- There will always be a manual step that requires you to write the documentation (somewhere).
- You still need to edit the Markdown to ensure accuracy and completeness.

<!-- link references -->
[01]: https://commonmark.org/
[02]: https://github.com/aaubry/YamlDotNet
[03]: https://github.com/xoofx/markdig
[04]: images/platypsv1/05-platypsv1.png
