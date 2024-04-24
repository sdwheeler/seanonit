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

- Non-Windows platforms don't support graphical features like `Out-GridView` and
  `Get-Help -ShowWindow`

- Non-Windows platforms don't support Authenticode or the PowerShell execution policy

- Non-Windows platforms are case-sensitive

  For example, environment variables are case-sensitive on Linux.

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

  Windows:

  ```powershell
  PS> Get-Command cat, clear, cp, diff, kill, ls, man, mount, mv, ps, rm, rmdir, sleep, sort, tee, write

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

  ```powershell
  PS> Get-Command cat, clear, cp, diff, kill, ls, man, mount, mv, ps, rm, rmdir, sleep, sort, tee, write

  CommandType     Name                      Version    Source
  -----------     ----                      -------    ------
  Application     cat                       0.0.0.0    /usr/bin/cat
  Application     clear                     0.0.0.0    /usr/bin/clear
  Application     cp                        0.0.0.0    /usr/bin/cp
  Application     diff                      0.0.0.0    /usr/bin/diff
  Application     kill                      0.0.0.0    /usr/bin/kill
  Application     ls                        0.0.0.0    /usr/bin/ls
  Application     man                       0.0.0.0    /usr/bin/man
  Application     mount                     0.0.0.0    /usr/bin/mount
  Application     mv                        0.0.0.0    /usr/bin/mv
  Application     ps                        0.0.0.0    /usr/bin/ps
  Application     rm                        0.0.0.0    /usr/bin/rm
  Application     rmdir                     0.0.0.0    /usr/bin/rmdir
  Application     sleep                     0.0.0.0    /usr/bin/sleep
  Application     sort                      0.0.0.0    /usr/bin/sort
  Application     tee                       0.0.0.0    /usr/bin/tee
  Application     write                     0.0.0.0    /usr/bin/write
  ```

- PowerShell doesn't support Linux-style background jobs

- PATH and directory separator characters are different

## Related articles

- [Release history of modules and cmdlets][02]
- [PowerShell differences on non-Windows platforms][03]

<!-- link references -->
[01]: ./images/psprofiles/slide06.png
[02]: https://learn.microsoft.com/powershell/scripting/whats-new/cmdlet-versions
[03]: https://learn.microsoft.com/powershell/scripting/whats-new/unix-support
