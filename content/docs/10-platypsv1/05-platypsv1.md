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

## What does PlatyPS actually do?

Historically, people have misunderstood what **platyPS** does. Some of the common questions I hear
are:

Q: Does it write the documentation for me?
: A: No, you still have to write the documentation.

Q: Can PlatyPS extracts comments from my code to create documentation?
: A: PlatyPS can use comment-based help content to create documentation for script-based commands
  (functions and scripts). But it can't extract comments from your code C#.

Q: Can PlatyPS read documentation strings from another source?
: A: This is not possible with the old platyPS module. The new PlatyPS created `[CommandHelp]`
  objects. You can alter the properties of these objects before exporting them to Markdown.

There are two immutable truths about using PlatyPS:

- There will always be a manual step that requires you to write the documentation (somewhere).
- You still need to alter the Markdown to ensure accuracy and completeness.

<!-- link references -->
[01]: https://commonmark.org/
[02]: https://github.com/aaubry/YamlDotNet
[03]: https://github.com/xoofx/markdig
[04]: images/platypsv1/05-platypsv1.png
