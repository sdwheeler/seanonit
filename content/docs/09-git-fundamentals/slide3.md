---
title: Git's three states
weight: 3
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

![Git's 3 states][02]

The _working directory_ is a single checkout of one version of the project. These files are pulled
out of the compressed database in the `.git` directory and placed on disk for you to use or modify.

The _staging area_ is a file, generally contained in your Git directory, that stores information
about what will go into your next commit. Its technical name in Git parlance is the _index_. The
`.git` directory is where Git stores the metadata and object database for your project. This is the
most important part of Git. It's what is copied when you clone a repository from another computer.

The basic Git workflow goes something like this:

1. You modify files in your working tree.
1. You selectively stage just those changes you want to be part of your next commit, which adds only
   those changes to the staging area.
1. You do a commit, which takes the files as they are in the staging area and stores that snapshot
   permanently to your `.git` directory.

<!-- link references -->
[02]: images/gitfundamentals/slide3.png
