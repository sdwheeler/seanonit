---
title: 'Supporting -Online'
weight: 4
navWeight: 6
featured: false
draft: false
comment: false
toc: true
pinned: false
postDate: false
index: true
---

![Supporting -Online][04]

To support the **Online** parameter of `Get-Help` you need to defined by the **HelpUri** property of
the `CmdletBinding()` attribute for your function. The value of this property is a URL that points
to the webpage containing the documentation. If you create MAML-based help, it also needs to be
added to the XML file.

## Examples

Script-based example:

```powershell
function Verb-Noun
{
    [CmdletBinding(HelpURI=<URI>)]

    Param ($Parameter1)
    Begin{}
    Process{}
    End{}
}
```

C# example for a compiled cmdlet:

```csharp
[Cmdlet(VerbsCommunications.Write, "Output",
        HelpUri = "https://go.microsoft.com/fwlink/?LinkID=2097117",
        RemotingCapability = RemotingCapability.None)]
public sealed class WriteOutputCommand : PSCmdlet
{
    ...
}
```

For more information, see the following articles:

- [about_Functions_CmdletBindingAttribute][02]
- [CmdletBindingAttribute Class][01]

<!-- link references -->
[01]: https://learn.microsoft.com/dotnet/api/system.management.automation.cmdletbindingattribute
[02]: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_functions_cmdletbindingattribute
[04]: images/pshelp/slide4.png
