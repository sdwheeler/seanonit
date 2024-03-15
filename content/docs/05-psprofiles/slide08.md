---
title: Setting up your environment
weight: 8
navWeight: 3
featured: false
draft: false
comment: false
toc: true
pinned: false
postDate: false
index: true
---
<!-- markdownlint-disable MD041 -->
![Setting up your environment][01]

- Tool and application settings

  Your profile script is where you configure your environment. Use it to set configuration options
  that don't persist across sessions.

- Loading modules

  Load the modules you use the most. Let PowerShell command discovery autoload other modules on
  demand.

- Adding helper functions

  Don't define a bunch of utility functions in your profile script. Instead, create a module and put
  your functions there. Only define the functions needed to bootstrap your environment in your
  profile script.

- Configuring colors and keybindings

  PSReadLine allows you to configure colors and keybindings. Add these commands to your profile so
  they persist across sessions.

- `$PSDefaultParameterValues`

  The `$PSDefaultParameterValues` preference variable allows you to set default parameter values for
  cmdlets. For example, you may want the `Install-Module` to alway use the **SkipPublisherCheck**
  parameter.

  Here are several examples:

  ```powershell
  $PSDefaultParameterValues = @{
      'Out-Default:OutVariable'           = 'LastResult'  # Save output to $LastResult
      'Out-File:Encoding'                 = 'utf8'        # PS5.1 defaults to ASCII
      'Export-Csv:NoTypeInformation'      = $true         # PS5.1 defaults to $false
      'ConvertTo-Csv:NoTypeInformation'   = $true         # PS5.1 defaults to $false
      'Receive-Job:Keep'                  = $true         # Prevents accidental loss of output
      'Install-Module:AllowClobber'       = $true         # Default behavior in Install-PSResource
      'Install-Module:Force'              = $true         # Default behavior in Install-PSResource
      'Install-Module:SkipPublisherCheck' = $true         # Default behavior in Install-PSResource
      'Group-Object:NoElement'            = $true         # Minimize noise in output
      'Find-Module:Repository'            = 'PSGallery'   # Useful if you have private test repos
      'Install-Module:Repository'         = 'PSGallery'   # Useful if you have private test repos
      'Find-PSResource:Repository'        = 'PSGallery'   # Useful if you have private test repos
      'Install-PSResource:Repository'     = 'PSGallery'   # Useful if you have private test repos
  }
  ```

- Custom prompts

  In PowerShell, the command prompt that is displayed is created by the `prompt` function. You can
  write your own custom `prompt` function to display whatever you want.

## Related articles

- [about_Prompts][02]
- [about_Parameters_Default_Values][03]
- [Set-PSReadLineOption][04]

<!-- link references -->
[01]: ./images/psprofiles/slide08.png
[02]: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_prompts
[03]: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_parameters_default_values
[04]: https://learn.microsoft.com/powershell/module/psreadline/set-psreadlineoption
