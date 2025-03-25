#region Demo script for PlatyPS v1 presentation
throw "This script is not meant to be executed. Use F8 to run selected code."
# Setup the demo environment
Install-PSResource -Module Microsoft.PowerShell.PlatyPS -Reinstall -Prerelease
Import-Module Microsoft.PowerShell.PlatyPS
# Adjust the path to the demo data for your environment
Set-Location D:\Git\My-Repos\seanonit\content\downloads\platyps
Expand-Archive -Path .\demo-data.zip -DestinationPath . -Force
#endregion
#########################################################################################
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
#########################################################################################
#region New module workflow
#endregion New module workflow
#########################################################################################
#region Update module workflow
#endregion Update module workflow
#########################################################################################
#region Create MAML workflow
#endregion Create MAML workflow
#########################################################################################
#region Performance example
#endregion Performance example
#########################################################################################
#region Tool example - test docs using object model
#endregion Tool example - test docs using object model
