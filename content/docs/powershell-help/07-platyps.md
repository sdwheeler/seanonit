---
title: PlatyPS - A tool for PowerShell MAML
weight: 8
navWeight: 2
featured: false
draft: false
comment: false
toc: true
pinned: false
postDate: false
date: 2026-03-23
index: true
---

![PlatyPS or strange mammal?][03]

Q: What does that have to do with a platypus?

A: A platypus is a strange looking mammal - PowerShell help is a strange looking MAML.

**The Problem:**

- Hand-crafting the XML MAML files is tedious and error-prone
- Documentation for the MAML format is limited and no longer supported
- Getting the details right can be difficult

**The Solution:**

**Microsoft.PowerShell.PlatyPS** (PlatyPS) is a PowerShell module that makes the creation and
maintenance of MAML easier. You don't have to create the content in the MAML XML format.

PlatyPS creates a Markdown template for each command exported from your module. Using .NET
reflection, PlatyPS documents the syntax of parameter sets and the individual parameters for each
cmdlet in your module. For script-based modules, PlatyPS can use your comment-based help content to
fill in the descriptions for the cmdlet, parameters, and examples. For compiled modules, you can use
PlatyPS inserts placeholders for you to fill in the descriptions and examples.

The Markdown files are easier to edit and maintain than the MAML XML files. You must fill in
descriptions, examples, and other placeholder information. After editing the Markdown, PlatyPS
compiles the Markdown files into MAML files.

You can include the MAML help files with your module or you can use PlatyPS to create the necessary
metadata and package files to host the MAML files for updateable help.

For more information, see:

- [PlatyPS overview][02] in the documentation
- [What's new in PlatyPS][01]

<!-- link references -->
[01]: ../../10-platypsv1/ "What's new in PlatyPS"
[02]: https://learn.microsoft.com/powershell/utility-modules/platyps/overview
[03]: images/powershell-help/07-platyps.png
