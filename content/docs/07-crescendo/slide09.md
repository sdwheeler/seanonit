---
title: Understand the 4 types of output handlers
weight: 9
navWeight: 4
featured: false
draft: false
comment: false
toc: true
pinned: false
postDate: false
date: 2021-11-09
index: true
---
<!-- markdownlint-disable MD041 -->
![Types of output handlers][01]

Crescendo supports four types of output handlers.

- `ByPass`
- `Inline`
- `Function`
- `Script`

## ByPass

When you set **HandlerType** to `ByPass`, the cmdlet does no output or error handling. Some
command-line tools create different output depending on whether the output is sent to the screen or
the pipeline. [Pastel][03] is an example of a command that changes its output from a graphical
screen representation to a single string value when used in a pipeline. Crescendo output handling is
pipeline based and can cause these applications to return unwanted results. Crescendo supports the
ability to bypass the output handler entirely.

To bypass all output handling by Crescendo:

```json
"OutputHandlers": [
    {
        "ParameterSetName": "Default",
        "HandlerType": "ByPass"
    }
]
```

## Inline

This is the default **HandlerType** if you don't specify the type. To use this type, set the
**Handler** property to a string containing PowerShell code that handles the output. This is best
suited for small handlers that easily fit into a single line. For example, you might have a
command-line tool that can output JSON. You don't need a complicated parsing function to convert the
JSON to an object. The output from the `ifconfig` command in Linux can be transformed to JSON using
`jc`. The JSON is easily converted to a PowerShell object using `ConvertFrom-Json`.

```json
"OutputHandlers": [
    {
        "ParameterSetName": "Default",
        "HandlerType": "Inline",
        "StreamOutput": true,
        "Handler": "$input | jc --ifconfig | ConvertFrom-Json"
    }
]
```

## Function

When you **HandlerType** to `Function`, the **Handler** property is the name of the function
that parses the output. That function needs to be loaded in your PowerShell session before you run
`Export-CrescendoModule`. `Export-CrescendoModule` copies the function into the module (`.PSM1`)
file it creates.

This is the preferred way of including complex parsing functions.

## Script

When you set **HandlerType** to `Function`, the **Handler** property is the name of the function
that parses the output. The script file needs to in the current location relative to where you run
`Export-CrescendoModule`. `Export-CrescendoModule` copies the script files into the module output
location. These files need to be included with the module when you publish it.

This is useful for testing your module during development, because you don't have to rebuild the
module if you need to make changes to one of the output handler scripts.

<!-- link references -->
[01]: images/crescendo/slide9.png
[03]: https://github.com/sharkdp/pastel