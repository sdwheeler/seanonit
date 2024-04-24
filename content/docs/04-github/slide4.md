---
title: Installing and using posh-git
weight: 4
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

## Installing posh-git

**posh-git** is a PowerShell module that integrates Git with PowerShell. It provides Git status
summary information that's displayed in a customized PowerShell prompt. **posh-git** also provides
tab completion support for git commands, branch names, paths, and more.

For more information, see:

- [`posh-git` on the PowerShell Gallery][02]
- [`posh-git` on GitHub][01]

Install `posh-git` using the following command:

```powershell
Install-Module posh-git
```

Add the following command to your profile script.

```powershell
Import-Module posh-git
```

## Using posh-git

Once **posh-git** is installed and imported, you'll see Git status summary information in your
prompt.

![Animation showing the posh-git user experience][03]

## Understanding the posh-git prompt

The Git status summary information provides a wealth of "Git status" information at a glance, all
the time in your prompt.

By default, the status summary has the following format:

```
[{HEAD-name} S +A ~B -C !D | +E ~F -G !H W]
```

- `[` (`BeforeStatus`)
- `{HEAD-name}` is the current branch, or the SHA of a detached HEAD
  - Cyan means the branch matches its remote
  - Green means the branch is ahead of its remote (green light to push)
  - Red means the branch is behind its remote
  - Yellow means the branch is both ahead of and behind its remote
- `S` represents the branch status in relation to the remote (tracked origin) branch.

  Note: This status information reflects the state of the remote tracked branch after the last
  `git fetch/pull` of the remote. Execute `git fetch` to update to the latest on the default remote
  repo. If you have multiple remotes, execute `git fetch --all`.

  - `≡` = The local branch is at the same commit level as the remote branch
    (`BranchIdenticalStatus`)
  - `↑<num>` = The local branch is ahead of the remote branch by the specified number of commits; a
    `git push` is required to update the remote branch (`BranchAheadStatus`)
  - `↓<num>` = The local branch is behind the remote branch by the specified number of commits; a
    `git pull` is required to update the local branch (`BranchBehindStatus`)
  - `<a>↕<b>` = The local branch is both ahead of the remote branch by the specified number of
    commits (a) and behind by the specified number of commits (b); a rebase of the local branch is
    required before pushing local changes to the remote branch (`BranchBehindAndAheadStatus`). NOTE:
    this status is only available if `$GitPromptSettings.BranchBehindAndAheadDisplay` is set to
    `Compact`.
  - `×` = The local branch is tracking a branch that is gone from the remote (`BranchGoneStatus`)
- `ABCD` represent the index; `|` (`DelimStatus`); `EFGH` represent the working directory
  - `+` = Added files
  - `~` = Modified files
  - `-` = Removed files
  - `!` = Conflicted files
  - As with `git status` output, index status is displayed in dark green and working directory
    status in dark red

- `W` represents the overall status of the working directory
  - `!` = There are unstaged changes in the working tree (`LocalWorkingStatusSymbol`)
  - `~` = There are uncommitted changes i.e. staged changes in the working tree waiting to be
    committed (`LocalStagedStatusSymbol`)
  - None = There are no unstaged or uncommitted changes to the working tree
    (`LocalDefaultStatusSymbol`)
- `]` (`AfterStatus`)

The symbols and surrounding text can be customized by the corresponding properties on
`$GitPromptSettings`.

For example, a status of `[main ≡ +0 ~2 -1 | +1 ~1 -0]` corresponds to the following `git status`:

```powershell
# On branch main
#
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#        modified:   this-changed.txt
#        modified:   this-too.txt
#        deleted:    gone.ps1
#
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working directory)
#
#        modified:   not-staged.ps1
#
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#        new.file
```

<!-- link references -->
[01]: https://github.com/dahlbyk/posh-git
[02]: https://www.powershellgallery.com/packages/posh-git
[03]: images/github/using-posh-git.gif
