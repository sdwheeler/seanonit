---
title: 'Command syntax'
weight: 2
navWeight: 7
featured: false
draft: false
comment: false
toc: true
pinned: false
postDate: false
date: 2024-08-09
index: true
---
<!-- markdownlint-disable MD041 -->
![Command syntax][04]

Before you can understand how parameter binding works, you need to understand how to interpret
command syntax.The `Get-Help` and `Get-Command` cmdlets display syntax diagrams to help you
use commands correctly.

```powershell
Get-Help Get-Command
```

```Output
NAME
    Get-Command

SYNOPSIS
    Gets all commands.

SYNTAX
    Get-Command [[-Name] <System.String[]>] [[-ArgumentList] <System.Object[]>] [-All]
    [-CommandType {Alias | Function | Filter | Cmdlet | ExternalScript | Application |
    Script | Workflow | Configuration | All}] [-FullyQualifiedModule
    <Microsoft.PowerShell.Commands.ModuleSpecification[]>] [-ListImported] [-Module
    <System.String[]>] [-ParameterName <System.String[]>] [-ParameterType
    <System.Management.Automation.PSTypeName[]>] [-ShowCommandInfo] [-Syntax]
    [-TotalCount <System.Int32>] [-UseAbbreviationExpansion] [-UseFuzzyMatching]
    [<CommonParameters>]

    Get-Command [[-ArgumentList] <System.Object[]>] [-All] [-FullyQualifiedModule
    <Microsoft.PowerShell.Commands.ModuleSpecification[]>] [-ListImported] [-Module
    <System.String[]>] [-Noun <System.String[]>] [-ParameterName <System.String[]>]
    [-ParameterType <System.Management.Automation.PSTypeName[]>] [-ShowCommandInfo]
    [-Syntax] [-TotalCount <System.Int32>] [-Verb <System.String[]>] [<CommonParameters>]
```

Notice the differences between the output from the two commands. `Get-Help` displays show full type
names, while `Get-Command` shows only short type names. The `Get-Help` output also shows possible
values for some parameters.

```powershell
Get-Command Get-Command -Syntax
```

```Output
Get-Command [[-ArgumentList] <Object[]>] [-Verb <string[]>] [-Noun <string[]>]
[-Module <string[]>] [-FullyQualifiedModule <ModuleSpecification[]>]
[-TotalCount <int>] [-Syntax] [-ShowCommandInfo] [-All] [-ListImported]
[-ParameterName <string[]>] [-ParameterType <PSTypeName[]>]
[<CommonParameters>]

Get-Command [[-Name] <string[]>] [[-ArgumentList] <Object[]>]
[-Module <string[]>] [-FullyQualifiedModule <ModuleSpecification[]>]
[-CommandType <CommandTypes>] [-TotalCount <int>] [-Syntax] [-ShowCommandInfo]
[-All] [-ListImported] [-ParameterName <string[]>]
[-ParameterType <PSTypeName[]>] [-UseFuzzyMatching]
[-FuzzyMinimumDistance <uint>] [-UseAbbreviationExpansion]
[<CommonParameters>]
```

## Symbols in Syntax Diagrams

The syntax diagram lists the command name, the command parameters, and the parameter values.

The syntax diagrams use the following symbols:

- A hyphen `-` indicates a parameter name. In a command, type the hyphen immediately before the
  parameter name with no intervening spaces, as shown in the syntax diagram.

<!-- `< >` - also known as chi-hua-huas -->
- Angle brackets `< >` indicate placeholder text. You don't type the angle brackets or the
  placeholder text in a command. Instead, you replace it with the item that it describes.

  The placeholder inside the angle brackets identifies the .NET type of the value that a parameter
  takes. For example, to use the **Name** parameter of `Get-Command`, replace the `<string[]>` with
  one or more strings separated by commas (`,`).

<!-- `[]` - also known as binkies -->
- Brackets `[]` inside of the angle brackets indicate that the parameter can accept one or more
  values of that type. Enter the values as a comma-separated list.

- Parameters with no values

  Some parameters don't accept input, so they don't have a parameter value. Parameters without
  values are _switch parameters_. Switch parameters are used like boolean values. They default to
  `$false`. When you use a switch parameter, the value is set to `$true`.

<!-- So what are these `[    ]`? - square brackets, duh! -->
- Brackets `[  ]` around parameters indicate optional items. A parameter and its value can be
  optional. For example, the **CommandType** parameter of `Get-Command` and its value are enclosed
  in brackets because they're both optional.

- Braces `{}` indicate an _enumeration_, which is a set of valid values for a parameter.

  The values in the braces are separated by vertical bars `|`. These bars indicate an _exclusive-OR_
  choice, meaning that you can choose only one value from the set of values that are listed inside
  the braces. For example, the **CommandType** parameter of `Get-Command` has a list of possible
  values in braces.

## Related links

- [about_Command_Syntax][01]
- [Get-Command][02]
- [Get-Help][03]

<!-- link references -->
[01]: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_command_syntax
[02]: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/get-command
[03]: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/get-help
[04]: images/binding/slide2.png
