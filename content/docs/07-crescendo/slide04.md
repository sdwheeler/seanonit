---
title: Research the tool's syntax and output
weight: 4
navWeight: 9
featured: false
draft: false
comment: false
toc: true
pinned: false
postDate: false
date: 2021-11-09
index: true
---
<!-- markdownlint-disable MD041 -->
![Research the tool's syntax and output][01]

## Start with command-line help and documentation

Many command-line tools include an option to display help content. Most modern command-line tools
provide multiple levels of help for the various use-case scenarios the tool provides. For example,
running `vssadmin.exe /?` displays the top-level help, which contains a list of subcommands.

```powershell
PS> vssadmin /?
vssadmin 1.1 - Volume Shadow Copy Service administrative command-line tool
(C) Copyright 2001-2013 Microsoft Corp.

---- Commands Supported ----

Delete Shadows        - Delete volume shadow copies
List Providers        - List registered volume shadow copy providers
List Shadows          - List existing volume shadow copies
List ShadowStorage    - List volume shadow copy storage associations
List Volumes          - List volumes eligible for shadow copies
List Writers          - List subscribed volume shadow copy writers
Resize ShadowStorage  - Resize a volume shadow copy storage association
```

Each of the subcommands might have their own subcommands and parameters. For example, the
`List Shadows` subcommand has three possible parameters.

```powershell
PS> vssadmin List Shadows /?
vssadmin 1.1 - Volume Shadow Copy Service administrative command-line tool
(C) Copyright 2001-2013 Microsoft Corp.

List Shadows [/For=ForVolumeSpec] [/Shadow=ShadowId|/Set=ShadowSetId]
    - Displays existing shadow copies on the system.  Without any options,
    all shadow copies on the system are displayed ordered by shadow copy set.
    Combinations of options can be used to refine the list operation.
    - The Shadow Copy ID can be obtained by using the List Shadows command.
    When entering a Shadow ID, it must be in
    the following format:
       {XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX}
    where the X's are hexadecimal characters.

    Example Usage:  vssadmin List Shadows
                             /Shadow={c5946237-af12-3f23-af80-51aadb3b20d5}
```

Use the command-line help to discover the possible use cases. You can redirect the output of each
help command to a file that you can use for later reference as you create your Crescendo cmdlets.

## Capture example output for parsing

Once you have decided which of the tool's commands to amplify, collect sample output from those
commands. Redirect the output to a file for each command. Use this example data to help you design
the output handlers (parsers) for your Crescendo cmdlets.

> [!TIP]
> Take note of the output formats that the command-line tool offers. Some command-line tools can
> output information in formats such as CSV or JSON. These structured formats are easily converted
> to PowerShell objects.

Here is an example of the output from the `vssadmin List Shadows` command. Notice that the output is
well-formatted and contains markers that separate the data fields. Those markers can be used to
parse the information as you construct your objects for output.

```powershell
PS> vssadmin List Shadows
vssadmin 1.1 - Volume Shadow Copy Service administrative command-line tool
(C) Copyright 2001-2013 Microsoft Corp.

Contents of shadow copy set ID: {43dd2d4b-3a58-487a-842d-564143d0501f}
   Contained 1 shadow copies at creation time: 9/10/2021 5:49:26 PM
      Shadow Copy ID: {eef18c41-c6bc-40bb-9863-5491249d2458}
         Original Volume: (C:)\\?\Volume{67a44989-8413-4a7c-a616-79385dae8605}\
         Shadow Copy Volume: \\?\GLOBALROOT\Device\HarddiskVolumeShadowCopy3
         Originating Machine: ampersand.redmond.corp.microsoft.com
         Service Machine: ampersand.redmond.corp.microsoft.com
         Provider: 'Microsoft Software Shadow Copy provider 1.0'
         Type: ClientAccessibleWriters
         Attributes: Persistent, Client-accessible, No auto release, Differential, Auto recovered

Contents of shadow copy set ID: {3872a791-51b6-4d10-813f-64b4beb9f935}
   Contained 1 shadow copies at creation time: 9/14/2021 12:26:49 PM
      Shadow Copy ID: {c17ebda1-5da3-4f4a-a3dc-f5920c30ed0f}
         Original Volume: (C:)\\?\Volume{67a44989-8413-4a7c-a616-79385dae8605}\
         Shadow Copy Volume: \\?\GLOBALROOT\Device\HarddiskVolumeShadowCopy5
         Originating Machine: ampersand.redmond.corp.microsoft.com
         Service Machine: ampersand.redmond.corp.microsoft.com
         Provider: 'Microsoft Software Shadow Copy provider 1.0'
         Type: ClientAccessibleWriters
         Attributes: Persistent, Client-accessible, No auto release, Differential, Auto recovered
```

As you inspect the sample output, think about the types of data returned. As you construct your
objects you should convert the strings output by the command-line tool to .NET types. For example,
you can convert timestamp information to .NET `[DateTime]` types.

## Create a script to parse the output for each command

The `ParseShadow.ps1` script is an example of how to parse the output from `vssadmin List Shadows`.
This script becomes the _output handler_ for the Crescendo cmdlet that you create. Crescendo passes
the output of the native command to the output handler as a single string. The script breaks the
output into blocks of text separated by blank lines. Each block represents an instance of a
**Shadow**. The block is broken into lines and each line is analyzed to extract the data value and
added to a PowerShell object.

```powershell
# ParseShadow.ps1 script file
    param(
        [Parameter(Mandatory)]
        $cmdResults
    )
    # Split output into blocks of text separated by blank lines
    $textBlocks = ($cmdResults | Out-String) -split "`r`n`r`n"

    # For each block of text, parse the lines and create a custom object
    foreach ($block in $textBlocks) {
        if ($block -ne '') {
            $hash = [ordered]@{}
            # Split the block into lines
            $lines = ($block -split "`r`n").Trim()

            foreach ($line in $lines) {
                switch -regex ($line) {
                    'set ID:' {
                        $id = [guid]$line.Split(':')[1].Trim()
                        $hash.Add('SetId',$id)
                        break
                    }
                    'creation time:' {
                        $datetime = [datetime]($line -split 'time:')[1]
                        $hash.Add('CreateTime',$datetime)
                        break
                    }
                    'Copy ID:' {
                        $id = [guid]$line.Split(':')[1].Trim()
                        $hash.Add('CopyId',$id)
                        break
                    }
                    'Original Volume:' {
                        $value = ($line -split 'Volume:')[1].Trim()
                        if ($value -match '^\((?<name>[A-Z]:)\)(?<path>\\{2}.+\\$)') {
                            $volinfo = [pscustomobject]@{
                                Name = $Matches.name
                                Path = $Matches.path
                            }
                        }
                        $hash.Add('OriginalVolume',$volinfo)
                        break
                    }
                    'Copy Volume:' {
                        $hash.Add('ShadowCopyVolume', $line.Split(':')[1].Trim())
                        break
                    }
                    'Machine:' {
                        $parts = $line.Split(':')
                        $hash.Add($parts[0].Replace(' ',''), $parts[1].Trim())
                        break
                    }
                    'Provider:' {
                        $hash.Add('ProviderName',$line.Split(':')[1].Trim(" '"))
                        break
                    }
                    'Type:' {
                        $hash.Add('Type',$line.Split(':')[1].Trim())
                        break
                    }
                    'Attributes' {
                        $attrlist = $line.Split(': ')[1]
                        $hash.Add('Attributes',$attrlist.Split(', '))
                        break
                    }
                }
            }
            [pscustomobject]$hash
        }
    }
```

## Related links

- [VSSAdmin sample output][02]
- [VSSAdmin parser functions][03]

<!-- link references -->
[01]: images/crescendo/slide4.png
[02]: https://github.com/sdwheeler/seanonit/blob/main/content/downloads/crescendo/native-output/
[03]: https://github.com/sdwheeler/seanonit/blob/main/content/downloads/crescendo/vssparsers.ps1