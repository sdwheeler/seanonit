---
title: Parameter binding
weight: 4
navWeight: 5
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

![Parameter binding][03]

Parameter binding is the process that PowerShell uses to associate (bind) input values to the
parameters of a command. The input values can come from the command line and the pipeline.

It's like filling in the blanks in a form, like the one shown in the slide. On Windows (only), the
`Show-Command` cmdlet presents a form that you can use to fill in parameter values. The form shows a
tab for each parameter set. If fill in the form and select **Run**, PowerShell runs the command with
the values you provided. If you select **Copy**, PowerShell copies the command to the clipboard. You
can then paste the command into a script or the console.

## Related links

- [about_Parameter_Binding][01]
- [Show-Command][02]

<!-- link references -->
[01]: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_parameter_binding
[02]: https://learn.microsoft.com/powershell/module/microsoft.powershell.utility/show-command
[03]: images/binding/slide4.png
