---
title: Other tips
weight: 9
navWeight: 2
featured: false
draft: false
comment: false
toc: true
pinned: false
postDate: false
index: true
---
<!-- markdownlint-disable MD041 -->
![Other tips](./images/psprofiles/slide09.png)

- Sync your profile scripts using a OneDrive folder or a GitHub repository.

  You can use symlinks to link the runtime location to source location.

  ```powershell
  # Creating the symbolic link to the profile
  $newItemSplat = @{
      ItemType = 'SymbolicLink'
      Value = 'D:\Git\My-Repos\Presentations\SQLSaturday\2023-BatonRouge\profile.ps1'
      Path = $PROFILE.CurrentUserAllHosts
  }
  New-Item @newItemSplat
  ```

  Don't let OneDrive redirect your `Documents` folder on Windows. This causes problems with the
  command discovery and module loading.

- Use the profile hierarchy to separate configuration items.

  Put the configurations that are most common in the `$PROFILE.CurrentUserAllHosts` profile or
  higher. Put configurations that are specific to a host in the `$PROFILE.CurrentUserCurrentHost`
  profile.

- Move utility functions out of your profile and into a module.

  They can be loaded on demand, no need to include in profile.
