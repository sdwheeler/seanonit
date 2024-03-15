---
title: Markdown Basics
ms.date: 03/09/2024
headless: true
---
# Markdown basics

This file contains examples of the most commonly used elements of the Markdown language. Use the
preview feature of your Markdown editor to see how the examples render. There are two categories of
Markdown elements:

- Block elements - Usually have beginning and ending markers and can span multiple lines
- Span elements - Occur inline, within a block element. Not intended for long spans of text or
  multiple lines.

## Block elements

Block elements are the primary structural components of a Markdown document. They are used to create
the structure of the document. Blocks should be separated by a blank line. The current block is
closed (ends) when a new block starting marker is found.

### Paragraphs and line breaks

- A sequence of non-blank lines that cannot be interpreted as other kinds of blocks.
- A blank line ends a paragraph.
- Multiple blank lines are equivalent to a single blank line.

### Headers - ATX-style headers are preferred

<!-- markdownlint-disable MD001 MD022 MD023 MD025 -->

  # H1 - File title
  ## H2 - Top-level topics
  ### H3 - Sub-topics
  #### H4 - Sub-topics
  ##### H5 - Sub-topics
  ###### H6 - Sub-topics

<!-- markdownlint-enable MD001 MD022 MD023 MD025 -->

### Blockquotes

The paragraph must start with a `>` character. Subsequent lines might or might not start with a `>`
character.

Single-line paragraph:

> This is a single-line paragraph in a blockquote. The paragraph must start with a `>` character. All sentences in the paragraph are on the same line. This is discouraged because it makes the paragraph difficult to read. Use the reflow extension to reformat the paragraph.

Block marker on first line only:

> This is a multi-line paragraph in a blockquote. The paragraph must start with a `>` character.
Subsequent lines might or might not start with a `>` character. This is discouraged because it's
unclear that the author intended the paragraph to continue or if they forgot to add a blank line to
signal the end of the block. Use the reflow extension to reformat the paragraph.

Block marker on every line (preferred):

> This is a multi-line paragraph in a blockquote. The paragraph must start with a `>` character.
> Subsequent lines might or might not start with a `>` character.

### Unordered lists (bullets)

Markdown allows alternate starting characters for unordered list items. Use one style consistently.
This is the recommended style.

- A bullet list item starts with a `-`, `+`, or `*` character
- The bullet character must be followed by a space
- Indent block lines with 2 spaces to continue the list item
- Indent block lines with 2 spaces to create a nested list

  - This is a bullet list item
  - This is another bullet list item
    - This is a nested bullet list item
    - This is another nested bullet list item
  - This is another bullet list item

### Ordered lists (numbered)

Markdown allows alternate starting characters for unordered list items. Use one style consistently.
This is the recommended style.

