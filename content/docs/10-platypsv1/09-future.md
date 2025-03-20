---
title: Future roadmap?
weight: 9
navWeight: 2
featured: false
draft: false
comment: false
toc: true
pinned: false
postDate: false
date: 2025-03-18
index: true
---
<!-- markdownlint-disable MD041 -->

![Future roadmap?][01]

The **Microsoft.PowerShell.PlatyPS** module is still a work in progress.

At this time, we have no target date for the GA release. We have to meet the needs of our internal
partners first. We are working on shipping a quality product. There are several features that need
to be completed before we can ship. Until we get to a GA release, we aren't taking any feature
requests or code contributions. We welcome bug reports for the currently implemented features.

- Features that need to be finished
  - Fix MAML rendering and testing
  - Fix YAML conversion bugs
  - Fix CAB/ZIP file creation to support updateable help

- Potential improvements we are considering after the GA release
  - Add more metadata discovery (e.g. validation attributes and values)
  - Improve diagnostics and reporting
  - Localization support
  - Support for more structured formats

- Things to investigate
  - Conversion to other formats such as HTML
  - Can we create a formatter that outputs `Get-Help` objects?
  - Can we make Help use markdown-based content?

<!-- link references -->
[01]: images/platypsv1/09-future.png
