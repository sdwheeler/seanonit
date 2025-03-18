---
title: What is MAML?
weight: 3
navWeight: 8
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

![What is MAML?][02]

Microsoft Assistance Markup Language (MAML) is an XML-based markup language developed by the
Microsoft User Assistance Platform team to provide online help for Microsoft products. Previously,
online help for Windows Microsoft Compiled HTML Help (`.chm`) files. The structured nature of MAML
allows for transformation into different presentation formats, such as HTML, plain text, and others.

MAML can be used with, or in place of, comment-based help. MAML is the only way to provide help for
compiled in PowerShell.

Shortcomings

- Being XML, MAML is difficult to write and maintain.
- The MAML schema not well documented.
- Microsoft created an internal tool specifically for creating MAML files for PowerShell
  documentation, but it was never released to the public.
- Microsoft created the **Sandcastle** tool for authoring MAML files, but support for the tool was
  discontinued in October 2012.
- [Sandcastle][01] is now maintained by Eric Woodruff as an open source project.
- Microsoft no longer uses MAML for its own documentation.

<!-- link references -->
[01]: https://ewsoftware.github.io/SHFB/html/bd1ddb51-1c4f-434f-bb1a-ce2135d3a909.htm
[02]: images/platypsv1/03-maml.png
