---
title: 'Sources of help'
weight: 2
navWeight: 8
featured: false
draft: false
comment: false
toc: true
pinned: false
postDate: false
index: true
---

![Sources of help][03]

The PowerShell Help system is similar to man pages in Unix. It provides a way to get information
about commands and concepts. PowerShell can display help content from three different sources:

- .NET reflection
- Comment-based help
- MAML-based help

The sources are listed in order of precedence. Comment-based help overrides .NET reflection.
MAML-based help overrides both .NET reflection and comment-based help.

## .NET reflection

Using .NET Reflection, PowerShell can extract information about the command syntax, parameters, and
return values for cmdlets, scripts, and functions. This is the help content displayed when no other
help content is available.

## Comment-based help for scripts

For functions in script-based modules and script files, PowerShell can extract help content from
specially formatted comments.

For more information see [about Comment Based Help][01].

## MAML-based help

The PowerShell help system can display help content stored in XML file using the Microsoft
Assistance Markup Language (MAML) schema. These XML files can be included in a module or installed
and updated after the module is installed. This is the only way to provide documentation for cmdlets
in a compiled module.

The MAML format is very flexible and allows you to provide detailed information and example about
the commands in your module. However, constructing the XML content by hand can be tedious and
error-prone.

<!-- link references -->
[01]: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_comment_based_help
[03]: images/pshelp/slide2.png
