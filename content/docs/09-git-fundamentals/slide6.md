---
title: What is a branch?
weight: 6
navWeight: 4
featured: false
draft: false
comment: false
toc: true
pinned: false
postDate: false
date: 2025-03-12
index: true
---
<!-- markdownlint-disable MD041 -->

![What is a branch?][02]

Branching means you diverge from the main line of development and continue to do work without
messing with that main line. In many VCS tools, this is a somewhat expensive process, often
requiring you to create a new copy of your source code directory, which can take a long time for
large projects.

When you make a commit, Git stores a commit object that contains a pointer to the snapshot of the
content you staged. This object also contains the author's name and email address, the message that
you typed, and pointers to the commit or commits that directly came before this commit (its parent
or parents): zero parents for the initial commit, one parent for a normal commit, and multiple
parents for a commit that results from a merge of two or more branches.

The website [Visualizing Git](https://git-school.github.io/visualizing-git/) provides a great
simulation of how branching works in Git. You can see how the commit history is represented as a
graph how branches are created and merged.

## Branch commands

- `git branch <branch-name>` - Create a new branch
- `git checkout -b <branch-name>` - Create a new branch and switch to it
- `git checkout <branch-name>` - Switch to a branch
- `git merge-base main working-branch` - Find the common ancestor of two branches
- `git merge <branch-name>` - Merge a branch into the current branch
- `git rebase <branch-name>` - Reapply commits on top of another base tip
- `git branch -d <branch-name>` - Delete a branch
- `git branch -v` - List local branches in your repository
- `git remote -vr` - List remote branches in your repository
- `git branch -all -v` - List local and remote branches in your repository

## Tools for visualizing commits

There are several tools available to visualize commits and branches in Git. The following screenshot
shows the `gitk` tool included with Git. It displays the commit history as a graph and includes the
commit message, author, date, and diffs. You can also see the branches and tags in the repository.

![Gitk][01]

- VS Code - Use the built-in Git extension to visualize commits and branches
- `git log --oneline --graph` - Show a one-line summary of each commit in a graph format
- `gitk` - Show a graphical representation of the commit history
- `tig` - Show a text-based graphical representation of the commit history

<!-- link references -->
[01]: images/gitfundamentals/s6-gitk-graph.png
[02]: images/gitfundamentals/slide6.png
