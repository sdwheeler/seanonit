---
title: Appendix - Glossary and common tasks
weight: 12
navWeight: 12
featured: false
draft: false
comment: false
toc: true
pinned: false
postDate: false
date: 2026-04-04
index: true
---
<!-- markdownlint-disable MD041 -->

This appendix contains useful reference information for common Git and GitHub tasks, as well as
GitHub CLI commands for automation.

## Terminology

- **Fork** - a clone of a repository hosted on a Git server. We use the GitHub server. You only need
  to fork a repo once in your GitHub account.
- **Origin** - an alias for your fork on GitHub
- **Upstream** - an alias you create for the source of your fork (the original repository)
- **Clone** - a copy of a repository on your local machine. This should be a copy of your fork. You
  only need to clone your fork once per PC you use it on.
- **Branch** (Working Branch) - a logical workspace for changing content within your local clone
- **Pull** - the operation to update your local repository with latest version from a remote
  repository (fetch & merge). For a forked repo workflow, the remote repository will be the upstream
  repository.
- **Push** - the operation to write the changes you made back into a remote repository. In our case,
  the remote repository will always be the origin repository (your fork or your own repo).
- **Fetch** - gets the latest version of the files and changes that you don't have locally
- **Merge** - merges the current changes into your local repository

## Common Git workflow tasks

### Throw away an uncommitted branch and start over

Revert all files back to the previous commit:

```powershell
git reset --hard
```

This resets all files that have changed since the last commit. This is a way to undo your changes
and get back to a known state.

### Keeping your repos in sync

1. Pull the upstream main into your working branch:

   ```powershell
   cd C:\github\azure-docs-pr
   git checkout main
   git pull upstream main
   ```

   The checkout command ensures that you are in the default branch of your local repository. The
   pull command copies the current version of the `main` branch from the upstream remote into the
   currently selected branch of your local clone.

1. Push the local main branch into your fork:

   ```powershell
   git push origin main
   ```

   The push command uploads the current state of your local repository into your fork on GitHub.

   > [!NOTE]
   > While this isn't required, it's recommended as a best practice to keep your local repository
   > and your remote fork in sync with the official source repository. This is a good practice to
   > do if you have been away from working in a repository for any extended period of time.

### Deleting a branch

Branches should be deleted after they're merged into the official repository. This prevents the
visual clutter of a long list of branches in your repository.

1. Delete branch from your fork:

   ```powershell
   git push origin --delete branchName
   ```

   This updates your fork by telling it to delete the branch from the repository in GitHub.
   Depending on how you create a branch there may be a remote tracking branch. This happens
   automatically for `main` when you clone. If the branch has a remote tracking branch, it is
   deleted as well.

   If the branch has been deleted from your fork already or if you need to delete a tracking branch
   without deleting the branch from your fork, use the following commands:

   ```powershell
   # List remote tracking branches
   git branch -vr

   # Delete the remote tracking branch
   git branch -Dr origin/branchName
   ```

1. Delete the local branch:

   ```powershell
   git branch -D branchName
   ```

   This prevents it from being accidentally pushed later. If the branch has unmerged changes, git
   warns you and won't delete the branch.

### Restore a file from a previous commit

For this scenario, you want to recover an older version of a file from a previous commit. First you
need to find the branch name or commit that contains the version of the file you want to restore.
You can do this by looking at the history of the file on GitHub or searching the local git log. Then
you can restore the file from that commit.

1. Checkout the branch you want to restore the file to:

   ```powershell
   git checkout mybranch
   ```

1. Restore the previous version with the following command:

   ```syntax
   git checkout <branchname or SHA of commit> -- <path to file>
   ```

   For example:

   ```powershell
   git checkout 9eab620 -- relative-path\filename.md
   ```

   Now the file has been restored. You can use this same checkout process to restore any number of
   files. This could be useful if you accidentally deleted files and need them restored.

1. Update the file using VS Code, as necessary.

1. Add and commit your changes:

   ```powershell
   git add --all
   git commit -m "description of the changes"
   ```

1. Push your changes up into your fork:

   ```powershell
   git push origin mybranch
   ```

   Now your fork is in sync with your local repository. You are ready to send a pull request to have
   your changes merged into the official repository.

### Squashing a working branch

1. `git checkout main`
1. `git pull upstream main`
1. `git checkout <working-branch>`
1. `git merge-base main <working-branch>`

   This gets the SHA of the where we started `<working-branch>`.

