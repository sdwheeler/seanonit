---
title: "{{ replace .Name "-" " " | title }}" # Title of the blog post.
description: "Article description." # Description used for search engine.
date: {{ .Date }} # Date of post creation.
url: /2023/10/05/title-of-blog-article/ # Set the URL of the page.
shareImage: "share.png" # Designate a separate image for social media sharing.
categories:
  - PowerShell
tags:
  - PowerShell
  - Azure
showReadTime: false
draft: true # Sets whether to render this page. Draft of true will not be rendered.
---

Insert lead paragraph here.

> Block quote

**bold**

_italic_

Unordered list

- first
- second
- third

Ordered list

1. first
1. second
1. third

Inline code `Get-Help`.

Cmdlet name `Get-Help`.

Parameter name **ParameterName**.

Parameter value `$true`.

```powershell
PowerShell example code
```

![alt text](image.png)

## Summary

Insert summary here.

### References

- [website](url)

<!-- link references -->
[link-reference]: url