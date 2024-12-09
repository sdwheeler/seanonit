---
title: 'Features of Help'
weight: 3
navWeight: 7
featured: false
draft: false
comment: false
toc: true
pinned: false
postDate: false
date: 2023-08-15
index: true
---

![Features of Help][02]

The PowerShell help system is a powerful tool for learning and using PowerShell. It's a key part of
the PowerShell experience. It's important to understand the features of the help system so that you
can take advantage of them.

The `Get-Help` cmdlet has several parameters that provide the following features:

- Search and filter by topic, parameter, component, role, functionality, category
- Control display verbosity using `-Examples`, `-Detailed`, and `-Full`
- Open in a browser using `-Online`
- Install or update help content using `Update-Help`

## Enabling these features for your help content

When you create help for your cmdlets, there are several requirements you must fulfill to enable
these features. Some these features require content to be written, such as examples and detailed
descriptions of parameters. Others features require you to add metadata attributes to your source
code.

<!-- link references -->
[02]: images/pshelp/slide3.png
