---
title: How to create Crescendo objects using the cmdlets
weight: 6
navWeight: 7
featured: false
draft: false
comment: false
toc: true
pinned: false
postDate: false
index: true
---
<!-- markdownlint-disable MD041 -->
![Create Crescendo objects][01]

The **Microsoft.PowerShell.Crescendo** module includes cmdlets that create command, parameter,
example, help, and output handler objects for Crescendo. These objects are then serialized to a JSON
file that is used as the Crescendo definition file.

The following steps show how to create Crescendo objects using the cmdlets.

1. Create a new Crescendo command using the `New-CrescendoCommand` cmdlet. The **Verb** and **Noun**
   parameters are required. The **OriginalName** parameter is optional and is used to specify the
   path to the original command that the Crescendo cmdlet will replace.

   After creating the base command object, you can set additional properties. Some properties are
   optional, while others are required for the configuration to be valid.

   ```powershell
   ## Create Crescendo command and set its properties
   $cmdlet = @{
       Verb = 'Get'
       Noun = 'VssProvider'
       OriginalName = '$env:Windir/system32/vssadmin.exe'
   }
   $newCommand = New-CrescendoCommand @cmdlet
   $newCommand.OriginalCommandElements = @('list','providers')
   $newCommand.Description = 'List registered volume shadow copy providers'
   $newCommand.Platform = @('Windows')
   ```

1. Add some usage information to improve the help for the cmdlet. The **Usage** property is an array
   of **UsageInfo** objects. Each **UsageInfo** object contains a **Syntax** property that describes
   the cmdlet syntax.

   ```powershell
   ## Add usage information to the command
   $newCommand.Usage = New-UsageInfo -usage $newCommand.Description
   ```

   The **Usage** object has other optional properties that you can set. When you export the command,
   Cresendo includes these propties with default values in the JSON file.

1. Add an example that will be included in the help for the cmdlet. Examples are optional. The
   **Examples** property is an array of **ExampleInfo** objects. The **Command** property contains
   the example command with any parameters that you want to demonstrate. The **Description**
   property is a brief description of the example. The **OriginalCommand** property is the original
   command that the Crescendo cmdlet replaced. This information is included in the help for the
   cmdlet.

   ```powershell
   ## Add an example to the command
   $newCommand.Examples = @()
   $example = @{
       Command = 'Get-VssProvider'
       Description = 'Get a list of VSS Providers'
       OriginalCommand = 'vssadmin list providers'
   }
   $newCommand.Examples += New-ExampleInfo @example
   ```

1. Add the output handle definition. The **OutputHandlers** property is an array of
   **OutputHandler** objects. A cmdlet can have multiple output handlers to support multiple
   parameter sets. The `New-OutputHandler` cmdlet creates an empty **OutputHandler** object. You
   need to provide values for the required properties.

   ```powershell
   ### Add an Output Handler to the command
   $newCommand.OutputHandlers = @()
   $newCommand.OutputHandlers += New-OutputHandler
   $newCommand.OutputHandlers[-1].ParameterSetName = 'Default'
   $newCommand.OutputHandlers[-1].HandlerType = 'Function'
   $newCommand.OutputHandlers[-1].Handler = 'ParseProvider'
   ```

1. Export the command object to a JSON file. The `Export-CrescendoCommand` cmdlet serializes the
   command object to a JSON file. The **Path** parameter specifies the path to the JSON file.

   ```powershell
   ## Export the command to a JSON file
   Export-CrescendoCommand -Command $newCommand -Path .\Get-VssProvider.json
   ```

   The `Get-VssProvider.json` file contains the following JSON definition:

   ```json
   {
     "$schema": "https://aka.ms/PowerShell/Crescendo/Schemas/2022-06",
     "commands": [
       {
         "Verb": "Get",
         "Noun": "VssProvider",
         "OriginalName": "$env:Windir/system32/vssadmin.exe",
         "OriginalCommandElements": [
           "list",
           "providers"
         ],
         "Platform": [
           "Windows"
         ],
         "SupportsShouldProcess": false,
         "SupportsTransactions": false,
         "NoInvocation": false,
         "Description": "List registered volume shadow copy providers",
         "Usage": {
           "Synopsis": "List registered volume shadow copy providers",
           "SupportsFlags": false,
           "HasOptions": false
         },
         "Parameters": [],
         "Examples": [
           {
             "Command": "Get-VssProvider",
             "OriginalCommand": "vssadmin list providers",
             "Description": "Get a list of VSS Providers"
           }
         ],
         "OutputHandlers": [
           {
             "ParameterSetName": "Default",
             "Handler": "ParseProvider",
             "HandlerType": "Function",
             "StreamOutput": false
           }
         ]
       }
     ]
   }
   ```

<!-- link references -->
[01]: images/crescendo/slide6.png
