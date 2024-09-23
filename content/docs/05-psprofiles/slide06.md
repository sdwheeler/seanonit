---
title: Platform differences
weight: 6
navWeight: 5
featured: false
draft: false
comment: false
toc: true
pinned: false
postDate: false
index: true
---
<!-- markdownlint-disable MD041 -->
![Platform differences][01]

## Differences between PowerShell 7 on Windows and non-Windows platforms

- PowerShell on Windows has several modules that aren't available on non-Windows platforms

  The following modules are only available on Windows:

  - CimCmdlets
  - ISE (Windows PowerShell 5.1 only)
  - Microsoft.PowerShell.Diagnostics
  - Microsoft.PowerShell.LocalAccounts (Windows PowerShell 5.1 only)
  - Microsoft.PowerShell.ODataUtils (Windows PowerShell 5.1 only)
  - Microsoft.PowerShell.Operation.Validation (Windows PowerShell 5.1 only)
  - Microsoft.WsMan.Management
  - PSDiagnostics
  - PSScheduledJob
  - PSWorkflow (Windows PowerShell 5.1 only)
  - PSWorkflowUtility (Windows PowerShell 5.1 only)

- Non-Windows platforms don't support graphical features like `Out-GridView` and
  `Get-Help -ShowWindow`

- Non-Windows platforms don't support Authenticode or the PowerShell execution policy

- Non-Windows platforms are case-sensitive

  PowerShell is case-insensitive but case-preserving on all platforms. Non-Windows platforms are
  case-sensitive. For example, environment variables are case-sensitive on Linux.

  ```powershell
  PS> lsb_release -a
  No LSB modules are available.
  Distributor ID: Ubuntu
  Description:    Ubuntu 22.04.2 LTS
  Release:        22.04
  Codename:       jammy

  PS> Test-Path env:path
  False

  PS> Test-Path env:PATH
  True
  ```

- PowerShell on Windows has several aliases that mimic native commands on non-Windows platforms

  ```powershell
  Get-Command cat, clear, cp, diff, kill, ls, man, mount, mv, ps, rm, rmdir, sleep, sort, tee, write
  ```

  Windows:

  ```Output
  CommandType     Name                      Version    Source
  -----------     ----                      -------    ------
  Alias           cat -> Get-Content
  Alias           clear -> Clear-Host
  Alias           cp -> Copy-Item
  Alias           diff -> Compare-Object
  Alias           kill -> Stop-Process
  Alias           ls -> Get-ChildItem
  Alias           man -> help
  Alias           mount -> New-PSDrive
  Alias           mv -> Move-Item
  Alias           ps -> Get-Process
  Alias           rm -> Remove-Item
  Alias           rmdir -> Remove-Item
  Alias           sleep -> Start-Sleep
  Alias           sort -> Sort-Object
  Alias           tee -> Tee-Object
  Alias           write -> Write-Output
  ```

  Linux:

  ```Output
  CommandType     Name     Version    Source
  -----------     ----     -------    ------
  Application     cat      0.0.0.0    /usr/bin/cat
  Application     clear    0.0.0.0    /usr/bin/clear
  Application     cp       0.0.0.0    /usr/bin/cp
  Application     diff     0.0.0.0    /usr/bin/diff
  Application     kill     0.0.0.0    /usr/bin/kill
  Application     ls       0.0.0.0    /usr/bin/ls
  Application     man      0.0.0.0    /usr/bin/man
  Application     mount    0.0.0.0    /usr/bin/mount
  Application     mv       0.0.0.0    /usr/bin/mv
  Application     ps       0.0.0.0    /usr/bin/ps
  Application     rm       0.0.0.0    /usr/bin/rm
  Application     rmdir    0.0.0.0    /usr/bin/rmdir
  Application     sleep    0.0.0.0    /usr/bin/sleep
  Application     sort     0.0.0.0    /usr/bin/sort
  Application     tee      0.0.0.0    /usr/bin/tee
  Application     write    0.0.0.0    /usr/bin/write
  ```

- PowerShell doesn't support Linux-style background jobs

- PATH, directory separator, and line-ending characters are different

  - Use `[System.IO.Path]` class to handle path separators
  - Use `[System.Environment]::NewLine` to handle line-ending characters

## Related articles

- [Release history of modules and cmdlets][04]
- [PowerShell differences on non-Windows platforms][05]
- [Release history of modules and cmdlets][04]
- [Path Class (System.IO)][03]
- [Environment.NewLine Property][02]

<!-- link references -->
[01]: ./images/psprofiles/slide06.png
[02]: https://learn.microsoft.com/dotnet/api/system.environment.newline
[03]: https://learn.microsoft.com/dotnet/api/system.io.path
[04]: https://learn.microsoft.com/powershell/scripting/whats-new/cmdlet-versions
[05]: https://learn.microsoft.com/powershell/scripting/whats-new/unix-support
