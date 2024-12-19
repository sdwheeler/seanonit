---
title: Stop polluting your variable space
date: 2024-12-18-stop-polluting-your-variable-space
draft: false
showReadTime: false
categories:
  - PowerShell
tags:
  - variables
  - profiles
  - vscode
  - ise
description: >
  How to avoid polluting your variable space in PowerShell.
---
Where do variables come from?

- Preference variables
- Automatic variables
- Environment variables
- Modules can export variable
- Scripts (like your profiles)
- F5/F8 in VSCode/ISE

Dot sourcing operator .
Runs a script in the current scope so that any functions, aliases, and variables that the script creates are added to the current scope, overriding existing ones.

```powershell
    # Check for admin privileges
    & {
        $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
        $principal = [Security.Principal.WindowsPrincipal] $identity
        $global:IsAdmin = $principal.IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')
    }
```

```powershell
$PSStyle.Progress.UseOSCIndicator = $true
$PSStyle.OutputRendering = 'Host'
$PSStyle.FileInfo.Directory = $PSStyle.Background.FromRgb(0x2f6aff) + $PSStyle.Foreground.BrightWhite
& {
    $PSROptions = @{
        Colors             = @{
            Operator         = $PSStyle.Foreground.BrightMagenta
            Parameter        = $PSStyle.Foreground.BrightMagenta
            Selection        = $PSStyle.Foreground.BrightGreen + $PSStyle.Background.BrightBlack
            InLinePrediction = $PSStyle.Background.BrightBlack
        }
    }
    Set-PSReadLineOption @PSROptions
}
```


[about_Environment_Variables](https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_environment_variables)

[Get-Variable](https://learn.microsoft.com/powershell/module/microsoft.powershell.utility/get-variable)
[about_Variable_Provider](https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_variable_provider)
[about_Variables](https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_variables)
[about_Preference_Variables](https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_preference_variables)
[about_Automatic_Variables](https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_automatic_variables)
[about_Operators](https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_operators#dot-sourcing-operator-)
[about_Scopes](https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_scopes)