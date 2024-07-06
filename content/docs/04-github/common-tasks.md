---
title: Appendix - Common Git workflow tasks
weight: 8
navWeight: 1
featured: false
draft: false
comment: false
toc: true
pinned: false
postDate: false
index: true
---
<!-- markdownlint-disable MD041 -->

This Appendix describes several common tasks you might use regularly.

## Throw away an uncommitted branch and start over

1. Revert all files back to the previous commit.

   ```powershell
   git reset --hard
   ```

   This resets all files that have changed since the last commit. This is a way to undo your
   changes and get back to a known state.

## Keeping your repos in sync

1. Pull the upstream main into your working branch again.

   ```powershell
   cd C:\github
   cd C:\github\azure-docs-pr
   git checkout <main>
   git pull upstream <main>
   ```

   The checkout command ensures that you are in the default branch of your local repository. The
   pull command copies the current version of the `<main>` branch from the upstream remote into the
   currently selected branch of your local clone.

1. Push the local main branch into your fork.

   ```powershell
   git push origin main
   ```

   The push command uploads the current state of your local repository into your fork on GitHub.

   > [!NOTE]
   > While this isn't required, it's recommended as a best practice to keep your local repository
   > and your remote fork in sync with the official source repository. This is a good practice to
   > do if you have been away from working in a repository for any extended period of time.

## Deleting a branch

1. Delete branch from your fork.

   Branches should be deleted after they're merged into the official repository. This prevents
   the visual clutter of a long list of branches in your repository. These branches also get
   propagated to all forks of the repository.

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

1. Delete the local branch.

   ```powershell
   git branch -D branchName
   ```

   This prevents it from being accidentally pushed later. If the branch has unmerged changes, git
   warns you and won't delete the branch.

## Restore a file from a previous commit

For this scenario, you want to recover an older version of a file from a previous commit. First you
need to find the branch name or commit that contains the version of the file you want to restore.
You can do this by looking at the history of the file on GitHub or seaching the local git log. Then
you can restore the file from that commit.

1. Checkout the branch you want to restore the file to.

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

1. Add and commit your changes.

   ```powershell
   git add --all
   git commit -m "description of the changes"
   ```

1. Push your changes up into your fork.

   ```powershell
   git push origin mybranch
   ```

   Now your fork is in sync with your local repository. You are ready to send a pull request to have
   your changes merged into the official repository.

## Squashing a working branch

1. `git checkout <main>`
1. `git pull upstream <main>`
1. `git checkout <working-branch>`
1. `git merge-base <main> <working-branch>`

   This gets the SHA of the where we started `<working-branch>`.

1. `git rebase -i <SHA of merge-base>`

   This opens the interactive rebase editor. You can squash commits by changing `pick` to `squash`.
   When you close the editor, the rebase completes. Now you have squashed your previous commits into
   one new commit without changing the merge-base (starting point) of the branch.

   If you want to move the merge-base to the current HEAD of `<main>`, use the following command to
   rebase: `git rebase <main>`

1. `git push <remote> <working-branch> -f`

   This force push rewrites the commit history back to the `<remote>`.

## Editing someone else's PR

1. Pull their PR into a new local working branch.

   `git fetch upstream pull/<pull_request_number>/head:newbranch`

1. Checkout the new working branch
1. Make your changes
1. Submit a PR to merge your working branch into theirs

## Update local repo after master is renamed to main

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

## Find common ancestor of a branch

```powershell
# get common ancestor
git merge-base <base-branch-ref> <working-branch-ref>
```
