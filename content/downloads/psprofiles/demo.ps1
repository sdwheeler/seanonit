#-------------------------------------------------------
#region Presentation information
#-------------------------------------------------------
# Title  : Optimizing Your PowerShell Profile
# Author : Sean Wheeler (sean.wheeler@microsoft.com)
# Event  : SQL Saturday 2023 #1060 - Baton Rouge, LA
#          https://sqlsaturday.com/2023-07-29-sqlsaturday1060/
throw "You're not supposed to run the entire script. Use F8 not F5!"
#-------------------------------------------------------
#endregion
#-------------------------------------------------------
$PSVersionTable
#-------------------------------------------------------
#region Profile basics
#-------------------------------------------------------
$profile | Select-Object *

#-------------------------------------------------------
#endregion
#-------------------------------------------------------
#region Version-specific differences
#-------------------------------------------------------
# Platform specific variables
dir variable:is* # not available in PS5.1

# Show cmdlet differences between versions
Get-Command Invoke-RestMethod -Syntax
(Get-Command Invoke-RestMethod).ParameterSets.Count
(Get-Command Invoke-RestMethod).Parameters.Count
Get-Command Test-Connection -Syntax

# Experimental features
Get-ExperimentalFeature

# Creating ANSI escape sequences for PS5.1
$RedText = "`e[91m" + 'This is red text' + "`e[0m"
$RedText
${esc} = [char]0x1b
[char]0xa9
"`u{a9}"
$RedText = "${esc}[91m" + 'This is red text' + "${esc}[0m"
$RedText

#region New operators
# New operators introduced in PS7+
# Chain operators
notepad
Get-Process notepad
Stop-Process -Name notepad
Get-Process notepad && Stop-Process -Name notepad
Get-Process notepad || notepad

# Ternary operator ? <if-true> : <if-false>
(Test-Path $PROFILE) ? "Path exists" : "Path not found"
(Test-Path $PROFILE.AllUsersAllHosts) ? "Path exists" : "Path not found"

# Null coalesing operator ?? <if-null>
[string]$startDate = $null
$startDate ?? (Get-Date).ToShortDateString()
$startDate = '1/10/2020'
$startDate ?? (Get-Date).ToShortDateString()
#endregion New operators
#-------------------------------------------------------
#endregion
#-------------------------------------------------------
#region OS-specific differences
#-------------------------------------------------------
# Environment variables are case sensitive in Linux
$env:path -split ';'
$env:path -split ':'
$env:PATH -split [System.IO.Path]::PathSeparator

# File system differences
[System.IO.Path] | Get-Member -Static -Type Property

'DirectorySeparatorChar', 'PathSeparator', 'VolumeSeparatorChar' |
    ForEach-Object { [System.IO.Path]::$_ }

# Aliases vs. native commands
Get-Command cat, clear, cp, diff, kill, ls, man, mount, mv, ps, rm, rmdir,
    sleep, sort, tee, write

#-------------------------------------------------------
#endregion
#-------------------------------------------------------
#region Host-specific differences
#-------------------------------------------------------
#Host-specific commands - VS Code != console/terminal
"$($Host.Name) version = $($Host.Version)"; "PowerShell version = $($PSVersionTable.PSVersion)"

#-------------------------------------------------------
#endregion
#-------------------------------------------------------
#region Tools and environment settings
#-------------------------------------------------------
# Default parameter values
$PSDefaultParameterValues

# Customizing the prompt
gc function:prompt
$GitPromptSettings

# Managing ANSI colors
$PSStyle

# PSReadLine configuration
Get-PSReadLineKeyHandler
[Console]::ReadKey()
Get-PSReadLineOption

# Creating the symbolic link to the profile
$newItemSplat = @{
    ItemType = 'SymbolicLink'
    Value = 'D:\Git\My-Repos\Presentations\SQLSaturday\2023-BatonRouge\profile.ps1'
    Path = $PROFILE.CurrentUserAllHosts
}
New-Item @newItemSplat

#-------------------------------------------------------
#endregion
#-------------------------------------------------------
