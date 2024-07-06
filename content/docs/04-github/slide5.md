---
title: GitHub workflow for a forked repository
weight: 5
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

GitHub flow is a lightweight, branch-based workflow. The GitHub flow is useful for everyone, not
just developers.

The GitHub documentation has a good overview of the process and the reasons for using it. See
[GitHub flow][02]. If you want to contribute to someone else's project but don't have write access
to the repository, you can use a "fork and pull request" workflow.

The following image illustrates the workflow for using Git and GitHub to update files in the
PowerShell-Docs repository. The steps shown in red are a one-time action for each new repository you
fork.

![Blog GitHub workflow][03]

| Steps |       Description of steps        |                                                                                              Git command / GitHub actions                                                                                              |
| :---: | --------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|   A   | Fork the repo                     | Browse to `https://github.com/PowerShell-Docs/PowerShell-Docs` and select the **Fork** button (top right). Open the **Choose and owner** dropdown and select your personal account. Select the **Create fork** button. |
|   B   | Clone the repo (once per machine) | `git clone https://github.com/<your-account>/PowerShell-Docs.git`                                                                                                                                                      |
|   C   | Add the upstream remote           | `git remote add upstream https://github.com/PowerShell-Docs/PowerShell-Docs.git`                                                                                                                                       |

For a full discussion of forking, see [Contributing to projects][01] in the GitHub documentation.

The numbered steps (in black) are described in the table below.

| Steps |     Description of steps     |                                                                                                                                                  Git command / GitHub actions                                                                                                                                                   |
| :---: | ---------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|   0   | Checkout the main branch     | `git checkout main`                                                                                                                                                                                                                                                                                                             |
|   1   | Sync the main branch         | `git pull upstream main; git push origin main`                                                                                                                                                                                                                                                                                  |
|   2   | Create a new working branch  | `git checkout -b workingbranch`                                                                                                                                                                                                                                                                                                 |
|   3   | Create new content           | Use VS Code to create or edit files                                                                                                                                                                                                                                                                                             |
|   4   | Add changes for Git tracking | `git add -A`                                                                                                                                                                                                                                                                                                                    |
|   5   | Commit changes to local repo | `git commit -m 'commit message'`                                                                                                                                                                                                                                                                                                |
|   6   | Push working branch to fork  | `git push origin workingbranch`                                                                                                                                                                                                                                                                                                 |
|   7   | Submit pull request          | Go to `https://github.com/MicrosoftDocs/PowerShell-Docs/pulls` and click the **New pull request** button.<br><br>`Base repository: MicrosoftDocs/PowerShell-Docs` `base: main` **<--** `head repository: username/PowerShell-Docs` `compare: workingbranch` <br><br>Fill out the pull request description and click **Submit**. |
|   8   | PR is reviewed               | Make the necessary changes based on the review feedback.                                                                                                                                                                                                                                                                        |
|   9   | PR is merged                 | Go to step 10                                                                                                                                                                                                                                                                                                                   |
|  10   | Cleanup unneeded branch info | `git checkout main; git push origin --delete workingbranch; git branch -D workingbranch`<br><br>The `git push` command deletes the branch in your fork and deletes the tracking branch from your local repo. The `git branch` command deletes the branch from your local repo.                                                  |
|  11   | Start new change             | Go to step 0                                                                                                                                                                                                                                                                                                                    |

<!-- link references -->
[01]: https://docs.github.com/en/get-started/quickstart/contributing-to-projects
[02]: https://docs.github.com/en/get-started/quickstart/github-flow
[03]: images/github/PowerShell-Docs-gitflow.png
