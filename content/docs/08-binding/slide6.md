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
![Order of operations][05]

## Binding order

First, PowerShell binds command-line arguments in the following order:

1. Named parameters
1. Positional parameters
1. **ValueFromRemainingArguments** parameters

After command-line arguments, PowerShell tries to bind pipeline input:

1. Match values by type to parameters that use **ValueFromPipeline**
1. Match values by name to parameters that use **ValueFromPipelineByPropertyName**

After binding all input, PowerShell calls the command with the bound parameters. The command outputs
an error if it can't determine which parameter set is being used.

## $PSBoundParameters

This automatic variable contains a dictionary of the parameters and the values that were bound to
them. The parameter names are the keys, and the argument values are the values. If a parameter
wasn't bound, it isn't in the dictionary.

This variable has a value only in a scope where parameters are declared, such as a script or
function. You can use it to determine which parameters were bound, display or change the values that
were bound, and to pass parameter values to another script or function.

## Trace-Command

`Trace-Command` is a great troubleshooting tool that helps you understand how PowerShell works
internally. Use the `Get-TraceSource` command to see the available trace providers.

- Enables and displays trace events for a single scriptblock
- You can trace the following events from any of the 36 providers
  - ExecutionFlow: Constructor, Dispose, Finalizer, Method, Delegates, Events, Scope
  - Data: Constructor, Dispose, Finalizer, Property, Verbose, WriteLine
  - Errors: Error, Exception

## Demo

In the [demo script][01], I show you how to use `Trace-Command` to see the parameter binding process
in action and compare the trace information to the results in `$PSBoundParameters`.

## Related links

- [Trace-Command][03]
- [Get-TraceSource][02]
- [Visualize parameter binding][04]

<!-- link references -->
[01]: https://github.com/sdwheeler/seanonit/blob/main/content/downloads/binding/binding.ps1
[02]: https://learn.microsoft.com/powershell/module/microsoft.powershell.utility/get-tracesource
[03]: https://learn.microsoft.com/powershell/module/microsoft.powershell.utility/trace-command
[04]: https://learn.microsoft.com/powershell/scripting/learn/deep-dives/visualize-parameter-binding
[05]: images/binding/slide6.png
