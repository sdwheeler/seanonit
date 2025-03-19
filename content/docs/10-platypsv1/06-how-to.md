---
title: How to create help using PlatyPS v1.0
weight: 6
navWeight: 5
featured: false
draft: false
comment: false
toc: true
pinned: false
postDate: false
date: 2025-03-18
index: true
---
<!-- markdownlint-disable MD041 -->

![How to create help using PlatyPS v1.0][02]

At a high level, the process for creating help using PlatyPS v1.0 is the same as the process used
for the old platyPS.

1. Import the module or commands to be documented
1. Create Markdown files for commands
1. Edit the Markdown files to fill in placeholders
1. Convert Markdown to MAML
1. Publish MAML files

The big difference is that PlatyPS has all new commands and options for each step. The following
code sample shows the process for creating new Help files for a module.

```powershell
<##################################
## Create markdown for a new module
#>
## Step 1: Create Markdown for a new module
Import-Module Microsoft.PowerShell.PlatyPS
$v2path = '.\v2'
$newMarkdownCommandHelpSplat = @{
    ModuleInfo = Get-Module Microsoft.PowerShell.PlatyPS
    OutputFolder = $v2path
    HelpVersion = '1.0.0.0'
    WithModulePage = $true
}
New-MarkdownCommandHelp @newMarkdownCommandHelpSplat

## Step 2: Convert Markdown to MAML
$mdpath = Join-Path $v2path 'Microsoft.PowerShell.PlatyPS'
dir $mdpath -Recurse -Filter *.md |
    Measure-PlatyPSMarkdown |
    Where-Object Filetype -match 'CommandHelp' |
    Import-MarkdownCommandHelp -Path {$_.FilePath} |
    Export-MamlCommandHelp -OutputFolder .\maml -Force -Verbose
```

## List of command in Microsoft.PowerShell.PlatyPS

[Microsoft.PowerShell.PlatyPS documentation][01]

- `Compare-CommandHelp` - Compares two **CommandHelp** objects and produces a detailed report
  showing the differences.
- `Export-MamlCommandHelp` - Exports **CommandHelp** objects to a MAML file.
- `Export-MarkdownCommandHelp` - Exports a **CommandHelp** object to a markdown file.
- `Export-MarkdownModuleFile` - Exports a **ModuleFileInfo** object to a markdown file.
- `Export-YamlCommandHelp` - Exports **CommandHelp** objects to YAML files.
- `Export-YamlModuleFile` - Exports a **ModuleFileInfo** object to a Yaml file.
- `Import-MamlHelp` - Imports MAML help from a file and creates **CommandHelp** objects for each
  command in the file.
- `Import-MarkdownCommandHelp` - Imports Markdown help content into **CommandHelp** objects.
- `Import-MarkdownModuleFile` - Imports a Markdown module file into a **ModuleHelp** object.
- `Import-YamlCommandHelp` - Imports Yaml help content into **CommandHelp** objects.
- `Import-YamlModuleFile` - Imports a Yaml module file into a **ModuleHelp** object.
- `Measure-PlatyPSMarkdown` - Determines the type of Markdown file.
- `New-CommandHelp` - Creates **CommandHelp** objects for a PowerShell command that's loaded in the
  session.
- `New-HelpCabinetFile` - Creates a help cabinet file for a module that can be published as
  updateable help content.
- `New-MarkdownCommandHelp` - Creates Markdown help files for PowerShell modules and commands.
- `New-MarkdownModuleFile` - Creates the Markdown module file for a PowerShell module.
- `Show-HelpPreview` - View MAML file contents as it would appear when output by `Get-Help`.
- `Test-MarkdownCommandHelp` - Tests the structure of a Markdown help file.
- `Update-CommandHelp` - Updates an imported **CommandHelp** object with the information from
  session cmdlet of the same name.
- `Update-MarkdownCommandHelp` - Updates an imported Markdown command file with the information from
  session cmdlet of the same name.
- `Update-MarkdownModuleFile` - Updates the Markdown module file.

<!-- link references -->
[01]: https://learn.microsoft.com/powershell/module/microsoft.powershell.platyps/
[02]: images/platypsv1/06-how-to.png
