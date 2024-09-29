---
title: Other advanced features of Crescendo
weight: 10
navWeight: 3
featured: false
draft: false
comment: false
toc: true
pinned: false
postDate: false
index: true
---
<!-- markdownlint-disable MD041 -->
![Advanced features][01]

## Handling error output

Crescendo can capture errors written to **stderr** by the native command. If you don't define an
output handler, Crescendo uses the default handler. The default output handler ensures that errors
respect the `-ErrorVariable` and `-ErrorAction` parameters and adds the errors to `$Error`.

Crescendo has two internal functions to manage errors.

- `Push-CrescendoNativeError` adds an error to an error queue. This function is automatically
  called by the output handler. You don't have to call it directly.
- `Pop-CrescendoNativeError` removes an error from the error queue. Use this function to inspect
  errors in the output handler.

Adding an output handler that includes `Pop-CrescendoNativeError` allows you to inspect errors in
the output handler so you can handle them or pass them through to the caller.

The following output handler definition uses `Pop-CrescendoNativeError` to return errors to the
user.

```json
"OutputHandlers": [
    {
        "ParameterSetName": "Default",
        "StreamOutput": true,
        "HandlerType": "Inline",
        "Handler": "PROCESS { $_ } END { Pop-CrescendoNativeError -EmitAsError }"
    }
]
```

## Argument value transformation

You may find situations where the input values handed to a Crescendo wrapped command should be
translated to a different value for the underlying native command. Crescendo has argument
transformation to support these scenarios. The **Parameter** class has two members to support
argument transformation: `ArgumentTransform` and `ArgumentTransformType`. These members work like
the `Handler` and `HandlerType` members. The value `ArgumentTransformType` can be `Inline`,
`Function`, or `Script`. The default value for `ArgumentTransformType` is `Inline`.

- If the `ArgumentTransformType` is `Inline`, the value of `ArgumentTransform` must be a string
  containing a scriptblock.
- If the `ArgumentTransformType` is `Function`, the value of `ArgumentTransform` must be the name
  of a function that is loaded in the current session.
- If the `ArgumentTransformType` is `Script`, the value of `ArgumentTransform` must be the path to a
  script file.

Crescendo passes the parameter's argument values to the argument transformation code. The code must
return the transformed values.

Example: Multiplication of a value.

```json
"Parameters": [
    {
        "Name": "mult2",
        "OriginalName": "--p3",
        "ParameterType": "int",
        "OriginalPosition": 2,
        "ArgumentTransform": "param([int]$v) $v * 2",
        "ArgumentTransformType": "Inline"
    }
]
```

Example: Accepting an ordered hashtable.

```json
"Parameters": [
    {
        "Name": "hasht2",
        "OriginalName": "--p1ordered",
        "ParameterType": "System.Collections.Specialized.OrderedDictionary",
        "OriginalPosition": 0,
        "ArgumentTransform": "param([System.Collections.Specialized.OrderedDictionary]$v) $v.Keys.ForEach({''{0}={1}'' -f $_,$v[$_]}) -join '',''",
        "ArgumentTransformType": "Inline"
    }
]
```

Example: Argument transformation with join.

```json
"Parameters": [
    {
        "Name": "join",
        "OriginalName": "--p2",
        "ParameterType": "string[]",
        "OriginalPosition": 1,
        "ArgumentTransform": "param([string[]]$v) $v -join '',''",
        "ArgumentTransformType": "Inline"
    }
]
```

## Creating parameters that are not used by the native command

Crescendo is designed to pass parameters defined in the configuration as arguments to the native
application. There are times when you may want to use a parameter value in the output handler but
not the native application. To enable this, a new boolean parameter property `ExcludeAsArgument` set
to true prevents the argument from being sent to the native application. The default is `false`.

```json
"Parameters": [
        {
            "Name": "Filter",
            "ParameterType": "string",
            "ExcludeAsArgument": true,
            "Mandatory": false,
            "Description": "Variable not sent to native app"
        }
    ],
```

For this example, the string argument passed to the **Filter** parameter is stored in the variable
`$Filter`. This variable is available for use in your output handler. The output handler could use
the value of the `$Filter` variable to filter the output of the native command, rather than
returning all output.

## Support for elevation

Native commands may require administrative elevation to perform the requested operation. The
**Elevation** property of a Crescendo command has two properties: **Command** and **Arguments**.

- **Command**: Defines the elevation mechanism to be used to elevate the native command. Crescendo
  includes an internal function `Invoke-WindowsNativeAppWithElevation` to aid with elevation on
  Windows. However, this doesn't work properly for elevation. You can use `sudo` on Linux and macOS.
  And the new version of `sudo` for Windows or [`gsudo`][02] also work.
- **Arguments**: This array contains te parameters to be pass to the elevation command. This can be
  a collection of parameters.
  - **OriginalName**: This is the parameter to be used with the elevation command.
  - **DefaultValue**: The default parameter value.

The following example show a command definition for `Get-Sudoer`, which returns a list of users that
have `sudo` permission. Accessing this list requires elevation.

```json
{
   "$schema": "https://aka.ms/PowerShell/Crescendo/Schemas/2021-11",
   "Commands": [
        {
            "Verb": "Get",
            "Noun": "Sudoer",
            "Elevation": {
                "Command": "sudo"
            },
            "OriginalName": "/bin/cat",
            "Parameters": [
                {
                    "Name": "User",
                    "Mandatory": true,
                    "OriginalName": "/etc/sudoers.d/",
                    "NoGap": true,
                    "ParameterType": "string"
                }
            ],
            "Platform": ["MacOS"]
        }
    ]
}
```

<!-- link references -->
[01]: images/crescendo/slide10.png
[02]: https://github.com/gerardog/gsudo
