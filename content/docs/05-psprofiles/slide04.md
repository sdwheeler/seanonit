---
title: Profile basics
weight: 4
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
![Profile basics][01]

In PowerShell, the profile script is used to customize the shell environment and define functions,
aliases, and variables. The profile is a PowerShell script file that's executed when you start a
PowerShell session, whether it's an interactive session or a script execution.

## Order of precedence

There are different profile scripts, in different locations, that apply to all users on the system
or just the current user. PowerShell runs the profile scripts in the following order.

- All Users, All Hosts
- All Users, Current Host
- Current User, All Hosts
- Current user, Current Host

Any settings in the profile scripts are applied in the order they are run. The last setting applied
overrides any previous settings.

The different profile scopes and locations allow you to create scripts that can be shared across
your enterprise. You can deploy scripts using group policy or configuration management tools so that
you can have a consistent PowerShell environment across all your systems.

## File locations

Use the following command to see the list of profiles scripts and locations.

```powershell
$profile | Select-Object *
```

On Windows:

```Output
AllUsersAllHosts       : C:\Program Files\PowerShell\7-preview\profile.ps1
AllUsersCurrentHost    : C:\Program Files\PowerShell\7-preview\Microsoft.PowerShell_profile.ps1
CurrentUserAllHosts    : C:\Users\sewhee\Documents\PowerShell\profile.ps1
CurrentUserCurrentHost : C:\Users\sewhee\Documents\PowerShell\Microsoft.PowerShell_profile.ps1
Length                 : 69
```

On Linux:

```Output
AllUsersAllHosts       : /opt/microsoft/powershell/7/profile.ps1
AllUsersCurrentHost    : /opt/microsoft/powershell/7/Microsoft.PowerShell_profile.ps1
CurrentUserAllHosts    : /home/sdwheeler/.config/powershell/profile.ps1
CurrentUserCurrentHost : /home/sdwheeler/.config/powershell/Microsoft.PowerShell_profile.ps1
Length                 : 67
```

PowerShell doesn't load profiles from remote sessions. If you are in a remote interactive session
you can dot-source the profile script to load it.

```powershell
. $profile
```

For more information, see [about_Profiles][02].

<!-- link references -->
[01]: ./images/psprofiles/slide04.png
[02]: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_profiles
