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
date: 2025-03-18
index: true
---
<!-- markdownlint-disable MD041 -->

![Microsoft.PowerShell.PlatyPS v1.0][04]

**platyPS v0.14.2** is the current version of PlatyPS that's used to create PowerShell help files in
Markdown format. This should be the last version of **platyPS**. Microsoft doesn't plan on
maintaining this version.

**Microsoft.PowerShell.PlatyPS** is a complete rewrite in C#.

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
popular extensions.

For this rewrite, **PlatyPS** uses markdig for Markdown and [YamlDotNet][02] for YAML.

**Microsoft.PowerShell.PlatyPS** is still a work-in-progress. As of March 2025, the version is
1.0.0-preview.2. The PowerShell team is focused on meeting the needs of the internal partners first.
However, the current release is very functional and can be used to generate help for your own
projects.

<!-- link references -->
[01]: https://commonmark.org/
[02]: https://github.com/aaubry/YamlDotNet
[03]: https://github.com/xoofx/markdig
[04]: images/platypsv1/05-platypsv1.png