- The number list item starts with a number followed by a `.` or `)` character
- The value of the number is not important because the Markdown parser will automatically number the
  list items (don't use 0 - not supported by all parsers)
- Indent block lines with 3 spaces to continue the list item
- Indent block lines with 3 spaces to create a nested list

  1. This is a number list item
  1. This is another number list item
     1. This is a nested number list item
     1. This is another nested number list item
  1. This is another number list item

### Code Blocks - use a code fence instead of indentation

A code fence is a sequence of at least three consecutive backtick characters (`` ` ``) or tildes
(`~`) followed by an optional _info string_, typically used to specify the language of the code
sample. The info string enables syntax highlighting in code blocks.

```powershell
# This example count the number of lines in each file
Get-ChildItem -Path . -Filter *.txt | ForEach-Object {
    $file = $_.FullName
    $lines = (Get-Content -Path $file).Count
    Write-Host "$file has $lines lines"
}
```

The content of the code block consists of all subsequent lines, until a closing code fence of the
same type as the code block began with (backticks or tildes), and with at least as many backticks or
tildes as the opening code fence. If you need to nest a code block:

- Use a different number of backticks or tildes

  ````markdown
  ```powershell
  # This example count the number of lines in each file
  Get-ChildItem -Path . -Filter *.txt | ForEach-Object {
      $file = $_.FullName
      $lines = (Get-Content -Path $file).Count
      Write-Host "$file has $lines lines"
  }
  ```
  ````

- Or, nest backticks inside of tildes

  ~~~markdown
  ```markdown
  > This is a **Markdown** code block that demonstrates nesting a code block inside another.
  > This is useful for showing **Markdown** syntax within a **Markdown** document.
  ```
  ~~~

### Horizontal Rules

A line that contains only `*`, `-`, or `_` characters. Typically you only use 3 dashes.

---

Also known as a thematic break, horizontal rules are used to separate content within a page or to
separate YAML frontmatter from the Markdown content in a file.

## Span elements

Spans are inline markup that is parsed sequentially from the beginning of the character stream to
the end. They are used to format the content of a block.

### Emphasis

Markdown allows alternative syntaxes for emphasis. Use one style consistently. This is the
recommended style. For more information, see the
[PowerShell Style Guide](https://learn.microsoft.com/powershell/scripting/community/contributing/powershell-style-guide).

- **Bold**
- _Italic_
- ~~Strikethrough~~
- `Inline code`
- <u>Underline</u> - uses HTML tags (avoid)

### Links - create a hyperlink

The URI can be a one of the following:

- A relative or absolute path to a file in the same location
- A URL to an external web page
- A site-relative URL to a web page on the same site

The optional title is displayed as a tooltip when the user hovers over the link.

- Basic syntax

  ```markdown
  [link](uri "title")
  ```

- Reference-style links - improves readability of a paragraph

  ```markdown
  [link][id]

  [id]: uri "title"
  ```

  For more information, see the [PowerShell Style Guide][psg].

- Automatic links - not recommended

  Automatic links are created by enclosing the URI in angle brackets.

  <https://www.example.com>

- Links inside of code blocks or code spans are not converted to clickable links.

  This is an example URI: `https://www.example.com`

### Images - embed an image

The syntax for embedding an image is similar to the syntax for creating a hyperlink except that it
is preceded by an exclamation point (`!`). The optional title is displayed as a tooltip when the
user hovers over the image. The text in the brackets is the _alt text_ for the image. Alt text is
important for accessibility.

- Basic syntax

  ```markdown
  ![alt text](uri)
  ```

  ![PowerShell logo](PowerShell-Logo.png)

- Reference-style images - improves readability of a paragraph

  ```markdown
  ![alt text][id]

  [id]: uri "title"
  ```

  ![PowerShell logo][logo]

### Escapes & character entities

If you need to use a character that has a special meaning in Markdown, you can escape it with a `\`.

- \*literal asterisks\*

If you need to use a character that is not part of the printable ASCII character set, you can use a
character entity. This is useful for inserting special characters that are not on your keyboard,
such as symbols and emoji.

- Copyright &copy; Registered &reg; Trademark &trade;
- Smiley &#x1F60A;
- &lsquo;Smart single quotes&rsquo;
- &ldquo;Smart double quotes&rdquo;

Using character entities is preferred over using the actual character because it avoids encoding and
rendering issues.

- Copyright © Registered ® Trademark ™
- Smiley 😊
- ‘smart quotes’
- “smart quotes”

## Extensions

The CommonMark specification does not include support for tables, task lists, or alerts. However,
many Markdown parsers and editors support these features as extensions to the CommonMark
specification.

### Some HTML elements

The CommonMark specification allows the use of some [HTML elements][html]. However, not all Markdown
renderers support the same set of HTML elements. Consult your Markdown renderer's documentation.

### Tables

There are several styles of tables that are supported by different Markdown parsers. The pipe (`|`)
table format is the most widely supported.

Simple table example

- Use pipes (`|`) to separate columns and hyphens (`-`) to create the header row
- Cells can be different widths

| Header 1 | Header 2 | Header 3 |
| --- | --- | --- |
| Row 1, Column 1 | Row 1, Column 2 | Row 1, Column 3 |
| Row 2 | Row 2 | Row 2 |

Improved example

- Use colons (`:`) to indicate alignment
- Use HTML `<br>` to break lines in a cell
- Use equal width cells to improve readability

|    Header 1     |    Header 2     |                           Header 3                           |
| :-------------- | :-------------: | -----------------------------------------------------------: |
| Left-aligned    | Center-aligned  |                                                Right-aligned |
| Row 2, Column 1 | Row 2, Column 2 | Row 2, Column 3<br>Use HTML `<br>` to break lines in a cell. |

### Task lists

Git-flavored Markdown (GFM) supports task lists. A task list is a list of items where each item is
preceded by a checkbox. The checkbox is either checked or unchecked. The checkbox is created by
enclosing a space character in square brackets (`[ ]`) or (`[x]`).

Proper examples

- [ ] Unchecked task
- [x] Checked task
- [ ] \(Optional) Unchecked task
  - Note the escape character `\` before the parenthesis
  - Prevents the parenthesis from being interpreted as a Markdown link

Broken examples

- [] Unchecked task
- [ x ] Checked task

### Alerts

The Microsoft Learn platform and GFM support the use of alerts. An alert is a callout that is used
to draw attention to important information. The alert is a special kind of blockquote created by
enclosing the alert type in square brackets (`[ ]`).

> [!NOTE]
> Information the user should notice even if skimming

> [!TIP]
> Optional information to help a user be more successful

> [!IMPORTANT]
> Essential information required for user success

> [!CAUTION]
> Negative potential consequences of an action

> [!WARNING]
> Dangerous certain consequences of an action

<!-- HTML comments and reference definitions are not rendered -->

<!-- link references -->
[html]: https://spec.commonmark.org/0.31.2/#raw-html
[psg]:  https://learn.microsoft.com/powershell/scripting/community/contributing/powershell-style-guide
[logo]: PowerShell-Logo.png "PowerShell"
