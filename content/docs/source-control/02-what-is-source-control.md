---
title: Source Control using Git and GitHub
weight: 2
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

![What are Git and GitHub?][03]

## What are Git and GitHub?

In 2005, Linus Torvalds, the creator of Linux, needed to replace the version control system used to
manage the source code of the Linux kernel. He, and the Linux community, created Git. Some of the
goals of the new system included:

- Speed
- Simple design
- Strong support for non-linear development (thousands of parallel branches)
- Fully distributed Able to handle large projects like the Linux kernel efficiently (speed and data
  size)

Git is a distributed version control system, or DVCS, that tracks the history of changes as people
and teams collaborate on projects together. As developers make changes to the project, any earlier
version of the project can be recovered at any time. In a DVCS, every developer has a full copy of
the project and project history. Unlike once popular centralized version control systems, DVCSs
don't need a constant connection to a central repository.

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

## What is GitHub?

GitHub hosts Git repositories and provides developers with tools to ship better code through command
line features, issues (threaded discussions), pull requests, and code review. GitHub builds
collaboration directly into the development process. Work is organized into repositories where
developers can outline requirements or direction, set expectations for team members, and use pull
requests to manage changes and feedback. This makes it easy to collaborate across teams and keep
everyone on the same page.

GitHub is a platform that:

- Hosts Git repositories in the cloud
- Provides a web interface for browsing repositories
- Enables collaboration through pull requests and code reviews
- Offers issue tracking and project management tools
- Supports team workflows with permissions and access controls

(source: [GitHub Docs][02])

---

[**Next &#x1F846;**][01]

<!-- link references -->
[01]: ../03-git-states
[02]: https://docs.github.com/get-started/using-git/about-git
[03]: images/source-control/02-what-are-git-github.png
