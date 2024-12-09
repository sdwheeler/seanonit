---
title: Glossary & FAQ
weight: 7
navWeight: 2
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
## Terminology

- **Fork** - a clone of a repository hosted on a Git server. We use the GitHub server. You only need to
  fork a repo once in your GitHub account.

- **Origin** - an alias for your fork on GitHub

- **Upstream** - an alias you create for the source of your fork (the original Microsoft repository)

- **Clone** - a copy of a repository on your local machine. This should be a copy of your Fork. You
  only need to clone your fork once per PC you use it on.

- **Branch** (Working Branch) - a logical workspace for changing content within your local clone

- **Working directory** - a physical workspace on disk containing your content files and folders

- **Pull** - the operation to update your local repository with latest version from a remote repository
  (fetch & merge). In our case, the remote repository will always be the upstream repository.

- **Push** - the operation to write the changes you made back into a remote repository. In our case,
  the remote repository will always be the origin repository (your fork).

- **Fetch** - gets the latest version of the files and changes that you don't have locally

- **Merge** - merges the current changes into your local repository

- **Index** - Git metadata used to track files and the git objects that represent the changes. The Add
  command adds files to the index so that changes can be tracked.

- **Object store** - Git metadata containing the four git objects (blob, tree, commit, and tag)

## GitHub hierarchy

- Organization/Account (examples: Azure, Microsoft, MicrosoftDocs, PowerShell, sdwheeler)
  - Repository (example: PowerShell-Docs, SystemCenterDocs-pr, )
    - Branch (example: main)
  - Fork - a clone of a repository in your GitHub account
    - Branch (example: main)
    - Branch (example: workingbranch)

### Forks and why you need one

- A Fork is a clone of a repository hosted on GitHub in your personal account.
  - Your fork is also, yet another backup of the main repository. This is a key feature of a
    distributed version control system.
  - If your local disk crashed causing you to lose your local repo, you can always clone your fork
    to another computer and work from there.
- You don't have rights to write (push) to the official repository. You must send a Pull Request.
  Then the admins of the official repository will fetch the branch from your fork and merge it into
  the `main` branch of the official repository. This protects the official repository as the source
  of truth for all content.
- You aren't running a git service. GitHub can't pull from the clone on your local machine. You
  must push your changed into your remote fork on GitHub.

### Branches and why you need them

- Git stores data as a collection of snapshots that contain the changes you made. A Branch is a
  named label for that snapshot collection.
  - When you commit your changes, Git stores a commit object that contains a pointer to the snapshot
    of the staged content, the author, and the description of the commit.
  - Creating a new branch gives you a new working context within Git to make your changes without
    affecting the `main` branch.
  - Later, your working branch can be merged back into `main`, deleted, or kept indefinitely as a
    separate release path.

- A branch is **NOT** a folder on your local file system.
  - When you check out a branch, Git changes the files in the file system to match the versions in
    that branch's snapshot.
  - Git allows you to switch branches, safely, without losing any of the work you had done.
  - If you switch branches, the current state of the branch is stashed in the Git object store and
    the files on disk are changed to match the state of the new branch you switched to. As a
    result, if you check out different branches, you can literally watch the file system change as
    Git changes it to match the state of the branch.

- What's a **tracking branch**?
  - The `main` branch is created as a tracking branch for `origin/main` when you clone a repo.
  - You can create a tracking branch using the following command:

    `git checkout -b <branch> -t <remotename/branch>`

  - When you have a tracking branch set up, git pull will look up what server and branch your
    current branch is tracking, fetch from that server and then try to merge that into your local
    branch.

## Git Object Model

A git repository is defined by the data stored in the hidden `.git` folder on the local file system
in the root folder of the repository. Git tracks the state of the repository in a database called
`index` and collection of files and folders known as the git object store.