1. `git rebase -i <SHA of merge-base>`

   This opens the interactive rebase editor. You can squash commits by changing `pick` to `squash`.
   When you close the editor, the rebase completes. Now you have squashed your previous commits into
   one new commit without changing the merge-base (starting point) of the branch.

   If you want to move the merge-base to the current HEAD of `main`, use the following command to
   rebase: `git rebase main`

1. `git push <remote> <working-branch> -f`

   This force push rewrites the commit history back to the `<remote>`.

### Editing someone else's PR

1. Pull their PR into a new local working branch:

   `git fetch upstream pull/<pull_request_number>/head:newbranch`

1. Checkout the new working branch
1. Make your changes
1. Submit a PR to merge your working branch into theirs

### Update local repo after master is renamed to main

```powershell
# Update local repo after master is renamed to main
# Go to the master branch
git checkout master
# Rename master to main locally
git branch -m master main
# Get the latest commits from the server
git fetch
# Remove the link to origin/master
git branch --unset-upstream
# Add a link to origin/main
git branch -u origin/main
# Update the default branch to be origin/main
git symbolic-ref refs/remotes/origin/HEAD refs/remotes/origin/main
# push main to your fork
git push origin main
# delete master from your fork
git push origin --delete master
```

### Find common ancestor of a branch

```powershell
# get common ancestor
git merge-base <base-branch-ref> <working-branch-ref>
```

## GitHub CLI commands

Many of the tasks you do in GitHub can be done using the GitHub CLI. The following list contains
GitHub CLI commands for some of the most common tasks.

### Create a new repository

The following command creates a new repository in your GitHub account:

```powershell
gh repo create <repo-name> -d 'Test repo for OnRamp class' --public --add-readme --license MIT --clone
```

- The `-d` option allows you to add a description to the repository.
- The `--public` option makes the repository public.
- The `--add-readme` option creates a README file in the new repository.
- The `--license` option adds a license to the repository.
- The `--clone` option clones the new repository to your local machine in the current location in a
  folder with the same name as the repository.

### Create a new GitHub repository from the current local repository

The following command creates a new GitHub repository from the current local repository:

```powershell
gh repo create <repo-name> -d 'Test repo for OnRamp class' --public -s . --push --remote origin
```

- The `-d` option allows you to add a description to the repository.
- The `--public` option makes the repository public.
- The `-s` option specifies the source of the repository. In this case, it is the current directory.
- The `--push` option pushes the current local repository to the new GitHub repository.
- The `--remote` option specifies the name of the remote. In this case, it is `origin`.

### Clone an existing GitHub repository

The following command clones an existing GitHub repository to your local machine:

```powershell
gh repo clone <repo-name>
```

The GH CLI will automatically create a folder with the same name as the repository in the current
directory. It also creates a remote called `origin` that points to the GitHub repository. If the
repository you cloned is a fork, it will also create a remote called `upstream` that points to the
original repository.

### Checkout a PR submitted by someone else

The following command checks out a pull request submitted by someone else:

```powershell
gh pr checkout <pr-number>
```

This command creates a new branch in your local repository with the same name as the pull request
branch and checks it out. The new branch will be based on the branch that the pull request is being
merged into. The command also creates a new remote named for the account that submitted the pull
request. This remote is used to fetch the pull request branch from the original repository. If you
have sufficient permissions, you can also push changes to the pull request branch.

### Other available commands

The GitHub CLI has many other commands that you can use to manage your GitHub repositories:

- Manage issues: `gh issue -h`
- Manage labels: `gh label -h`
- Manage pull requests: `gh pr -h`
- Manage releases: `gh release -h`
- Manage repos: `gh repo -h`

For a complete list of commands, see the [GitHub CLI documentation][01].

The GitHub CLI also provides an extension system that allows you to add custom commands to the CLI.
The [dash][06] extension provides a text-based dashboard for your GitHub repositories. The dashboard
allows you to view issues and pull requests and perform basic tasks.

## Resources

- [Git documentation][05]
- [GitHub documentation][02]
- [Pro Git book][04]
- [GitHub Skills][08]
- [Visualizing Git][03]
- [Demo scripts used in this presentation][07]

<!-- link references -->
[01]: https://cli.github.com/manual/
[02]: https://docs.github.com/
[03]: https://git-school.github.io/visualizing-git/
[04]: https://git-scm.com/book/en/v2
[05]: https://git-scm.com/doc
[06]: https://github.com/dlvhdr/gh-dash
[07]: https://github.com/sdwheeler/seanonit/blob/main/content/downloads/gitfun/gitfun-demo.ps1
[08]: https://skills.github.com/
