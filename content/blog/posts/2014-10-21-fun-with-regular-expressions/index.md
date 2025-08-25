---
title: Fun with Regular Expressions
date: 2014-10-21T18:47:03
draft: false
showReadTime: false
categories:
  - PowerShell
tags:
  - Regular Expressions
  - regex
description: My recommended tool for learning how to use regular expressions.
---
<!-- markdownlint-disable MD041 -->
> [!NOTE]
> This article was originally posted to my old [WordPress blog][wp]. The content is still relevant
> but some details may have changed.

A while back a friend of mine mentioned that he could not find a regular expression that was capable
of parsing Windows Performance counter strings. He said that it couldn't be done with regex alone
and he had written a lot of code to manually parse the strings. That sounded like a challenge to me.
I had recently been working on a project where I needed regular expressions to find and clean up
text that I was extracting from a large database. I had spent a lot of time learning what I could
about regex to make the job easier. Along the way, I found a great tool called [Expresso][04].

![Expresso showing the parsed results of this regex][01]

Expresso is a power tool for developing and testing regular expressions. In just a few minutes I was
able to create a regex that fit the bill. Since he was writing code in PowerShell to process these
performance counters I sent him this proof of concept.

```powershell
$ctrs = (
  '\\IDCWEB1\Processor(_Total)\% Processor Time',
  '\Paging File(\??\C:\pagefile.sys)\% Usage Peak',
  '\MSSQL$SQLServer:Memory Manager\Total Server Memory (KB)',
  '\\BLACKVISE\Paging File(\??\C:\pagefile.sys)\% Usage Peak',
  '\Category(Instance(x))\Counter (x)',
  '\SQLServer:Latches\Latch Waits/sec (ms)'
)

$pattern = '(?<srv>\\\\[^\\]*)?\\(?<obj>[^\(^\)]*)(\((?<inst>.*(\(.*\))?)\))?\\(?<ctr>.*\s?(\(.*\))?)'

foreach ($ctr in $ctrs) {
  if ($ctr -match $pattern) {
    "Server = " + $matches["srv"]
    "Object = " + $matches["obj"]
    "Instance = " + $matches["inst"]
    "Counter = " + $matches["ctr"]
    ""
  }
}
```

Here is the output :

```
Server = \\IDCWEB1
Object = Processor
Instance = _Total
Counter = % Processor Time

Server =
Object = Paging File
Instance = \??\C:\pagefile.sys
Counter = % Usage Peak

Server =
Object = MSSQL$SQLServer:Memory Manager
Instance =
Counter = Total Server Memory (KB)

Server = \\BLACKVISE
Object = Paging File
Instance = \??\C:\pagefile.sys
Counter = % Usage Peak

Server =
Object = Category
Instance = Instance(x)
Counter = Counter (x)

Server =
Object = SQLServer:Latches
Instance =
Counter = Latch Waits/sec (ms)
```

By the way, the PowerShell script he was writing was part of [PAL][03]. Check out [Clint's][02]
incredible performance analysis tool.

<!-- link references -->
[01]: expresso.png
[02]: https://github.com/clinthuffman
[03]: https://github.com/clinthuffman/PAL
[04]: http://www.ultrapico.com/Expresso.htm "Expresso"
[wp]: https://seanonit.wordpress.com/