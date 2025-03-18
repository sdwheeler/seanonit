---
title: Brief history of PowerShell Help
weight: 2
navWeight: 9
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

![Brief history of PowerShell Help][01]

The Help system for PowerShell was introduced in Windows PowerShell v2.0. The Help system is similar
to **man** pages in Unix. It was designed to provide a consistent way to access help for cmdlets,
functions, and scripts in the console.

Windows PowerShell 3.0 added new features to the Help system:

- `Update-Help` (enabled by HelpInfoUri) - Downloads and installs the latest help content from the
  Microsoft
- `Get-Help -Online` (enabled by HelpUri) - Opens the online version of the help content in the
  default web browser
- `Get-Help -ShowWindow` - Opens the help content in a separate GUI interface

## Sources of help

PowerShell can display help content from three different sources:

- .NET reflection
- Comment-based help
- MAML-based help

The sources are listed in order of precedence. Comment-based help overrides .NET reflection.
MAML-based help overrides both .NET reflection and comment-based help.

### .NET reflection

Using .NET Reflection, PowerShell can extract information about the command syntax, parameters, and
return values for cmdlets, scripts, and functions. This is the help content displayed when no other
help content is available.

### Comment-based help for scripts

For functions in script-based modules and script files, PowerShell can extract help content from
specially formatted comments.

For more information see [about Comment Based Help][01].

### MAML-based help

The PowerShell help system can display help content stored in XML file using the Microsoft
Assistance Markup Language (MAML) schema. These XML files can be included in a module or installed
and updated after the module is installed. This is the only way to provide documentation for cmdlets
in a compiled module.

The MAML format is very flexible and allows you to provide examples and detailed information about
the commands in your module. However, constructing the XML content by hand is difficult and
error-prone.

<!-- link references -->
[01]: images/platypsv1/02-history.png
