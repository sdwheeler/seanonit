---
title: Appendix - GitHub CLI commands
weight: 10
navWeight: 1
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

Many of the tasks you do in GitHub can be done using the GitHub CLI. The following list contains
GitHub CLI commands for some of the most common tasks.

## Create a new repository

The following command creates a new repository in your GitHub account.

```powershell
gh repo create <repo-name> -d 'Test repo for OnRamp class' --public --add-readme --license MIT --clone
```

- The `-d` option allows you to add a description to the repository.
- The `--public` option makes the repository public.
- The `--add-readme` option creates a README file in the new repository.
- The `--license` option adds a license to the repository.
- The `--clone` option clones the new repository to your local machine in the current location in a
  folder with the same name as the repository.

## Create a new GitHub repository from the current local repository

The following command creates a new GitHub repository from the current local repository.

```powershell
gh repo create <repo-name> -d 'Test repo for OnRamp class' --public -s . --push --remote origin
```

- The `-d` option allows you to add a description to the repository.
- The `--public` option makes the repository public.
- The `-s` option specifies the source of the repository. In this case, it is the current directory.
- The `--push` option pushes the current local repository to the new GitHub repository.
- The `--remote` option specifies the name of the remote. In this case, it is `origin`.

## Clone an existing GitHub repository

The following command clones an existing GitHub repository to your local machine.

```powershell
gh repo clone <repo-name>
```

The GH CLI will automatically create a folder with the same name as the repository in the current
directory. It also creates a remote called `origin` that points to the GitHub repository. If the
repository you cloned is a fork, it will also create a remote called `upstream` that points to the
original repository.

## Checkout a PR submitted by someone else

The following command checks out a pull request submitted by someone else.

```powershell
gh pr checkout <pr-number>
```

This command creates a new branch in your local repository with the same name as the pull request
branch and checks it out. The new branch will be based on the branch that the pull request is being
merged into. The command also creates a new remote named for the account that submitted the pull
request. This remote is used to fetch the pull request branch from the original repository. If you
have sufficient permissions, you can also push changes to the pull request branch.

## Other available commands

The GitHub CLI has many other commands that you can use to manage your GitHub repositories.

- Manage issues: `gh issue -h`
- Manage labels: `gh label -h`
- Manage pull requests: `gh pr -h`
- Manage releases: `gh release -h`
- Manage repos: `gh repo -h`

For a complete list of commands, see the
[GitHub CLI documentation][01].

The GitHub CLI also provides an extension system that allows you to add custom commands to the CLI.
The [dash][02] extension provides a text-based dashboard for your
GitHub repositories. The dashboard allows you to view issues and pull requests and perform basic
tasks.

<!-- link references -->
[01]: https://cli.github.com/manual/
[02]: https://github.com/dlvhdr/gh-dash
