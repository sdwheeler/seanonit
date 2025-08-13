---
title: What is Git?
weight: 2
navWeight: 9
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

![What is Git?][02]

## What is Git?

In 2005, Linus Torvalds, the creator of Linux, needed to replace the version control system used to
manage the source code of the Linux kernel. He, and the Linux community, created Git. Some of the
goals of the new system included:

- Speed
- Simple design
- Strong support for non-linear development (thousands of parallel branches)
- Fully distributed Able to handle large projects like the Linux kernel efficiently (speed and data
  size)

## Git is distributed

- Nearly every operation is local
- In centralized version control system (CVCS), you must connect to the central store to access and
  update the history. With Git you have the entire history of the project right there on your local
  disk, most operations seem almost instantaneous.
- This also means that there is very little you can't do if you're offline. If you get on an
  airplane or a train and want to do a little work, you can commit to your local copy until you get
  to a network connection to upload. If you go home and can't get your VPN client working properly,
  you can still work.

## Git is safe

Integrity

- Git uses SHA-1 hashes of data to verify integrity
- The SHA-1 hash is used to identify every object in the database

Git only adds data

- Nearly every operation adds information to the database
- It's nearly impossible to delete anything
- This allows you to easily recover a previous state

<!-- link references -->
[02]: images/gitfundamentals/slide2.png
