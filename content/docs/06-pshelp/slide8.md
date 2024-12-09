---
title: 'PlatyPS - A tool for PowerShell MAML'
weight: 8
navWeight: 2
featured: false
draft: false
comment: false
toc: true
pinned: false
postDate: false
date: 2023-08-15
index: true
---

![PlatyPS - A tool for PowerShell MAML][04]

**PlatyPS** is tool that makes the creation and maintenance of MAML easier. You don't have to create
the content in the MAML XML format. Using .NET reflectino, PlatyPS documents the syntax of parameter
sets and the individual parameters for each cmdlet in your module. PlatyPS creates structured
Markdown files that contain the syntax information. It can't create descriptions or provide
examples.

The Markdown created by PlatyPS contains placeholders for you to fill in descriptions and examples.
After adding the required information, PlatyPS compiles the Markdown files into MAML files.
PowerShell's help system also allows for plain-text conceptual help files (about topics). PlatyPS
has a cmdlet to create a structured Markdown template for a new about file, but these
`about_*.help.txt` files must be maintained manually.

You can include the MAML and text help files with your module. You can also use PlatyPS to compile
the help files into an archive package that can be hosted for updateable help.

For more information, see [PlatyPS overview][02].

Also, the Markdown content can converted to HTML and hosted on a web server. There are many static
site generators that can be used to create a website from the Markdown files. We will show you how
to use [Hugo][01].

## PlatyPS history

**PlatyPS** is an open-source tool that started as a hackathon project to make the creation and
maintenance of MAML easier.

<!-- link references -->
[01]: https://gohugo.io/
[02]: https://learn.microsoft.com/powershell/utility-modules/platyps/overview
[04]: images/pshelp/slide8.png
