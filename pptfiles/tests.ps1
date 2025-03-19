throw "Don't hit F5! - Use F8"
<##################################
## Convert v1 md to v2 md and yml
#>
$v1path = 'D:\Git\PS-Docs\PowerShell-Docs\reference\7.4'
$v2path = '.\v2'
$v1filemd = Join-Path $v1path 'Microsoft.PowerShell.Archive\Compress-Archive.md'
$v2filemd = Join-Path $v2path 'Microsoft.PowerShell.Archive\Compress-Archive.md'
$v2fileyml = Join-Path $v2path 'Microsoft.PowerShell.Archive\Compress-Archive.yml'
Import-MarkdownCommandHelp -Path $v1filemd | Export-MarkdownCommandHelp -OutputFolder $v2path
Import-MarkdownCommandHelp -Path $v2filemd | Export-YamlCommandHelp -OutputFolder $v2path

<##################################
## Compare v1 md to v2 yml
#>
$v1filemd = Join-Path $v1path 'Microsoft.PowerShell.Archive\Compress-Archive.md'
$v2fileyml = Join-Path $v2path 'Microsoft.PowerShell.Archive\Compress-Archive.yml'
$refcmd = Import-MarkdownCommandHelp -Path $v1filemd
$diffcmd = Import-YamlCommandHelp -Path $v2fileyml
Compare-CommandHelp -ReferenceCommandHelp $refcmd -DifferenceCommandHelp $diffcmd > .\diff.log

<##################################
## Convert v1 Markdown to v2
#>
$v1path = 'D:\Git\PS-Docs\PowerShell-Docs\reference\7.4'
$v2path = '.\v2'
Measure-Command -Expression {
    $stepName = 'Convert v1 Markdown to v2'
    dir $v1path -Recurse -Filter *.md |
        Measure-PlatyPSMarkdown |
        ForEach-Object {
            if ($_.Filetype -match 'CommandHelp') {
                    Import-MarkdownCommandHelp -Path $_.FilePath |
                        Export-MarkdownCommandHelp -OutputFolder $v2path -Force
            } elseif ($_.Filetype -match 'ModuleFile') {
                    Import-MarkdownModuleFile -Path $_.FilePath |
                        Export-MarkdownModuleFile -OutputFolder $v2path -Force
            }
        }
} | Select-Object -Property @{n='Step'; e={$stepName}}, TotalSeconds
<##################################
## Convert v2 Markdown to v2 yaml
#>
$v2path = '.\v2'
Measure-Command -Expression {
    $stepName = 'Convert v2 Markdown to YAML'
    dir $v2path -Recurse -Filter *.md |
        Measure-PlatyPSMarkdown |
        ForEach-Object {
            if ($_.Filetype -match 'CommandHelp') {
                Import-MarkdownCommandHelp -Path $_.FilePath |
                    Export-YamlCommandHelp -OutputFolder $v2path -Force
            } elseif ($_.Filetype -match 'ModuleFile') {
                    Import-MarkdownModuleFile -Path $_.FilePath |
                        Export-YamlModuleFile -OutputFolder $v2path -Force
            }
        }
} | Select-Object -Property @{n='Step'; e={$stepName}}, TotalSeconds
<##################################
## Create markdown for a new module
#>
## Step 1: Create markdown for a new module
$v2path = '.\v2'
$newMarkdownCommandHelpSplat = @{
    ModuleInfo = Get-Module Microsoft.PowerShell.PlatyPS
    OutputFolder = $v2path
    HelpVersion = '1.0.0.0'
    WithModulePage = $true
}
New-MarkdownCommandHelp @newMarkdownCommandHelpSplat
## Step 2: Create Yaml from the new markdown
$mdpath = Join-Path $v2path 'Microsoft.PowerShell.PlatyPS'
dir $mdpath -Recurse -Filter *.md |
Measure-PlatyPSMarkdown |
ForEach-Object {
    if ($_.Filetype -match 'CommandHelp') {
            Import-MarkdownCommandHelp -Path $_.FilePath |
                Export-YamlCommandHelp -OutputFolder $v2path -Force
    } elseif ($_.Filetype -match 'ModuleFile') {
            Import-MarkdownModuleFile -Path $_.FilePath |
                Export-YamlModuleFile -OutputFolder $v2path -Force
    }
}

<##################################
## Convert to MAML
## Import and convert each folder.
#>
dir v2\* -dir | ForEach-Object {
    dir $_\*-*.md |
        Measure-PlatyPSMarkdown |
        Where-Object Filetype -match 'CommandHelp' |
        Import-MarkdownCommandHelp -Path {$_.FilePath} |
        Export-MamlCommandHelp -OutputFolder .\maml -Force -Verbose
}

