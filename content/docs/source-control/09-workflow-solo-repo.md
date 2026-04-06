---
title: GitHub workflow for a solo project
weight: 9
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
using it. See [GitHub flow][02].

The basic GitHub flow consists of:

1. Create a branch from main
1. Make changes and commit them
1. Push the branch to GitHub
1. Create a pull request
1. Review and discuss changes
1. Merge the pull request
1. Delete the branch

## Workflow for a single repository

When you own a repository or have write access to it, you can use a simpler workflow. The following
image illustrates the workflow for using Git and GitHub to add or change content using a working
branch for a single repository. The step shown in red is a one-time action for each machine you work
on. The numbered steps (in black) are described in the table below.

![Single clone GitHub workflow][03]

| Steps |       Description of steps        |                                                                                                                                                   Git command / GitHub actions                                                                                                                                                   |
| :---: | --------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|   A   | Clone the repo (once per machine) | `git clone https://github.com/<your-account>/sdwGitFun`                                                                                                                                                                                                                                                                    |
|   0   | Checkout the main branch          | `git checkout main`                                                                                                                                                                                                                                                                                                              |
|   1   | Sync the main branch              | `git pull origin main`                                                                                                                                                                                                                                                                                                           |
|   2   | Create a new working branch       | `git checkout -b v1release`                                                                                                                                                                                                                                                                                                      |
|   3   | Create new content                | Use VS Code to create or edit files                                                                                                                                                                                                                                                                                              |
|   4   | Add changes for Git tracking      | `git add -A`                                                                                                                                                                                                                                                                                                                     |
|   5   | Commit changes to local repo      | `git commit -m 'commit message'`                                                                                                                                                                                                                                                                                                 |
|   6   | Push working branch to origin     | `git push origin v1release`                                                                                                                                                                                                                                                                                                      |
|   7   | Submit pull request               | Go to `https://github.com/<your-account>/sdwGitFun/pulls` and click the **New pull request** button.<br><br> `Base repository: your-account/sdwGitFun` `base: main` **<--** `head repository: your-account/sdwGitFun` `compare: v1release` <br><br>Fill out the pull request description and click **Submit**. |
|   8   | PR is reviewed                    | Make the necessary changes based on the review feedback.                                                                                                                                                                                                                                                                         |
|   9   | PR is merged                      | Go to step 10                                                                                                                                                                                                                                                                                                                    |
|  10   | Cleanup unneeded branch info      | `git checkout main; git push origin --delete v1release; git branch -D v1release`<br><br>The `git push` command deletes the branch in your fork and deletes the tracking branch from your local repo. The `git branch` command delete the branch from your local repo.                                                            |
|  11   | Start new change                  | Go to step 0                                                                                                                                                                                                                                                                                                                     |

---

[**Next &#x1F846;**][01]

<!-- link references -->
[01]: ../10-workflow-collab-repo
[02]: https://docs.github.com/get-started/quickstart/github-flow
[03]: images/source-control/09-gitflow-solo.png
