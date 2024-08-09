---
title: Parameter sets
weight: 3
navWeight: 6
featured: false
draft: false
comment: false
toc: true
pinned: false
postDate: false
index: true
---
<!-- markdownlint-disable MD041 -->

![Parameter sets][02]

PowerShell uses parameter sets to allow a single command to accept varied input and, potentially,
produce different output based on the input. Parameter sets are similar to function overloading in
other programming languages, like C#.

## Parameter set requirements

- There is a limit of 32 parameter sets.
- Each parameter set must have at least one unique parameter. If possible, make this parameter a
  mandatory parameter. However, the unique parameter can't be mandatory if the cmdlet is designed to
  run without any parameters.
- A parameter set that contains multiple positional parameters must define unique positions for each
  parameter. No two positional parameters can specify the same position.
- Only one parameter in a set can have the **ValueFromPipeline** attribute. Multiple parameters can
  have the **ValueFromPipelineByPropertyName** attribute.
- If no parameter set is specified for a parameter, the parameter belongs to all parameter sets.

### Default parameter set

The PowerShell runtime uses the unique parameter to determine which parameter set is being used.
PowerShell uses the default parameter set if it can't determine the parameter set to use based on
the information provided by the command. The default parameter set is defined by setting the
`DefaultParameterSetName` property of the `[CmdletBinding()]` attribute. You can avoid the need to
define a default by making the unique parameter of each parameter set a mandatory parameter.

## Related links

- [about_Parameter_Sets][01]

<!-- link references -->
[01]: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_parameter_sets
[02]: images/binding/slide3.png
