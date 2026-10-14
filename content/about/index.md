---
title: About this blog
linkTitle: About
description: A blog about my experiences in IT and PowerShell.
date: 2023-08-15
menu: { main: { weight: 10 } }
resources:
  - src: headshot.jpg
  - src: netronics-elf.jpg
  - src: tvgrafik.png
---

{{% blocks/cover
  title="About Sean on IT"
  height="auto td-below-navbar"
  image_anchor="bottom"
%}}

<!-- prettier-ignore -->
{{% _param description %}}
{.display-6}

{{% /blocks/cover %}}

{{% blocks/lead color="white" %}}
I started this blog to share the things I have learned during the course of my career in IT. The
logo and the name were meant to reflect the "IT" part of my career. Most of the content here is
about PowerShell However, I will also write about other topics that interest me. So the "IT" may
just become "it".

I hope you find it useful.
{{% /blocks/lead %}}

{{% blocks/section
  type="row"
  title="My journey in IT"
%}}
<div class="col-md-4 col-lg-3">
  {{% imgproc headshot Fill "280x277" %}}
  {{% /imgproc %}}
</div>
<div class="col-md-8 col-lg-9">
  <p>
  <p>
  <p>Hi, I'm Sean Wheeler. For 10 years, I was the lead documentarian for
    <a href="https://learn.microsoft.com/powershell">PowerShell</a> at Microsoft. For over 25
    years at Microsoft, I've delivered many workshops on scripting, debugging, and advanced
    troubleshooting. Using scripting, I created tools to help customers collect and analyze data
    used to troubleshoot and optimize their environments.</p>
</div>
{{% /blocks/section %}}

{{% blocks/section
  type="row"
  title="My journey in IT"
%}}

My interest in computers started in 1978 when I first learned to program in BASIC from a book
without access to a computer. My first computer was the Netronics ELF II built from a kit. It had
256 bytes of RAM.

{{% imgproc tvgrafik Fill "375x275" %}}
Example display from the July 1977 issue of [Popular Electronics](https://www.americanradiohistory.com/Archive-Poptronics/70s/1977/Poptronics-1977-07.pdf) magazine
{{% /imgproc %}}
{{% imgproc netronics-elf Fill "594x338" %}}
Netronics ELF II computer from [oldcomputers.net](https://www.oldcomputers.net/netronics-elf.html)
{{% /imgproc %}}

Later, I saved up my money and bought an Apple //e. It got me through my first two years of college.
By then, the PC Clone market was starting to heat up and I bought a Turbo XT clone, the first of
many PCs I would own. In college I studied Computer Science and worked as a system operator for the
university's VAX cluster. I loved the DCL scripting language in VMS. After graduation, I got into
NetWare. That paid the bills for several years. In February of 1995, I hired by Microsoft to support
Windows (WFW 3.11, LanMan 2.x, NT 3.1, & NT 3.5) for large corporate customers.

{{% /blocks/section %}}

{{% blocks/section
  type="row"
  title="Legal stuff"
%}}

The information presented here is provided without warranty. Use at your own risk.

The articles on this blog are copyrighted by me and can't be reproduced without my permission. The
code samples are licensed under the [MIT License][03] and are free to use however you want.

The views and opinions presented on this blog are my own and don't represent the views or opinions
of any of my employers - past, present, or future.

_Dry clean only. Use a cool iron. Don't get it wet. Don't feed it after midnight._

{{% /blocks/section %}}

<!-- link references -->
[03]: https://opensource.org/licenses/MIT
