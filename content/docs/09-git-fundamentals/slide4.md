---
title: Tracking changes
weight: 4
navWeight: 7
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

![Tracking changes][02]

The files in your working directory can be in one of two states: tracked or untracked.

- Tracked files are files that were include in the last snapshot. They can be unmodified, modified,
  or staged. By definition, these files are tracked by the Git index (staging area).
- Untracked files are any files in your working directory that were not in your last snapshot and
  are not in your staging area. When you first clone a repository, all of your files will be tracked
  and unmodified because they were in the last snapshot. As you modify files, Git sees them as
  modified because you have changed them since your last commit. You stage these modified files and
  then commit them to save the snapshot permanently in your Git directory.

## Git commands to track changes

- `git status` - Shows the status of changes as untracked, modified, or staged
- `git add` - Adds changes to the staging area
- `git commit` - Saves the snapshot permanently in your Git directory

<!-- link references -->
[02]: images/gitfundamentals/slide4.png
