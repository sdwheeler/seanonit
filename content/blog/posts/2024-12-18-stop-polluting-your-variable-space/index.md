---
title: Stop polluting your variable space
date: 2024-12-18
draft: true
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
<!-- markdownlint-disable-file MD041 -->
There are three general types of variables in PowerShell.

- Automatic variables: These variables are created by PowerShell, and PowerShell changes their
  values as required to maintain their accuracy. For example, the `$PSHOME` variable stores the path
  to the PowerShell installation directory. For more information, see
  [about_Automatic_Variables][01].

- Preference variables: These variables are created by PowerShell and are populated with default
  values. Users can change the values of these variables. For example, the `$MaximumHistoryCount`
  variable determines the maximum number of entries in the session history. For more information,
  see [about_Preference_Variables][04].

- User-created variables: User-created variables are created and maintained by the user. You can
  create variables interactively, at the command line, or in scripts. Modules that you load can also
  create variables for internal use or can export variables to the global scope. For more
  information, see [about_Variables][07].

Where do variables come from?

- Modules can export variable
- Scripts (like your profiles)
- F5/F8 in VSCode/ISE

Dot sourcing operator .

Runs a script in the current scope so that any functions, aliases, and variables that the script
creates are added to the current scope, overriding existing ones.

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

## Further reading

- [Get-Variable][08]
- [about_Variables][07]
- [about_Variable_Provider][06]
- [about_Preference_Variables][04]
- [about_Automatic_Variables][01]
- [about_Operators][03]
- [about_Scopes][05]

<!-- link references -->
[01]: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_automatic_variables
[03]: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_operators#dot-sourcing-operator-
[04]: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_preference_variables
[05]: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_scopes
[06]: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_variable_provider
[07]: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_variables
[08]: https://learn.microsoft.com/powershell/module/microsoft.powershell.utility/get-variable
