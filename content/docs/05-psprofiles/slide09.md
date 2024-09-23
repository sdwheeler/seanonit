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
![Other tips][01]

- Sync your profile scripts using a OneDrive folder or a GitHub repository.

  You can use symlinks to link the runtime location to source location.

  You can use a script to create the symlink.

  ```powershell
  # Creating the symbolic link to the profile
  $newItemSplat = @{
      ItemType = 'SymbolicLink'
      Value = 'C:\Git\My-Repos\tools-by-sean\profile\scripts\CurrentUserAllHosts.ps1'
      Path = $PROFILE.CurrentUserAllHosts
  }
  New-Item @newItemSplat
  ```

  However, be careful using OneDrive. OneDrive won't sync symlinks. Don't let OneDrive redirect your
  `Documents` folder on Windows. This causes problems with the command discovery and module loading.

- Use the profile hierarchy to separate configuration items.

  Put the configurations that are most common in the `$PROFILE.CurrentUserAllHosts` profile or
  higher. Put configurations that are specific to a host in the `$PROFILE.CurrentUserCurrentHost`
  profile.

- Move utility functions out of your profile and into a module.

  The modules get loaded on demand. There is no need to include them in your profile.

- Don't pollute your environment with a bunch of variables in your profile.

  - Wrap code in functions or script blocks to limit the scope of variables.
  - Use the `$global:` scope to create and manage the variables you want to be available everywhere.

<!-- link references -->
[01]: ./images/psprofiles/slide09.png
