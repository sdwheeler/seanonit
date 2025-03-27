#-------------------------------------------------------------------------------
#region Demo script for PlatyPS v1 presentation
throw "This script is not meant to be executed. Use F8 to run selected code."
# Setup the demo environment
Install-PSResource -Module Microsoft.PowerShell.PlatyPS -Reinstall -Prerelease
Import-Module Microsoft.PowerShell.PlatyPS
# Adjust the path to the demo data for your environment
Set-Location D:\Git\My-Repos\seanonit\content\downloads\platyps
Expand-Archive -Path .\demo-data.zip -DestinationPath . -Force
#endregion
#-------------------------------------------------------------------------------
#region New object model
# Create new command help object from a command
$cmdhelp = New-CommandHelp -CommandInfo (Get-Command New-CommandHelp)
$cmdhelp | Select-Object *
$cmdhelp.Synopsis = "Creates CommandHelp objects for a PowerShell command that's loaded in the session."
$cmdhelp | Select-Object *
# Create new command help object from a command
$cmdhelp = Import-MarkdownCommandHelp -Path .\Microsoft.PowerShell.PlatyPS\New-CommandHelp.md
$cmdhelp | Select-Object *
$cmdhelp.Diagnostics | Format-List *
$cmdhelp.Diagnostics.Messages
#endregion New object model
#-------------------------------------------------------------------------------
#region New module workflow
$v2path = '.\v2'
$newMarkdownCommandHelpSplat = @{
    ModuleInfo = Get-Module Microsoft.PowerShell.PlatyPS
    OutputFolder = $v2path
    HelpVersion = '1.0.0.2'
    WithModulePage = $true
}
New-MarkdownCommandHelp @newMarkdownCommandHelpSplat
#endregion New module workflow
#-------------------------------------------------------------------------------
#region Update module workflow
Measure-PlatyPSMarkdown -Path .\Microsoft.PowerShell.PlatyPS\*.md |
    Where-Object Filetype -match 'CommandHelp' |
    Update-CommandHelp -Path {$_.FilePath} |
    Export-MarkdownCommandHelp -OutputFolder $v2path -Force
## Compare v1 and v2 folders
## - This examples uses Beyond Compare
## - Use the diff tool of your choice
bc .\Microsoft.PowerShell.PlatyPS .\v2\Microsoft.PowerShell.PlatyPS
#endregion Update module workflow
#-------------------------------------------------------------------------------
#region Create MAML workflow
$mdpath = Join-Path $v2path 'Microsoft.PowerShell.PlatyPS'
dir $mdpath -Recurse -Filter *.md |
    Measure-PlatyPSMarkdown |
    Where-Object Filetype -match 'CommandHelp' |
    Import-MarkdownCommandHelp -Path {$_.FilePath} |
    Export-MamlCommandHelp -OutputFolder .\maml -Force
# Inspect the MAML file
Show-HelpPreview -Path .\maml\Microsoft.PowerShell.PlatyPS\Microsoft.PowerShell.PlatyPS-Help.xml |
    more
#endregion Create MAML workflow
#-------------------------------------------------------------------------------
#region Performance example
# Update the entire docset for PowerShell 7.5
$start = Get-Date
dir D:\Git\PS-Docs\PowerShell-Docs\reference\7.5\ -Recurse -Filter *-*.md -Exclude about_* |
    ForEach-Object {
        Update-CommandHelp -Path $_.FullName |
        Export-MarkdownCommandHelp -OutputFolder $v2path -Force
}
$end = Get-Date
Write-Host "Elapsed time: $(($end - $start).TotalSeconds) seconds"
#endregion Performance example
#-------------------------------------------------------------------------------
#region Tool example - test docs using object model
. .\Test-ParameterInfo.ps1
Test-ParameterInfo D:\Git\PS-Docs\PowerShell-Docs\reference\7.5\Microsoft.PowerShell.Management\Get-ChildItem.md
#endregion Tool example - test docs using object model
