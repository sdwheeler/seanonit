---
title: Host differences
weight: 7
navWeight: 4
featured: false
draft: false
comment: false
toc: true
pinned: false
postDate: false
index: true
---
<!-- markdownlint-disable MD041 -->
![Host differences][01]

- VS Code isn't the same as ConsoleHost or ISE

  Some features may not work the same. For example, the ISE doesn't support `Write-Progress`.

- Don't use `$Host.Version` when you want `$PSVersionTable.PSVersion`

  Notice the version of the Host in the PowerShell Extension terminal of VS Code.

  ```powershell
  "$($Host.Name) version = $($Host.Version)"
  "PowerShell version = $($PSVersionTable.PSVersion)"
  ```

  ```Output
  Visual Studio Code Host version = 2024.3.2
  PowerShell version = 7.4.5
  ```

- The `$Host` variable can't be replaced, so you can't use it your scripts except to get Host
  information.

<!-- link references -->
[01]: ./images/psprofiles/slide07.png
