---
title: Step 3 - Created the output parsers
weight: 7
navWeight: 6
featured: false
draft: false
comment: false
toc: true
pinned: false
postDate: false
index: true
---
<!-- markdownlint-disable MD041 -->
![Step 3 - Created the output parsers](images/crescendo/slide07.png)

1. Crescendo doesn't make this part any easier, but it does allow you to focus on parsing the output
1. I started with the parsing functions because I was more comfortable writing PowerShell than JSON
1. I captured the output of each subcommand into a text file that I could easily use as input to my parsing function
1. Let's step through an example for parsing the output from vssadmin list shadows
   - Here is the output of the native command
   - Notice how the labels and data are presented
1. Set breakpoints on first line and Original Volume line
1. Step through first line
   - Notice that I convert the string to a GUID object
1. Remove break point and run until next breakpoint
   - See how the line is subdivided into multiple property values
1. Remove all breakpoints and show the output as objects
1. Switch to terminal and show the verbose output
   - Jim, what is I am having trouble? How can I see what native command is actually being run?

