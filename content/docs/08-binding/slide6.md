---
title: Order of operations
weight: 6
navWeight: 3
featured: false
draft: false
comment: false
toc: true
pinned: false
postDate: false
index: true
---
<!-- markdownlint-disable MD041 -->
![Order of operations][04]

First, PowerShell binds command-line arguments in the following order:

1. Values for named parameters
1. Values for positional parameters
1. Values from the remaining arguments

After command-line arguments, PowerShell tries to bind pipeline input:

1. Match values by type to parameters that use **ValueFromPipeline**
1. Match values by name to parameters that use **ValueFromPipelineByPropertyName**

After binding all input, PowerShell calls the command with the bound parameters. The command outputs
an error if it can't determine which parameter set is being used.

## Trace-Command

`Trace-Command` is a great troubleshooting tool that helps you understand how PowerShell works
internally. Use the `Get-TraceSource` command to see the available trace providers.

- Enables and displays trace events for a single scriptblock
- You can trace the following events from any of the 36 providers
  - ExecutionFlow: Constructor, Dispose, Finalizer, Method, Delegates, Events, Scope
  - Data: Constructor, Dispose, Finalizer, Property, Verbose, WriteLine
  - Errors: Error, Exception

## Related links

- [Trace-Command][02]
- [Get-TraceSource][01]
- [Visualize parameter binding][03]

<!-- link references -->
[01]: https://learn.microsoft.com/powershell/module/microsoft.powershell.utility/get-tracesource
[02]: https://learn.microsoft.com/powershell/module/microsoft.powershell.utility/trace-command
[03]: https://learn.microsoft.com/powershell/scripting/learn/deep-dives/visualize-parameter-binding
[04]: images/binding/slide6.png
