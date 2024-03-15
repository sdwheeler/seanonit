---
title: Step 4 - Create a cmdlet configuration
weight: 8
navWeight: 5
featured: false
draft: false
comment: false
toc: true
pinned: false
postDate: false
index: true
---
<!-- markdownlint-disable MD041 -->
![Step 4 - Create a cmdlet configuration](images/crescendo/slide08.png)

1. I implement all but one subcommand. Let's add that to the configuration file now.
1. See how the JSON schema validation helps us with the authoring process.
1. Note the information shown in the Problems pane of VS Code.
1. Hover over a property to see a description.
1. Let's look at the finished example for Get-VssShadow
   - This command has multiple parameters and parameter sets
   - Get-Command Get-VssShadow -Syntax
   - Run Get-VssShadow | Select OriginalVolume
1. See the different property options that show up as help
   - Get-Help -Full Get-VssShadow
1. Let's look at the OutputHandlers
   - Jim - tell us about the other types
   - Why would you use one over the other?
1. Let's look at some other properties
   - What is NoGap? Jim - how does Crescendo construct the native command line
   - See that MaxSize has validation
   - Jim - what is Platform used for?
