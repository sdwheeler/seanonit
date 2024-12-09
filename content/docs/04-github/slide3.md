---
title: Setting up Git for PowerShell
weight: 3
navWeight: 6
featured: false
draft: false
comment: false
toc: true
pinned: false
postDate: false
date: 2023-07-05
index: true
---
<!-- markdownlint-disable MD041 -->

![Setting up Git for PowerShell][03]

## Installing Git for Windows

Download the latest version of Git for the platform you are using. There are versions for Windows,
macOS, and Linux. [https://git-scm.com/downloads][01]

The installer for Windows presents a series of pages with configuration options. The following lists
show the recommended settings for each page of the installer.

![Git for Windows installer][02]

**Select Components**

- Additional icons - optional (my preference = don't install)
- Windows Explorer integration - optional (my preference = don't install)
- Git LFS (Large File Support) - depends on your project needs (my preference = install)
- Associate .git* configuration files with the default text editor
- Associate .sh files to be run with Bash - if you are using Git bash
- Use VS Code as Git's default editor
- Check daily for Git for Windows updates - optional (my preference = install)
- (NEW!) Add a Git Bash Profile to Windows Terminal - optional (your preference)
- (NEW!) Scalar (Git add-on to manage large-scale repositories) - recommended

**Choosing the default editor used by Git**

- Use VS Code as Git's default editor

**Adjusting the name of the initial branch in new repositories**

- Override the default branch name for new repositories
  - Name = main

**Adjusting your PATH environment**

- Git from the command line and also from 3rd-party software

**Choosing the SSH executable**

- Use bundled OpenSSH - default
- Use external OpenSSH - if you have installed a different version of OpenSSH

**Choosing HTTPS transport backend**

- Use the native Windows Secure Channel library

**Configuring the line edit conversions**

- Checkout Windows-style, commit Unix-style line endings

**Configuring the terminal emulator to use with Git Bash**

- Use Windows' default console window

**Choose the default behavior of `git pull`**

- Default (Fast-forward or merge)

**Choose a credential helper**

- Git Credential Manager

**Configuring extra options**

- Enable file system caching
- Enable symbolic links

**Configuring experimental options**

- Enable experimental support for pseudo consoles
- Enable experimental built-in file system monitor

## Post installation configuration

Before working with a repository you need to configure Git with your name and email address. You can
also set the default branch name and configure Git to store your credentials. You may also want to
adjust the colors used by Git depending on the terminal settings you are using.

```powershell
git config --global user.name "FirstName LastName"
git config --global user.email "githubusername@users.noreply.github.com"
git config --global color.ui true
git config --global color.status.changed "magenta bold"
git config --global color.status.untracked "red bold"
git config --global color.status.added "red bold"
git config --global color.unmerged "yellow bold"
git config --global color.branch.remote "magenta bold"
git config --global color.branch.upstream "blue bold"
git config --global color.branch.current "green bold"
git config --global core.excludesfile ~/.gitignore
```

For more information, see the [Customizing Git][04] topic in the Git documentation.

When you are installing on Windows, the installer walks you through all the settings. If you are
installing on macOS or Linux, you need to configure the default branch name and credential manager.

```powershell
git config --global init.defaultBranch main
git config --global credential.helper store
```

### Git ignore settings

Creating the .gitignore as a global configuration ensures that you are ignoring the same files
across all repositories.

The tools you use to create and edit your content may create hidden, system, or temporary files
that you do not want Git to sync to Github. Also, you can create workspace-specific settings for VS
Code in a `.vscode` folder in your repository. This folder can contain code snippets or style sheets
that you use in VS Code for that group of content. A `.gitignore` file tells Git which files and
folders ignore for change tracking. You can create a global file in `$HOME\.gitignore`.

```ini
.vscode/

# Windows image file caches
Thumbs.db
ehthumbs.db

# Folder config file
Desktop.ini

# Recycle Bin used on file shares
$RECYCLE.BIN/

# Windows Installer files
*.cab
*.msi
*.msm
*.msp

# Windows shortcuts
*.lnk

# macOS files
.DS_Store
.AppleDouble
.LSOverride
```

<!-- link references -->
[01]: https://git-scm.com/downloads
[02]: images/github/git-install.png
[03]: images/github/slide3.png
[04]: https://git-scm.com/book/en/v2/Customizing-Git-Git-Configuration
