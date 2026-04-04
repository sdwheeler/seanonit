---
title: GitHub workflow for collaboration
weight: 10
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

GitHub provides different workflows depending on whether you own the repository or are contributing
to someone else's project. Understanding these workflows is essential for collaborating effectively
on GitHub.

## GitHub flow

GitHub flow is a lightweight, branch-based workflow. The GitHub flow is useful for everyone, not
just developers. The GitHub documentation has a good overview of the process and the reasons for
using it. See [GitHub flow][03].

The basic GitHub flow consists of:

1. Create a branch from main
1. Make changes and commit them
1. Push the branch to GitHub
1. Create a pull request
1. Review and discuss changes
1. Merge the pull request
1. Delete the branch

## Workflow for a forked repository

If you want to contribute to someone else's project but don't have write access to the repository,
you can use a "fork and pull request" workflow. This is the standard way to contribute to open
source projects.

The following image illustrates the workflow for using Git and GitHub to update files in a forked
repository. The steps shown in red are a one-time action for each new repository you fork.

![Forked repository GitHub workflow][04]

| Steps |       Description of steps        |                                                                                              Git command / GitHub actions                                                                                              |
| :---: | --------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|   A   | Fork the repo                     | Browse to the repository on GitHub and select the **Fork** button (top right). Open the **Choose an owner** dropdown and select your personal account. Select the **Create fork** button.                             |
|   B   | Clone the repo (once per machine) | `git clone https://github.com/<your-account>/<repository-name>.git`                                                                                                                                                   |
|   C   | Add the upstream remote           | `git remote add upstream https://github.com/<original-owner>/<repository-name>.git`                                                                                                                                   |

For a full discussion of forking, see [Contributing to projects][02] in the GitHub documentation.

The numbered steps (in black) are described in the table below.

| Steps |     Description of steps     |                                                                                                                                                  Git command / GitHub actions                                                                                                                                                   |
| :---: | ---------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|   0   | Checkout the main branch     | `git checkout main`                                                                                                                                                                                                                                                                                                             |
|   1   | Sync the main branch         | `git pull upstream main; git push origin main`                                                                                                                                                                                                                                                                                  |
|   2   | Create a new working branch  | `git checkout -b my-new-branch`                                                                                                                                                                                                                                                                                                 |
|   3   | Create new content           | Use VS Code to create or edit files                                                                                                                                                                                                                                                                                             |
|   4   | Add changes for Git tracking | `git add -A`                                                                                                                                                                                                                                                                                                                    |
|   5   | Commit changes to local repo | `git commit -m 'commit message'`                                                                                                                                                                                                                                                                                                |
|   6   | Push working branch to fork  | `git push origin my-new-branch`                                                                                                                                                                                                                                                                                                 |
|   7   | Submit pull request          | Go to the original repository's pull request page and click the **New pull request** button.<br><br>`Base repository: original-owner/repository-name` `base: main` **<--** `head repository: your-account/repository-name` `compare: my-new-branch` <br><br>Fill out the pull request description and click **Submit**.         |
|   8   | PR is reviewed               | Make the necessary changes based on the review feedback.                                                                                                                                                                                                                                                                        |
|   9   | PR is merged                 | Go to step 10                                                                                                                                                                                                                                                                                                                   |
|  10   | Cleanup unneeded branch info | `git checkout main; git push origin --delete my-new-branch; git branch -D my-new-branch`<br><br>The `git push` command deletes the branch in your fork and deletes the tracking branch from your local repo. The `git branch` command deletes the branch from your local repo.                                                  |
|  11   | Start new change             | Go to step 0                                                                                                                                                                                                                                                                                                                    |

---

[**Next &#x23ED;**][01]

<!-- link references -->
[01]: ../11-lab3
[02]: https://docs.github.com/get-started/exploring-projects-on-github/contributing-to-a-project
[03]: https://docs.github.com/get-started/quickstart/github-flow
[04]: images/source-control/10-gitflow-collab.png
