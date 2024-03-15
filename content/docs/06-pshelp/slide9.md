---
title: 'PlatyPS Workflow'
weight: 9
navWeight: 1
featured: false
draft: false
comment: false
toc: true
pinned: false
postDate: false
index: true
---

![PlatyPS Workflow][03]

1. Import the module being documented

   ```powershell
   Import-Module .\ManageIssues.psd1
   ```

1. Create new markdown files (cmdlet and module)

   ```powershell
   $newMarkdownHelpSplat = @{
       Module = 'ManageIssues'
       AlphabeticParamsOrder = $true
       UseFullTypeName = $true
       OutputFolder = '.\docs'
       WithModulePage = $true
   }
   New-MarkdownHelp @newMarkdownHelpSplat
   ```

   PlatyPS creates placeholders for you to fill in metadata, descriptions, and examples. The
   PowerShell help system also allows for plain-text conceptual help files (about topics). PlatyPS
   includes the `New-MarkdownAboutHelp` cmdlet to create a structured Markdown template for a new
   about file, but you must convert the markdown to `about_*.help.txt` files manually.

1. Edit markdown files to add descriptions, examples, links, notes, etc.

   Metadata in `<Module>.md` and `<Cmdlet-Name>.md` files is used when compiling the MAML files. The
   markdown files aren't used directly by the help system. It's important that the metadata is
   correct for the help system to work properly.

1. Compile markdown into MAML

   ```powershell
   $newExternalHelpSplat = @{
       Path = '.\docs'
       OutputPath = '.\help'
   }
   New-ExternalHelp @newExternalHelpSplat
   ```

1. Test the MAML

   ```powershell
   Get-HelpPreview -Path .\help\ManageIssues-help.xml
   ```

1. Create the module help CAB/ZIP and HelpInfo XML files.

   ```powershell
   mkdir .\help\cab
   $newExternalHelpCabSplat = @{
       CabFilesFolder = '.\help'
       LandingPagePath = '.\docs\ManageIssues.md'
       OutputFolder = '.\help\cab'
   }
   New-ExternalHelpCab @newExternalHelpCabSplat
   ```

   The **CabFilesFolder** location must contain the MAML files and any `about_*.help.txt` files that
   you want to publish for the module. For a script-based module, there is usually only one MAML
   file. However, if your module contains submodules or has cmdlets in compiled assemblies, there
   will be multiple MAML files.

1. Publish CAB and XML to web service

   Copy the files to the web server.

For more information, see [Create XML-based help using PlatyPS][01].

[Previous][02]

<!-- link references -->
[01]: https://learn.microsoft.com/powershell/utility-modules/platyps/create-help-using-platyps
[02]: ../slide8
[03]: images/pshelp/slide9.png
