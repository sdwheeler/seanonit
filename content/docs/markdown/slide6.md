---
archetype: presentations
title: Best practices
navWeight: 1
weight: 6
featured: false
draft: false
comment: false
toc: true
pinned: false
postDate: false
date: 2024-04-01
index: true
---
![Best practices][01]

## Simple but confusing

The Markdown specification has very liberal rules about how the various blocks and spans can be
formatted. This makes it easier for authors to write without having to think about rules. But it can
also lead to some confusion and unexpected rendering problems.

For example, to markup a bold span you surround the text with two asterisks (`*`) or two underscores
(`_`). If you want italics, you use the same characters but only one of them. So, as an editor, if
you see unbalanced `*` or `_` characters, you don't know if the original intent of the author is for
bold or italics.

As a best practice, choose one style and stick with it. Also, to help with intent, the standard for
PowerShell documentation is to only use `*` for bold and `_` for italics.

The asterisk is also used for unordered lists, but you can also use `-` or `+`. To avoid confusion,
we chose to only use `-` for unordered lists in PowerShell documentation.

## Consistency is key

If you are writing a document with multiple authors, it is important to agree on a style guide. This
helps ensure that your documents are consistent and easy to read. Mixing styles of bullet points,
emphasis, and other elements looks messy and can be confusing to the reader.

If you are contributing to an existing project, follow the style prescribed by the project. For
example, you can find the PowerShell style guide in our public documentation:

- [PowerShell-Docs style guide][04]
- [Editorial checklist][03]

If you are using Markdown in your on project, borrow an existing style guide or create your own.

## Use editing tools to ensure consistency

Visual Studio Code (VS Code) has many extensions that can help you write and edit Markdown
documents.

- [Learn Authoring Pack][08] - A collection of VS Code extensions to aid with Markdown authoring for
  Microsoft Learn content.
  - **Learn Markdown**, which provides Markdown authoring assistance, including support for
    inserting custom Markdown syntax specific to learn.microsoft.com. The rest of this readme
    provides details on the Learn Markdown extension.
  - **Learn Images**, which compresses and resizes images.
  - **Learn YAML**, which validates Learn .yml files against the appropriate YAML schemas.
  - **Learn Preview**, which uses the learn.microsoft.com CSS for more accurate Markdown preview,
    including custom Markdown.
  - **Learn Article Templates**, which allows users to apply Markdown skeleton content to new files.
  - **Learn Scaffolding**, which automatically generates Learn modules based on standard patterns and
    automates renaming, inserting, deleting, and reordering units.
  - **markdownlint**, a popular linter by David Anson.
  - **Learn Training AI Assistant**, which harnesses the power of Azure Open AI to help generate module
    introduction, knowledge check questions and summaries based on the unit/module content.
  - **Learn validation** - DO NOT INSTALL THIS EXTENSION
  - REQUIREMENT? - [YAML][12] - YAML Language Support by Red Hat, with built-in Kubernetes syntax support
- [Reflow Markdown][09] - Format the current heading, paragraph, list, or blockquote to have lines
  no longer than your preferred line length, using the alt+q shortcut or your own user-specific
  keyboard-binding.
- [Excel to Markdown table][06] - Copy Excel data and convert it to Markdown table format.
- [Table Formatter][11] - Automatically adjusts the width of the table columns.
- [Gremlins tracker for Visual Studio Code][10] - Reveals some characters that can be harmful
  because they're invisible or look like legitimate ones.
- [Vale VSCode][05] - A prose linter similar to Grammarly.
- [markdownlint][07] - A Markdown linter and style checker.

## Demo time

Take a moment to view the [best-practices.md][02] file in GitHub.

## Settings

Editor rulers

- Set the editor rulers by editing the VS Code `settings.json` file.

  ```json
  "editor.rulers": [1, 2, 3, 4, 5, 76, 80, 90, 100],
  ```

Learn Markdown extension

- Markdown: Show Toolbar - enable this to get the toolbar added to the status bar.

  ```json
  "markdown.showToolbar": true
  ```

Reflow Markdown

- Preferred line length - set this to 100

  ```json
  "reflowMarkdown.preferredLineLength": 100
  ```

<!-- link references -->
[01]: images/markdown/slide6.png
[02]: https://github.com/sdwheeler/seanonit/blob/main/content/downloads/markdown/best-practices.md
[03]: https://learn.microsoft.com/powershell/scripting/community/contributing/editorial-checklist
[04]: https://learn.microsoft.com/powershell/scripting/community/contributing/powershell-style-guide
[05]: https://marketplace.visualstudio.com/items?itemName=ChrisChinchilla.vale-vscode
[06]: https://marketplace.visualstudio.com/items?itemName=csholmq.excel-to-markdown-table
[07]: https://marketplace.visualstudio.com/items?itemName=DavidAnson.vscode-markdownlint
[08]: https://marketplace.visualstudio.com/items?itemName=docsmsft.docs-authoring-pack
[09]: https://marketplace.visualstudio.com/items?itemName=marvhen.reflow-markdown
[10]: https://marketplace.visualstudio.com/items?itemName=nhoizey.gremlins
[11]: https://marketplace.visualstudio.com/items?itemName=shuworks.vscode-table-formatter
[12]: https://marketplace.visualstudio.com/items?itemName=redhat.vscode-yaml
