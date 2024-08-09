---
title: Parameter attributes
weight: 5
navWeight: 4
featured: false
draft: false
comment: false
toc: true
pinned: false
postDate: false
index: true
---
<!-- markdownlint-disable MD041 -->
![Parameter attributes][02]

The `Get-Help` command tells you if a parameter accepts pipeline input or from remaining arguments.
You can also use `Get-Command` to inspect the attributes of a parameter.

First, let's look at the properties of the **Path** parameter of the **Remove-Item** command.

```powershell
(Get-Command Remove-Item).Parameters['Path']
```

From the output, you can see that the parameter belongs to the **Path** parameter set, accepts one
or more strings, and doesn't have any aliases.

```Output
Name            : Path
ParameterType   : System.String[]
ParameterSets   : {[Path, System.Management.Automation.ParameterSetMetadata]}
IsDynamic       : False
Aliases         : {}
Attributes      : {Path}
SwitchParameter : False
```

By inspecting the **Attributes** property, you can see that the **Path** parameter is mandatory and
accepts values from the pipeline by value or property name.

```powershell
(Get-Command Remove-Item).Parameters['Path'].Attributes
```

```Output
Position                        : 0
ParameterSetName                : Path
Mandatory                       : True
ValueFromPipeline               : True
ValueFromPipelineByPropertyName : True
ValueFromRemainingArguments     : False
HelpMessage                     :
HelpMessageBaseName             :
HelpMessageResourceId           :
DontShow                        : False
TypeId                          : System.Management.Automation.ParameterAttribute
```

Next, let's compare that to the **LiteralPath** parameter. This parameter belongs to the
**LiteralPath** parameter set, accepts one or more strings, and has an alias of **PSPath**.

```powershell
(Get-Command Remove-Item).Parameters['LiteralPath']
```

```Output
Name            : LiteralPath
ParameterType   : System.String[]
ParameterSets   : {[LiteralPath, System.Management.Automation.ParameterSetMetadata]}
IsDynamic       : False
Aliases         : {PSPath}
Attributes      : {LiteralPath, System.Management.Automation.AliasAttribute}
SwitchParameter : False
```

By inspecting the **Attributes** property, you can see that the **LiteralPath** parameter is
mandatory and accepts values from the pipeline by property name.

```powershell
(Get-Command Remove-Item).Parameters['LiteralPath'].Attributes
```

```Output
Position                        : -2147483648
ParameterSetName                : LiteralPath
Mandatory                       : True
ValueFromPipeline               : False
ValueFromPipelineByPropertyName : True
ValueFromRemainingArguments     : False
HelpMessage                     :
HelpMessageBaseName             :
HelpMessageResourceId           :
DontShow                        : False
TypeId                          : System.Management.Automation.ParameterAttribute

AliasNames : {PSPath}
TypeId     : System.Management.Automation.AliasAttribute
```

## Related links

- [about_Functions_Advanced_Parameters][01]

<!-- link references -->
[01]: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_functions_advanced_parameters#attributes-of-parameters
[02]: images/binding/slide5.png
