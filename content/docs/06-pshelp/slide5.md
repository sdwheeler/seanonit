---
title: 'Supporting Update-Help'
weight: 5
navWeight: 5
featured: false
draft: false
comment: false
toc: true
pinned: false
postDate: false
index: true
---

![Supporting Update-Help][03]

To support `Update-Help` you must create MAML-based help files for your module. Creating the XML
content is difficult because there are no tools to help you author the content. You must create the
XML by hand.

The PowerShell SDK documentation contains detailed information about the MAML schema and the
requirements of an XML help file. For more information, see
[How to create the cmdlet help file][01].

## Hosting updateable help content

Once you have created the MAML-based content for your module, you must create a downloadable help
package and metadata file. These files must be hosted on a web server that supports the HTTP
protocol.

Help content for a module can consist of multiple files. The files must be packaged in a compressed
archive in CAB or ZIP format. You must also create a HelpInfo XML file that contains metadata about
the downloadable help content. The names of the archive and HelpInfo XML files have specific
requirements. The help system support help content in any language. You must create a separate
archive file for each language that you support. The HelpInfo XML lists the languages available for
download.

For your module to support updateable help, you must set **HelpInfoUri** property of the module
manifest (`.psd1`). The value of this property is the URL to the web folder containing the HelpInfo
XML file.

<!-- link references -->
[01]: https://learn.microsoft.com/powershell/scripting/developer/help/how-to-create-the-cmdlet-help-file
[03]: images/pshelp/slide5.png
