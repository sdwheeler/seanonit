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
date: 2026-03-23
index: true
---
<!-- markdownlint-disable MD041 -->

![What is MAML?][02]

Microsoft Assistance Markup Language (MAML) is an XML-based markup language developed by the
Microsoft User Assistance Platform team to provide online help for Microsoft products. Previously,
online help for Windows was published in Microsoft Compiled HTML Help (`.chm`) files. MAML can be
used with, or in place of, comment-based help. MAML is the only way to provide help for compiled in
PowerShell.

The structured nature of MAML allows for transformation into different presentation formats, such as
HTML, plain text, and others. However, in practice, MAML proved to be difficult to author and
maintain, and the tools for working with MAML were not widely adopted.

**Shortcomings**

- Being XML, MAML is difficult to write and maintain.
- The MAML schema not well documented.
- Microsoft created an internal tool specifically for creating MAML files for PowerShell
  documentation, but it was never released to the public.
- Microsoft created the **Sandcastle** tool for authoring MAML files, but support for the tool was
  discontinued in October 2012.
- [Sandcastle][01] is now maintained by Eric Woodruff as an open source project.
- Other than PowerShell, Microsoft no longer uses MAML for its own documentation.

There is one commercial tool that supports authoring MAML-based help for PowerShell: **PowerShell
HelpWriter** by SAPIEN Technologies. The tool has a user-friendly interface for creating and
maintaining MAML-based help files, but it has limitations as well:

- Costs money
- Only runs on Windows
- Doesn't support the latest Markdown schema used by Microsoft
- Doesn't create packages for updateable help

<!-- link references -->
[01]: https://ewsoftware.github.io/SHFB/html/bd1ddb51-1c4f-434f-bb1a-ce2135d3a909.htm
[02]: images/platyps/03-maml.png
