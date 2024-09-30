---
title: How to build and publish a Crescendo module
weight: 8
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
![Build and publish a Crescendo module.][01]

Once you have created your Crescendo configuration JSON file you are ready to create the module you
defined. The `Export-CrescendoModule` command reads the JSON file and generates a module file
(`.PSM1`) and a module manifest (`.PSD1`).

The following example export the modules from a single JSON file that contains definitions for all
your cmdlets.

```powershell
PS> Export-CrescendoModule -ModuleName .\out\PSVssAdmin -ConfigurationFile .\PSVssAdmin.Crescendo.json
PS> dir .\out

    Directory: D:\Git\My-Repos\ToolModules\Modules\VssAdmin\Examples\AsScripts\out

Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a---           9/27/2024  3:07 PM           1526 ParseProvider.ps1
-a---           9/27/2024  3:07 PM            410 ParseResizeShadowStorage.ps1
-a---           9/27/2024  3:07 PM           2754 ParseShadow.ps1
-a---           9/27/2024  3:07 PM           1786 ParseShadowStorage.ps1
-a---           9/27/2024  3:07 PM           1102 ParseVolume.ps1
-a---           9/27/2024  3:07 PM           1428 ParseWriter.ps1
-a---           9/27/2024  3:32 PM           4452 PSVssAdmin.psd1
-a---           9/27/2024  3:32 PM          38489 PSVssAdmin.psm1
```

If you have defined the type of your output handlers as `Script`, `Export-CrescendoModule` copies
the script files to the same output location as the module files. If you have defined the output
handler type as `Function`, the functions are included in the `.PSM1` file as private functions.

The following example exports the modules from multiple JSON files, each one containing a single
cmdlet definition. This example also uses function-type output handlers. When using function-type
output handlers, the functions must be loaded in the session before you export the module.

```powershell
PS> . .\vssparsers.ps1
PS> Export-CrescendoModule -ModuleName .\out\PSVssAdmin -ConfigurationFile *.json -Force
PS> dir .\out

    Directory: D:\Git\My-Repos\ToolModules\Modules\VssAdmin\Examples\AsFunctions\out

Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a---           9/27/2024  3:49 PM           4452 PSVssAdmin.psd1
-a---           9/27/2024  3:49 PM          47635 PSVssAdmin.psm1
```

## Publishing your module

Before you publish your module (or share it with others), you should edit the module manifest to set
the version number and add any other metadata that's required to publish to the **PowerShell
Gallery**.

See the _Required Metadata for Items Published to the PowerShell Gallery_ section of
[Creating and publishing an item](https://learn.microsoft.com/powershell/gallery/how-to/publishing-packages/publishing-a-package#required-metadata-for-items-published-to-the-powershell-gallery).

### Updating your module

You should never try to edit the module (`.PSM1`) file created by Crescendo. If you need to make
changes, edit the source files and configurations, then re-export the module.

> [!WARNING]
> By default, `Export-CrescendoModule` recreates the module manifest. Any custom changes you have
> made to the manifest will be lost. You can use the **NoClobberManifest** parameter to prevent
> overwriting the manifest. However, if you have added new cmdlets, you will need to add them to the
> manifest manually.

## Finding Crescendo modules

Crescendo adds some Crescendo specific metadata to the module manifest.

```powershell
PS> (Get-Module PSVssAdmin).PrivateData

Name                           Value
----                           -----
CrescendoVersion               1.1.0
CrescendoGenerated             09/27/2024 15:49:33
PSData                         {[Tags, CrescendoBuilt]}
```

You can use the `CrescendoBuilt` tag to search for Crescendo modules in the **PowerShell Gallery**.

```powershell
PS> Find-PSResource -Tag CrescendoBuilt

Name               Version Prerelease Repository Description
----               ------- ---------- ---------- -----------
VssAdmin           0.8.0              PSGallery  This is a Crescendo module to wrap the Windows `vssadmin.exe` command…
TShark             1.0.2              PSGallery  PowerShell cmdlet for tshark.exe
Takeown            1.0.2              PSGallery  Crescendo Powershell wrapper of takeown.exe
SysInternals       1.1.0              PSGallery  PowerShell cmdlets for SysInternal tools
SpeedTest-CLI      1.0.1              PSGallery  PowerShell cmdlets for Internet Speed Test
SpeedTestCLI       1.0.0              PSGallery  PowerShell cmdlets speedtest-cli
RoboCopy           1.0.1              PSGallery  PowerShell cmdlet for the official RoboCopy.exe
Quser.Crescendo    0.1.3              PSGallery  This module displays session information of users logged onto a local…
PSLogParser        0.0.2              PSGallery  Crescendo Powershell module for Log Parser 2.2
psFilesCli         0.1.2              PSGallery  A PowerShell wrapper for files-cli.exe
PSDupes            0.0.1              PSGallery  A crescendo module to locate duplicate files. Very fast and easy to u…
PSConfig.Crescendo 0.2.0              PSGallery  PowerShell cmdlets for SharePoint PSConfig tool wrapped with MS Cresc…
pastel             1.0.1              PSGallery  PowerShell commands for pastel
Minizinc           0.0.3              PSGallery  Powershell Crescendo limited wrapper for minizinc
Image2Text         1.0.2              PSGallery  PowerShell Images into ASCII art
Foil               0.3.1              PSGallery  A PowerShell Crescendo wrapper for Chocolatey
Croze              0.1.2              PSGallery  A PowerShell Crescendo wrapper for Homebrew
Cobalt             0.4.0              PSGallery  A PowerShell Crescendo wrapper for WinGet
AptPackage         0.0.2              PSGallery  PowerShell Crescendo-generated Module to query APT-Package Information
```

<!-- link references -->
[01]: images/crescendo/slide8.png
