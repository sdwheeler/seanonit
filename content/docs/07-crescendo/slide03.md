---
title: How to choose the tool to amplify
weight: 3
navWeight: 10
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
![How to choose the tool to amplify][02]

Typically, the tool you need to work with is directly tied to the technology you are attempting to
automate. This makes the tool choice simple. However, not all tools work the same way. To optimize
your investment when developing a cmdlet, consider the following criteria:

## Command-line tools that make good candidates

- **The original tool is difficult to use.**

  If the tool is simple to use and provides the information you need, there is no need to create a
  cmdlet. Many command-line tools have their own unique syntax, parameters, and output that make it
  difficult to use. Converting a command into a cmdlet provides all the benefits of cmdlet
  discovery, syntax consistency, and structured output as objects.

- **The command-line tool output is difficult to use in automation.**

  Native command-line tools output string data rather than the objects that PowerShell expects in
  the pipeline. Converting that text to objects makes the tool easier to use in automation.

- **The command-line tool doesn't provide adequate help.**

  Command-line tools that lack help information can be difficult to use. Cmdlets can have
  comprehensive help information that includes details on parameters, descriptions, and examples.

## Command-line tools that make bad candidates

- **Does a cmdlet already exist?**

  In many cases, there is already a module that provides cmdlets that replace the need for the
  command-line too. For example, wrapping the Windows command `ipconfig.exe` to get the current IP
  address is a poor choice because the module **NetTCPIP** contains `Get-NetIPConfiguration`, which
  provides the same information with structured output.

- **Are there better ways?**

  Often the information you need for automation can be obtained more easilty than wrapping the
  command-line tool. PowerShell can use other frameworks such as REST APIs, WMI, and .NET to achieve
  the same results.

- **Is the output trivial?**

  In some situations, the command-line tool might produce output that's trivial or easy to use in
  your automation. If this is the case, investing time in creating a cmdlet with structured output
  may not be worth the effort of creating an amplified cmdlet.

## Optimize your time investment by focusing on what you need

You aren't required to replicate all the features of the command-line tool in your amplified cmdlet.
Focus on the features of the tool you need to accomplish your goals. If a tool has 12 use cases and
you only need the functionality of three, don't waste effort on the other nine.

<!-- link references -->
[02]: images/crescendo/slide3.png
