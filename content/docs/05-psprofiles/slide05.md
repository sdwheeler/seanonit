---
title: Version differences
weight: 5
navWeight: 6
featured: false
draft: false
comment: false
toc: true
pinned: false
postDate: false
index: true
---
<!-- markdownlint-disable MD041 -->
![Version differences][01]

## Differences between PowerShell 7 and Windows PowerShell 5.1

- PowerShell 7 has new character codes for Escape and any Unicode character

- PowerShell 7 has enhanced support for ANSI escape sequence handling in the console

- PowerShell 7 has several new cmdlets that aren't available in Windows PowerShell 5.1
  - `ConvertFrom-Markdown`, `Show-Markdown`
  - `Get-Error`
  - `Get-Uptime`
  - `Remove-Alias`
  - `Remove-Service`

- PowerShell 7 is missing several cmdlets that are available in Windows PowerShell 5.1
  - WMI cmdlets (Use the CimCmdlets instead)
    - `Get-WmiObject`
    - `Invoke-WmiMethod`
    - `Register-WmiEvent`
    - `Remove-WmiObject`
    - `Set-WmiInstance`
  - The Workflow cmdlets
    - `Invoke-AsWorkflow`
    - `New-PSWorkflowSession`
    - `New-PSWorkflowExecutionOption`

- The behavior of some cmdlets has changed in PowerShell 7

  For example, the `Invoke-RestMethod` cmdlet has 4 parameter sets and 53 parameters in PowerShell
  7.

  ```powershell
  PS> $PSVersionTable.PSVersion.ToString()
  7.3.6
  PS> (Get-Command Invoke-RestMethod).ParameterSets.Count
  4
  PS> (Get-Command Invoke-RestMethod).Parameters.Count
  53
  ```

  The same command in Windows PowerShell has 1 parameter set and 34 parameters.

  ```powershell
  PS> $PSVersionTable.PSVersion.ToString()
  5.1.22621.1778
  PS> (Get-Command Invoke-RestMethod).ParameterSets.Count
  1
  PS> (Get-Command Invoke-RestMethod).Parameters.Count
  34
  ```

- PowerShell 7 has new experimental features

- PowerShell 7 has new operators that aren't available in Windows PowerShell 5.1

  ```powershell
  # Chain operators

  # Stop the notepad process if it's running
  Get-Process notepad && Stop-Process -Name notepad

  # Start notepad if it's not running
  Get-Process notepad || notepad

  # Ternary operator ? <if-true> : <if-false>
  (Test-Path $PROFILE) ? "Path exists" : "Path not found"
  (Test-Path $PROFILE.AllUsersAllHosts) ? "Path exists" : "Path not found"

  # Null coalesing operator ?? <if-null>
  # Return the right side value if the left side is null

  PS> $startDate = $null
  PS> $startDate ?? (Get-Date).ToShortDateString()
  8/30/2023
  PS> $startDate = '1/10/2020'
  PS> $startDate ?? (Get-Date).ToShortDateString()
  1/10/2020
  ```

- PowerShell 7 has defaults to UTF-8 encoding for all output

## Related articles

- [Differences between Windows PowerShell 5.1 and PowerShell 7.x][06]
- [about Special Characters][04]
- [about_ANSI_Terminals][02]
- [Using Experimental Features in PowerShell][05]
- [about_Operators][03]

<!-- link references -->
[01]: ./images/psprofiles/slide05.png
[02]: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_ANSI_Terminals
[03]: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_Operators
[04]: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_special_characters
[05]: https://learn.microsoft.com/powershell/scripting/learn/experimental-features
[06]: https://learn.microsoft.com/powershell/scripting/whats-new/differences-from-windows-powershell
