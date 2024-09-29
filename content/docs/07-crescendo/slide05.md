---
title: How to create a Crescendo definition file
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
![Create a Crescendo cmdlet definition][01]

After you have researched the tool's syntax and output and created parsers for the output, you can
create a Crescendo configuration. A Crescendo configuration describes a new cmdlet. The cmdlet
definition includes:

- The `Verb-Noun` name of the new cmdlet
- The parameters used by the cmdlet
- The location of the original command-line tool
- The subcommands and parameters passed to the command-line tool
- The output handler that parses the output of the command-line tool

The configuration is stored as a JSON file. Crescendo uses the configuration file to create proxy
cmdlets that call the original command-line tool. Crescendo exports the configuration as a
PowerShell script module file and manifest that's ready to deploy.

There are two ways to create a Crescendo definition file:

1. The **Microsoft.PowerShell.Crescendo** module includes cmdlets that create command, parameter,
   example, help, and output handler objects for Crescendo.

   - `New-CrescendoCommand`
   - `New-ExampleInfo`
   - `New-OutputHandler`
   - `New-ParameterInfo`
   - `New-UsageInfo`

   These objects are then serialized to a JSON file that's used as the Crescendo definition file
   using the `Export-CrescendoModule` command.

1. You can manually create a JSON file that describes the cmdlet syntax and parameters. Crescendo
   includes a JSON schema file that enables IntelliSense in Visual Studio Code and ensures that the
   JSON file is correctly structured.

   Use the following JSON template to create a new Crescendo definition file:

   ```json
   {
       "$schema": "https://aka.ms/PowerShell/Crescendo/Schemas/2022-06",
       "commands": [

       ]
   }
   ```

<!-- link references -->
[01]: images/crescendo/slide5.png
