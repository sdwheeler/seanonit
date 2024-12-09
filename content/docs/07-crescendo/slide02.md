---
title: What is PowerShell Crescendo?
weight: 2
navWeight: 11
featured: false
draft: false
comment: false
toc: true
pinned: false
postDate: false
date: 2021-11-09
index: true
---
<!-- markdownlint-disable MD041 -->
![What is PowerShell Crescendo?][01]

PowerShell Crescendo is a framework for creating PowerShell cmdlets that amplify command-line tools,
regardless of platform. The goal of a Crescendo-based module is to create PowerShell cmdlets that
use a command-line tool and, unlike that tool, return PowerShell objects instead of plain text.

## Crescendo-specific terminology

Before we go further, let's define some terms used in this presentation:

- A **Command-line tool** is a native executable file installed on your system.

  For example: `ipconfig.exe`

- A **Command** is what you enter on the command line to invoke the executable. The command might
  include parameters and arguments.

  For example: `ipconfig.exe /all`

- An **amplified command** is the cmdlet you created with Crescendo to wrap a command-line tool in a
  PowerShell function. This cmdlet improves the command-line experience by providing:

  - A familiar `Verb-Noun` command name
  - Consistent parameter syntax
  - Help documentation
  - Access PowerShell tab completion
  - Objects-based output for further processing in the PowerShell pipeline

  For example: `Get-IpConfig -All`

## How Crescendo works

The **Microsoft.PowerShell.Crescendo** module has cmdlets to help you create configurations and
build the module that provides the _amplified_ command-line experience.

A Crescendo-based module is built from two main components:

- A JSON configuration file that describes the cmdlets you want
- Output handler functions that parse the output from the command-line tool and return objects

You must create the JSON file and write the output handler functions that return PowerShell objects.

**Q: Can't I just write a PowerShell script that wraps the command-line tool without using
Crescendo?**

**A: Yes! But...**

You have to do the same amount work anyway. The benefit of Crescendo is that it provides a
standardized approach to how you construct your cmdlets. As with any framework, there are trade-offs
between flexibility and ease of use. You must weigh the benefits of using Crescendo against the overhead
associated with the requirements of the framework.

<!-- link references -->
[01]: images/crescendo/slide2.png
