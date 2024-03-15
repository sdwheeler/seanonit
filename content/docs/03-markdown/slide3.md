---
archetype: presentations
title: Flavors of Markdown
navWeight: 4
weight: 3
featured: false
draft: false
comment: false
toc: true
pinned: false
postDate: false
index: true
---

![Flavors of Markdown][01]

## The importance of standardization

As previously mentioned. Gruber's [initial description][03] of Markdown contained ambiguities and
omissions, but the idea of Markdown was very popular. Soon, different platforms create thier own
implementations of Markdown. Those implementations quickly diverged since there was no real standard
to follow and they wanted to add features to meet there specific needs.

In 2014, a group of long-standing Markdown contributors formed a committee to create CommonMark,
an unambiguous specification and test suite for Markdown. This was an attempt to standardize the
language and make it more consistent across different platforms.

Today, [CommonMark][02] and [GitHub-flavored Markdown (GFM)][04] are the most widely used
implementations of Markdown. GFM is a superset of CommonMark with a few additional features that are
specific to GitHub. In most cases, platforms that support Markdown base their implementations on
CommonMark and add popular features as extensions.

## Extensions

While CommonMark does a good job of standardizing the language, it doesn't cover every feature that
you may want from a markup language. Some of the most popular extensions to CommonMark are:

- Tables
- Extra emphasis - strike through, subscript & superscript
- Special class attributes (HTML attributes)
- Definition lists and footnotes
- Task Lists (from GFM)
- Alpha and Roman numbers for ordered lists
- Media support for youtube, etc.
- Abbreviations
- Custom containers blocks
- Figures & Mathematics/Latex extensions
- Emoji support
- YAML Front Matter

The Microsoft Learn documentation platform uses the [Markdig][05] library to render Markdown.
Markdig is a .NET library that implements CommonMark and several popular extensions. It also
provides a framework to add more extensions.

<!-- link references -->
[01]: images/markdown/slide3.png
[02]: https://commonmark.org
[03]: https://daringfireball.net/projects/markdown/syntax
[04]: https://docs.github.com/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax
[05]: https://github.com/xoofx/markdig
