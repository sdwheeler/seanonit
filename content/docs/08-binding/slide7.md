---
title: Tracing native command binding
weight: 7
navWeight: 2
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
![Tracing native command binding][05]

Starting in PowerShell 7.3, you can trace the binding of native commands. This feature is useful for
troubleshooting issues with passing parameters native commands in PowerShell. There is no standard
format for passing arguments to native commands. Each command-line tool has its own rules for
parsing parameters and arguments. The way the PowerShell parses the command line is different from
version to version and platform to platform.

The rules for parsing, quoting strings, and escaping characters are complex. For more information,
see:

- [about_Parsing][02]
- [about_Quoting_Rules][03]
- [about_Special_Characters][04]

The output from `Trace-Command` shows how PowerShell parses the command-line arguments for a native
command.

## Parsing command-line arguments for native commands

Older versions of PowerShell you have to use a tool like `echoargs.exe` to see how PowerShell passes
arguments to native commands. You can use the [make-echoargs.ps1][01] script to create the
`echoargs.exe` tool for Windows.

The following examples shows the output from `Trace-Command` followed by the output from `echoargs`.


```powershell
Trace-Command -Name ParameterBinding -Expression {
    echoargs -param this is 'a test' --verbose
} -PSHost -Option ExecutionFlow
```

```Output
DEBUG: 2024-08-09 15:14:09.3088 ParameterBinding Information: 0 : BIND NAMED native application line args [C:\Public\Toolbox\echoargs.exe]
DEBUG: 2024-08-09 15:14:09.3098 ParameterBinding Information: 0 :     BIND cmd line arg [-param] to position [0]
DEBUG: 2024-08-09 15:14:09.3100 ParameterBinding Information: 0 :     BIND cmd line arg [this] to position [1]
DEBUG: 2024-08-09 15:14:09.3102 ParameterBinding Information: 0 :     BIND cmd line arg [is] to position [2]
DEBUG: 2024-08-09 15:14:09.3104 ParameterBinding Information: 0 :     BIND cmd line arg [a test] to position [3]
DEBUG: 2024-08-09 15:14:09.3105 ParameterBinding Information: 0 :     BIND cmd line arg [--verbose] to position [4]
DEBUG: 2024-08-09 15:14:09.3177 ParameterBinding Information: 0 : CALLING BeginProcessing

5 argument(s) received (enclosed in <...> for delineation):

  <-param>
  <this>
  <is>
  <a test>
  <--verbose>
```

<!-- link references -->
[01]: https://github.com/sdwheeler/seanonit/blob/main/content/downloads/binding/make-echoargs.ps1
[02]: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_parsing
[03]: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_quoting_rules
[04]: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_special_characters
[05]: images/binding/slide7.png
