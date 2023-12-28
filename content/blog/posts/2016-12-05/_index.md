---
title: Using Git from PowerShell
date: 2016-12-05T13:37:09
draft: false
---
This year has been full of changes for me. One of the biggest changes is that my job requires me to
use Git and GitHub for almost all of my work. Before this new job, I had never used Git. By default,
the Git installer installs the bash command shell. Most of the documentation is written assuming
that you are using bash. However, I prefer to work in PowerShell. In this article I will show how I
set up my environment to enable Git functionality in PowerShell. This is not meant to be a tutorial
on using Git but, rather, a example of what works for me and for my workflow.

## Download and install the Git for Windows

First thing is to install Git for Windows. Download and run the
[Git for Windows][01] installer. As you step through the
installation wizard you are presented with several options. The following is a list of the options
on each page of the installation wizard with the reasoning behind my choice.

- The **Select Components** page
  - Check **Git LFS (Large File Support)**
  - Check **Associate .git\* configuration files with the default text**
  - Check **Use a TrueType font in all console windows** I prefer the TrueType font Consolas as my
      monospaced font for command shells and code editors.
- The **Choosing the default editor used by Git** page
  - Select **Use Visual Studio Code as Git's default editor** VS Code does everything.
- The **Adjusting your PATH environment** page
  - Select **Use Git from the Windows Command Prompt** This adds the Git tools to your PATH so that
      it works for Cmd, PowerShell, or bash.
- The **Choosing HTTPS transport backend** page
  - Select **Use the native Windows Secure Channel library**
- The **Configure the line ending conversions** page
  - Select **Checkout Windows-style, commit Unix-style line endings** This is the recommended
      setting on Windows and provides the most compatibility for cross-platform projects.
- The **Configuring the terminal emulator to use with Git bash** page
  - Select **Use Windows' default console window** This is the console that PowerShell uses and
      works best with other Windows console-based applications.
- The **Configuring extra options** page
  - Check **Enable file system caching** This option is checked by default. Caching improves
      performance of certain Git operations.
  - Check **Enable Git Credential Manager** The Git Credential Manager for Windows (GCM) provides
    secure Git credential storage for Windows. GCM provides multi-factor authentication support for
    Visual Studio Team Services, Team Foundation Server, and GitHub. Enabling GCM prevents the need
    for Git to continuously prompt for your Git credentials for nearly every operation. For more
    information see the
    [GCM documentation][05] on GitHub.
  - Check **Enable symbolic links**

These are the options I chose. You may have different requirements in your environment.

## Install the Posh-Git module

Now that we have the Git client installed we need to enable Git functionality for PowerShell.
[Posh-Git][06] from the Gallery. For more information about Posh-Git, see
[Posh-Git on GitHub][03]. If you have PsGet installed just run:

```powershell
Install-Module posh-git
```

Alternatively, you can install Posh-Git manually using the instructions in the README.MD in the
GitHub repository. Once Posh-Git is installed you need to integrate Git into your PowerShell
environment. Posh-Git includes an example profile script that you can adapt to your needs.

### Integrate Git into your PowerShell environment

Integrating Git into PowerShell is simple. There are three main things to do:

1. Load the Posh-Git module
1. Start the SSH Agent Service
1. Configure your prompt to show the Git status

Add the following lines to your PowerShell profile script.

```powershell
Import-Module posh-git
Start-SshAgent -Quiet
function global:prompt {
    $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = [Security.Principal.WindowsPrincipal] $identity
    $name = ($identity.Name -split '\\')[1]
    $path = Convert-Path $executionContext.SessionState.Path.CurrentLocation
    $prefix = "($env:PROCESSOR_ARCHITECTURE)"

    if($principal.IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) { $prefix = "Admin: $prefix" }
    $realLASTEXITCODE = $LASTEXITCODE
    $prefix = "Git $prefix"
    Write-Host ("$prefix[$Name]") -nonewline
    Write-VcsStatus
    ("`n$('+' * (get-location -stack).count)") + "PS $($path)$('>' * ($nestedPromptLevel + 1)) "
    $global:LASTEXITCODE = $realLASTEXITCODE
    $host.ui.RawUI.WindowTitle = "$prefix[$Name] $($path)"
}
```

The prompt function integrates Git into your PowerShell prompt to show an abbreviated `git status`.
See the [README][04] for Posh-Git for a full explanation of the abbreviated status. I have also
customize my prompt to show me my user context, whether I am running in a 64-bit or 32-bit shell,
and if I am running elevated. Customize this function to meet your needs or preferences. At this
point you are done. You can use Git from PowerShell. Go forth and clone a repo.

## Customize your Git environment

You may want to customize some of the settings of your Git environment, especially if this is a new
install of Git. Being a good project contributor in Git you should identify yourself so that Git
knows who to `blame` for your commits. Also, I found that the default colors used by Git in the
shell could be hard to read. So I customized the colors to make them more visible. For more
information, see the [Customizing Git][02] topic in the Git
documentation. The following commands only need to be run once. You are setting global preferences
so, once they are set, they are used every time you start a new shell.

```powershell
# Configure your user information to match your GitHub profile
git config --global user.name "John Doe"
git config --global user.email "alias@example.com"

# Set up the colors to improve visibility in the shell
git config --global color.ui true
git config --global color.status.changed "magenta bold"
git config --global color.status.untracked "red bold"
git config --global color.status.added "yellow bold"
git config --global color.status.unmerged "yellow bold"
git config --global color.branch.remote "magenta bold"
git config --global color.branch.upstream "blue bold"
git config --global color.branch.current "green bold"
```

As I said at the beginning, this is what works for me. Your mileage may vary. Customize this for
your preferences and environmental needs. In future articles, I plan to share scripts I have created
to help me with my Git workflow. Do you use Git with Powershell? Share your questions and
experiences in the comments.

<!-- link references -->
[01]: https://git-for-windows.github.io/
[02]: https://git-scm.com/book/en/v2/Customizing-Git-Git-Configuration
[03]: https://github.com/dahlbyk/posh-git
[04]: https://github.com/dahlbyk/posh-git/blob/master/readme.md
[05]: https://github.com/Microsoft/Git-Credential-Manager-for-Windows
[06]: https://www.powershellgallery.com/packages/posh-git
