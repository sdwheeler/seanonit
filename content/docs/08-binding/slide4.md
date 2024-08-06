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
index: true
---
<!-- markdownlint-disable MD041 -->

![Parameter binding][02]

- Parameter binding is the process that PowerShell uses to determine which parameter set is being
  used and to associate (bind) values to the parameters of a command. These values can come from the
  command line and the pipeline.
- The parameter binding process starts by binding named and positional command-line arguments. After
  binding command-line arguments, PowerShell tries to bind any pipeline input.

## Related links

- [about_Parameter_Binding][01]

<!-- link references -->
[01]: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_parameter_binding
[02]: images/binding/slide4.png
