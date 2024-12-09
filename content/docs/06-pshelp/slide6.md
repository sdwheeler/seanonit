---
title: 'Update-Help process'
weight: 6
navWeight: 4
featured: false
draft: false
comment: false
toc: true
pinned: false
postDate: false
date: 2023-08-15
index: true
---

![Update-Help process][02]

## Update-Help Logic flow

1. Get module information from module manifest.

   `Update-Help` collects the following module information:

   ```powershell
   Get-Module ManageIssues | Select-Object HelpInfoUri, Name, Guid
   Get-UICulture
   ```

   ```Output
   HelpInfoUri                                       Name         Guid
   -----------                                       ----         ----
   https://mikefrobbins.github.io/psotr/help/1.0.2/  ManageIssues cd79248e-2d34-4e3b-8014-ab5572b94d42

   LCID             Name             DisplayName
   ----             ----             -----------
   1033             en-US            English (United States)
   ```

   > [!NOTE]
   > The **HelpInfoUri** doesn't point to the HelpInfo XML file, but to a directory that contains
   > the HelpInfo XML file.

1. Construct the download URLs from the module info.

   `Update-Help` uses the module information to construct the full path to the HelpInfo XML file.
   For example:

   ```
   https://mikefrobbins.github.io/psotr/help/1.0.2/ManageIssues_cd79248e-2d34-4e3b-8014-ab5572b94d42_HelpInfo.xml
   ```

1. Download the HelpInfo.xml

   The HelpInfo XML file contains the following information:

   ```xml
   <?xml version="1.0" encoding="utf-8"?>
   <HelpInfo xmlns="http://schemas.microsoft.com/powershell/help/2010/05">
     <HelpContentURI>https://mikefrobbins.github.io/psotr/help/1.0.2/</HelpContentURI>
     <SupportedUICultures>
       <UICulture>
         <UICultureName>en-US</UICultureName>
         <UICultureVersion>1.0.2</UICultureVersion>
       </UICulture>
     </SupportedUICultures>
   </HelpInfo>
   ```

1. Compare local help version to downloaded version.

   If you have previously installed help for the module, `Update-Help` compares version information
   in the local HelpInfo XML file with the downloaded version.

1. If local version is older, download the HelpContent.cab.

   If the local version is older or no help has been downloaded yet, `Update-Help` constructs the
   download URL from the **HelpContentURI** property in the HelpInfo XML file. For example:

   ```
   https://mikefrobbins.github.io/psotr/help/1.0.2/ManageIssues_cd79248e-2d34-4e3b-8014-ab5572b94d42_en-US_HelpContent.cab
   https://mikefrobbins.github.io/psotr/help/1.0.2/ManageIssues_cd79248e-2d34-4e3b-8014-ab5572b94d42_en-US_HelpContent.zip
   ```

   > [!NOTE]
   > Windows PowerShell download CAB files only. PowerShell 7 and higher looks for ZIP files first.
   > If no ZIP file is found, it downloads the CAB file. You must publish both formats to support
   > both versions.

1. Unpack the CAB and install the help files

   Finally, `Update-Help` unpacks the help archive package and installs the help files in the
   appropriate location.

## Important notes

There are several important details to keep in mind when you publish help for your module:

- The URL **HelpInfoUri** must point to a directory that contains the HelpInfo
  XML file and must end with a forward slash (`/`) character.
- The HelpInfo XML file must be named `<ModuleName>_<ModuleGuid>_HelpInfo.xml`.
- The help package files file must be named `<ModuleName>_<ModuleGuid>_<Locale>_HelpContent.cab`.
- Most web services are case sensitive. Therefore, constructed URLs must match the case of the
  directory and file names on the web server.
  - `<ModuleName>` must match the case of the published module
  - `<ModuleGuid>` is all lowercase
  - `<Locale>` uses lowercase language code and uppercase country code, for example `en-US`

<!-- link references -->
[02]: images/pshelp/slide6.png
