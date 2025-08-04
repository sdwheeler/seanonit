---
title: The Legend of PlatyPS and Content Wrangler
date: 2025-08-04
draft: false
showReadTime: false
categories:
  - PowerShell
tags:
  - PlatyPS
  - Fun with Microsoft Copilot
description: >
  Telling the story of how PlatyPS using Microsoft Copilot.
---
<!-- markdownlint-disable-file MD041 -->

Recently I have been working on a big project to rewrite the [PlatyPS module][01]. This is the
module we use at Microsoft to create and maintain the PowerShell documentation. As part of this
project, I spent a long time fixing existing PowerShell content so that it would work with the new
PlatyPS module. To celebrate the completion of this project, I decided to have some fun with
Microsoft Copilot. I created this image and story about the PlatyPS module and how it helps us
wrangle PowerShell documentation.

---

![PlatyPS and Content Wrangler][02]

Out on the wild edges of the PowerShell frontier, where modules multiplied and help files were as
scarce as water in the Death Valley, there rode a man named **Sean Wheeler**. With a laptop in one
hand and a coffee-stained cowboy hat in the other. Sean was a rare breed: part coder, part cowboy,
and full-time documentarian.

His companion? A massive, bright-blue, duck-billed beast named **PlatyPS**.

Now, PlatyPS wasn't some ordinary companion. No, sir. He was bred for one purpose: _to wrangle
PowerShell documentation_. When other developers were getting bucked off by `Get-Help` and dragged
by `Update-Help`, Sean and PlatyPS rode in, calm as a Sunday morning, turning chaos into clarity.

With a single command, Sean could turn complex cmdlets into clean, readable markdown:

```powershell
Get-Command -Module TrailblazerTools | New-MarkdownCommandHelp -OutputFolder .\docs
```

Need to refresh it after a long day on the dev range?

```powershell
Update-MarkdownHelp -Path .\docs
```

And when it was time to publish those help files for the whole PowerShell posse to use:

```powershell
Import-MarkdownCommandHelp .\docs | Export-MamlCommandHelp -OutputPath .\en-US
```

Thanks to Sean and PlatyPS, no module went undocumented, and no parameter went unexplained. They
brought law and order to the wide, wild west of scripting, one Markdown file at a time.

So if you ever find yourself knee-deep in a PowerShell module with no documentation in sight, don't
panic. Just install the legend:

```powershell
Install-PSResource -Name Microsoft.PowerShell.PlatyPS
```

And tip your hat to **Sean Wheeler**, the cowboy who taught the world that good code deserves even
better docs.

<!-- link references -->
[01]: https://learn.microsoft.com/powershell/utility-modules/platyps/overview
[02]: platyps-content-wrangler.png
