---
title: Lab 3 - Fork and clone a repository
weight: 9
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

If you want to contribute to someone else's project but don't have write access to the repository,
you can use a "fork and pull request" workflow.

GitHub flow is a lightweight, branch-based workflow. The GitHub flow is useful for everyone, not
just developers. The GitHub documentation has a good overview of the process and the reasons for
using it. See [GitHub flow][01].

In this lab, you will pair up with another student to practice the GitHub flow.

1. Fork and clone their repository.
1. Create a new branch.
1. Add a new file to the repository.
1. Commit the changes.
1. Push the changes to your fork.
1. Submit a pull request to the original repository.

![GitHub workflow][02]

The steps shown in red are a one-time action for each new repository you
fork.

| Steps |       Description of steps        |                                                                                         Git command / GitHub actions                                                                                          |
| :---: | --------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|   A   | Fork the repo                     | Browse to `https://github.com/<thierusername>/GitFun` and select the **Fork** button (top right). Open the **Choose and owner** dropdown and select your personal account. Select the **Create fork** button. |
|   B   | Clone the repo (once per machine) | `git clone https://github.com/<myusername>/GitFun.git`                                                                                                                                                        |
|   C   | Add the upstream remote           | `git remote add upstream https://github.com/<theirusername>/GitFun.git`                                                                                                                                       |

Alternatively, you can use the GitHub CLI to clone the repository. See
[Appendix - GitHub CLI commands][03].

The numbered steps (in black) are described in the table below.

| Steps |     Description of steps     |                                                                                                                                               Git command / GitHub actions                                                                                                                                               |
| :---: | ---------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
|   0   | Checkout the main branch     | `git checkout main`                                                                                                                                                                                                                                                                                                      |
|   1   | Sync the main branch         | `git pull upstream main; git push origin main`                                                                                                                                                                                                                                                                           |
|   2   | Create a new working branch  | `git checkout -b my-new-branch`                                                                                                                                                                                                                                                                                          |
|   3   | Create new content           | Use VS Code to create or edit files                                                                                                                                                                                                                                                                                      |
|   4   | Add changes for Git tracking | `git add -A`                                                                                                                                                                                                                                                                                                             |
|   5   | Commit changes to local repo | `git commit -m 'commit message'`                                                                                                                                                                                                                                                                                         |
|   6   | Push working branch to fork  | `git push origin my-new-branch`                                                                                                                                                                                                                                                                                          |
|   7   | Submit pull request          | Go to `https://github.com/<thierusername>/GitFun/pulls` and click the **New pull request** button.<br><br>`Base repository: MicrosoftDocs/PowerShell-Docs` `base: main` **<--** `head repository: username/PowerShell-Docs` `compare: my-new-branch` <br><br>Fill out the pull request description and click **Submit**. |
|   8   | PR is reviewed               | Make the necessary changes based on the review feedback.                                                                                                                                                                                                                                                                 |
|   9   | PR is merged                 | Go to step 10                                                                                                                                                                                                                                                                                                            |
|  10   | Cleanup unneeded branch info | `git checkout main; git push origin --delete my-new-branch; git branch -D my-new-branch`<br><br>The `git push` command deletes the branch in your fork and deletes the tracking branch from your local repo. The `git branch` command deletes the branch from your local repo.                                           |
|  11   | Start new change             | Go to step 0                                                                                                                                                                                                                                                                                                             |

<!-- link references -->
[01]: https://docs.github.com/en/get-started/quickstart/github-flow
[02]: images/gitfundamentals/s9-github-flow.png
[03]: ../slide10-appendix/#clone-an-existing-github-repository