##################################
## Convert to MAML
##
## Import all markdown at once and stream conversion. This errors out and creates invalid XML.
dir v2\*.md -rec |
    Measure-PlatyPSMarkdown |
    Where-Object Filetype -match 'CommandHelp' |
    Import-MarkdownCommandHelp -Path {$_.FilePath} |
    Export-MamlCommandHelp -OutputFolder .\maml -Force

<# Error output

    Directory: D:\temp\platyps\maml\CimCmdlets

Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a---           3/10/2025 11:01 AM         486417 CimCmdlets-Help.xml

    Directory: D:\temp\platyps\maml\Microsoft.PowerShell.Archive

Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a---           3/10/2025 11:01 AM          68751 Microsoft.PowerShell.Archive-Help.xml
Export-MamlCommandHelp:
Line |
   5 |      Export-MamlCommandHelp -OutputFolder .\maml -Force
     |      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     | Index was outside the bounds of the array.

D:\temp\platyps❯ Get-Error

Exception             :
    Type       : System.IndexOutOfRangeException
    TargetSite :
        Name          : ThrowIndexOutOfRangeException
        DeclaringType : [Internal.Runtime.CompilerHelpers.ThrowHelpers]
        MemberType    : Method
        Module        : System.Private.CoreLib.dll
    Message    : Index was outside the bounds of the array.
    Source     : System.Private.CoreLib
    HResult    : -2146233080
    StackTrace :
   at Microsoft.PowerShell.PlatyPS.MAML.MamlConversionHelper.ConvertCommandDetails(CommandHelp commandHelp)
   at Microsoft.PowerShell.PlatyPS.MAML.MamlConversionHelper.ConvertCommandHelpToMamlCommand(CommandHelp
commandHelp)
   at Microsoft.PowerShell.PlatyPS.MAML.MamlConversionHelper.ConvertCommandHelpToMamlHelpItems(List`1 commandHelp)
   at Microsoft.PowerShell.PlatyPS.ExportMamlCommandHelpCommand.EndProcessing()
   at System.Management.Automation.CommandProcessorBase.Complete()
CategoryInfo          : NotSpecified: (:) [Export-MamlCommandHelp], IndexOutOfRangeException
FullyQualifiedErrorId : System.IndexOutOfRangeException,Microsoft.PowerShell.PlatyPS.ExportMamlCommandHelpCommand
InvocationInfo        :
    MyCommand        : Export-MamlCommandHelp
    ScriptLineNumber : 5
    OffsetInLine     : 5
    HistoryId        : 6
    Line             :     Export-MamlCommandHelp -OutputFolder .\maml -Force
    Statement        : Export-MamlCommandHelp -OutputFolder .\maml -Force
    PositionMessage  : At line:5 char:5
                       +     Export-MamlCommandHelp -OutputFolder .\maml -Force
                       +     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    InvocationName   : Export-MamlCommandHelp
    CommandOrigin    : Internal
ScriptStackTrace      : at <ScriptBlock>, <No file>: line 1
#>

<###################################
 Import MAML file
    - Show-HelpPreview works
    - Convert to XML DOM works
    - Import MAML file errors
#>
Show-HelpPreview -Path 'C:\Program Files\PowerShell\Modules\Microsoft.PowerShell.SecretStore\1.0.6\en-US\Microsoft.PowerShell.SecretStore.dll-Help.xml'
$x = [xml](gc 'C:\Program Files\PowerShell\Modules\Microsoft.PowerShell.SecretStore\1.0.6\en-US\Microsoft.PowerShell.SecretStore.dll-Help.xml' -raw)
Import-MamlHelp -Path 'C:\Program Files\PowerShell\Modules\Microsoft.PowerShell.SecretStore\1.0.6\en-US\Microsoft.PowerShell.SecretStore.dll-Help.xml'

<# Error output
Import-MamlHelp: 'None' is an invalid XmlNodeType.

PS> Get-Error

Exception             :
    Type       : System.Xml.XmlException
    Message    : 'None' is an invalid XmlNodeType.
    TargetSite :
        Name          : ReadEndElement
        DeclaringType : [System.Xml.XmlReader]
        MemberType    : Method
        Module        : System.Private.Xml.dll
    Source     : System.Private.Xml
    HResult    : -2146232000
    StackTrace :
   at System.Xml.XmlReader.ReadEndElement()
   at Microsoft.PowerShell.PlatyPS.TransformMaml.ReadDescription(XmlReader reader) in
D:\Git\PS-Src\platyPS\src\Transform\TransformMaml.cs:line 621
   at Microsoft.PowerShell.PlatyPS.TransformMaml.ReadParameter(XmlReader reader, Int32 parameterSetCount) in
D:\Git\PS-Src\platyPS\src\Transform\TransformMaml.cs:line 535
   at Microsoft.PowerShell.PlatyPS.TransformMaml.ReadSyntaxItem(XmlReader reader, String unnamedParameterSetName) in
D:\Git\PS-Src\platyPS\src\Transform\TransformMaml.cs:line 424
   at Microsoft.PowerShell.PlatyPS.TransformMaml.ReadSyntaxItems(XmlReader reader) in
D:\Git\PS-Src\platyPS\src\Transform\TransformMaml.cs:line 392
   at Microsoft.PowerShell.PlatyPS.TransformMaml.ReadCommand(String moduleName, XmlReader reader) in
D:\Git\PS-Src\platyPS\src\Transform\TransformMaml.cs:line 104
   at Microsoft.PowerShell.PlatyPS.TransformMaml.ReadMaml(String mamlFile) in
D:\Git\PS-Src\platyPS\src\Transform\TransformMaml.cs:line 72
   at Microsoft.PowerShell.PlatyPS.TransformMaml.Transform(String[] mamlFileNames) in
D:\Git\PS-Src\platyPS\src\Transform\TransformMaml.cs:line 39
   at Microsoft.PowerShell.PlatyPS.ImportMamlHelpCommand.ProcessRecord() in
D:\Git\PS-Src\platyPS\src\Command\ImportMamlCommand.cs:line 48
TargetObject          : C:\Program
Files\PowerShell\Modules\Microsoft.PowerShell.SecretStore\1.0.6\en-US\Microsoft.PowerShell.SecretStore.dll-Help.xml
CategoryInfo          : InvalidOperation: (C:\Program Files\Po…tStore.dll-Help.xml:String) [Import-MamlHelp],
XmlException
FullyQualifiedErrorId : FailedToTransformMaml,Microsoft.PowerShell.PlatyPS.ImportMamlHelpCommand
InvocationInfo        :
    MyCommand        : Import-MamlHelp
    ScriptLineNumber : 1
    OffsetInLine     : 1
    HistoryId        : 71
    Line             : Import-MamlHelp -Path 'C:\Program
Files\PowerShell\Modules\Microsoft.PowerShell.SecretStore\1.0.6\en-US\Microsoft.PowerShell.SecretStore.dll-Help.xml'
    Statement        : Import-MamlHelp -Path 'C:\Program
Files\PowerShell\Modules\Microsoft.PowerShell.SecretStore\1.0.6\en-US\Microsoft.PowerShell.SecretStore.dll-Help.xml'
    PositionMessage  : At line:1 char:1
                       + Import-MamlHelp -Path 'C:\Program Files\PowerShell\Modules\Microsoft. …
                       + ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    InvocationName   : Import-MamlHelp
    CommandOrigin    : Internal
ScriptStackTrace      : at <ScriptBlock>, <No file>: line 1
PipelineIterationInfo :
      0
      1
#>

<##################################
## Create a new CommandHelp object from a command
#>
New-CommandHelp (gcm New-PSSession) | fl

<##################################
## Create a new markdown for a module
#>
## Step 1 - Create markdown for a all commands
$newMarkdownCommandHelpSplat = @{
    ModuleInfo = Get-Module sdwheeler.GitTools
    OutputFolder = '.\v2'
    HelpVersion = '1.0.0.0'
    WithModulePage = $true
}
New-MarkdownCommandHelp @newMarkdownCommandHelpSplat
## Step 2 - Create markdown for a module file
$newMarkdownCommandHelpSplat = @{
    CommandHelp  = Get-Command -Module Microsoft.PowerShell.PlatyPS | New-CommandHelp
    OutputFolder = '.\new'
    Force        = $true
}
New-MarkdownModuleFile @newMarkdownCommandHelpSplat

<##################################
## Create a new markdown for a module
#>
Test-MarkdownCommandHelp .\v2\Microsoft.PowerShell.Archive\*-*.md
Test-MarkdownCommandHelp .\v2\Microsoft.PowerShell.Archive\*-*.md -DetailView

<##################################
## Update markdown for a command
#>
$v1path = 'D:\Git\PS-Docs\PowerShell-Docs\reference\7.4'
$v2path = '.\update'
Update-CommandHelp -Path $v1path\Cimcmdlets\New-CimInstance.md |
    Export-MarkdownCommandHelp -OutputFolder $v2path -Force

<##################################
## Update all markdown in a module folder
#>
## Step 1 - Get a list of CommandHelp files and update them
$cmds = Measure-PlatyPSMarkdown -Path .\v2\CimCmdlets\*.md |
    Where-Object Filetype -match 'CommandHelp'
Update-MarkdownCommandHelp -Path $cmds.FilePath
## Step 2 - Import CommandHelp files and update the module file
$cmdhelp = Import-MarkdownCommandHelp -Path $cmds.FilePath
$mods = Measure-PlatyPSMarkdown -Path .\v2\CimCmdlets\*.md |
    Where-Object Filetype -match 'ModuleFile'
Update-MarkdownModuleFile -Path $mods.FilePath -CommandHelp $cmdhelp

<# NOTE TO SELF

   V1 content may not have parameter sets in same order as V2 content.
   For easier comparison of diffs, this needs to be fixed by the author at migration time.

   Steps
   - Convert v1 to v2
   - Update v2 to ensure proper parameter set order and metadata
   - Fill in missing content found by update

#>

<##################################
## Create new CAB/ZIP files
#>
dir -path .\maml -dir | ForEach-Object {
    $params = @{
        CabinetFilesFolder = $_.FullName
        MarkdownModuleFile = "$($_.FullName -replace 'maml', 'v2')\$($_.Name).md"
        OutputFolder       = '.\maml'
    }
    New-HelpCabinetFile @params
}

<# Error - There is no function that create the HelpInfo.xml file.

Get-Item: Cannot find path 'D:\temp\platyps\maml\CimCmdlets_fb6cc51d-c096-4b38-b78d-0fed6277096a_HelpInfo.xml' because it
does not exist.
MethodException: Multiple ambiguous overloads found for "Save" and the argument count: "1".
Get-Item: Cannot find path
'D:\temp\platyps\maml\Microsoft.PowerShell.Archive_eb74e8da-9ae2-482a-a648-e96550fb8733_HelpInfo.xml' because it
does not exist.
MethodException: Multiple ambiguous overloads found for "Save" and the argument count: "1".
Get-Item: Cannot find path 'D:\temp\platyps\maml\Microsoft.PowerShell.Core_00000000-0000-0000-0000-000000000000_HelpInfo.xml'
because it does not exist.
MethodException: Multiple ambiguous overloads found for "Save" and the argument count: "1".
Get-Item: Cannot find path
'D:\temp\platyps\maml\Microsoft.PowerShell.Diagnostics_ca046f10-ca64-4740-8ff9-2565dba61a4f_HelpInfo.xml' because
it does not exist.
MethodException: Multiple ambiguous overloads found for "Save" and the argument count: "1".
Get-Item: Cannot find path 'D:\temp\platyps\maml\Microsoft.PowerShell.Host_56d66100-99a0-4ffc-a12d-eee9a6718aef_HelpInfo.xml'
because it does not exist.
MethodException: Multiple ambiguous overloads found for "Save" and the argument count: "1".
Get-Item: Cannot find path
'D:\temp\platyps\maml\Microsoft.PowerShell.Management_eefcb906-b326-4e99-9f54-8b4bb6ef3c6d_HelpInfo.xml' because it
does not exist.
MethodException: Multiple ambiguous overloads found for "Save" and the argument count: "1".
MakeHelpInfoXml: Cannot bind argument to parameter 'URI' because it is an empty string.
Get-Item: Cannot find path
'D:\temp\platyps\maml\Microsoft.PowerShell.Security_a94c8c7e-9810-47c0-b8af-65089c13a35a_HelpInfo.xml' because it
does not exist.
MethodException: Multiple ambiguous overloads found for "Save" and the argument count: "1".
Get-Item: Cannot find path
'D:\temp\platyps\maml\Microsoft.PowerShell.Utility_1da87e53-152b-403e-98dc-74d7b4d63d59_HelpInfo.xml' because it
does not exist.
MethodException: Multiple ambiguous overloads found for "Save" and the argument count: "1".
Get-Item: Cannot find path
'D:\temp\platyps\maml\Microsoft.WSMan.Management_766204a6-330e-4263-a7ab-46c87afc366c_HelpInfo.xml' because it does
not exist.
MethodException: Multiple ambiguous overloads found for "Save" and the argument count: "1".
Get-Item: Cannot find path 'D:\temp\platyps\maml\PSDiagnostics_c61d6278-02a3-4618-ae37-a524d40a7f44_HelpInfo.xml' because it
does not exist.
MethodException: Multiple ambiguous overloads found for "Save" and the argument count: "1".
Get-Item: Cannot find path 'D:\temp\platyps\maml\PSReadLine_5714753b-2afd-4492-a5fd-01d9e2cff8b5_HelpInfo.xml' because it
does not exist.
MethodException: Multiple ambiguous overloads found for "Save" and the argument count: "1".
Get-Item: Cannot find path 'D:\temp\platyps\maml\ThreadJob_0e7b895d-2fec-43f7-8cae-11e8d16f6e40_HelpInfo.xml' because it does
not exist.
MethodException: Multiple ambiguous overloads found for "Save" and the argument count: "1".
#>