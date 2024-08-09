<#

    .SYNOPSIS
    Create a console application that echoes its command-line arguments.

    .DESCRIPTION
    This script creates a console application that echoes its command-line arguments.
    The application is written in C# and compiled using the Add-Type cmdlet.
    The application is saved to the specified output folder.
    This script must be run in Windows PowerShell 5.1.

    .PARAMETER OutputFolder
    The folder in which to save the console application.
    The default is the current folder.

    .EXAMPLE
    PS> .\make-echoargs.ps1 -OutputFolder 'C:\temp'

    .OUTPUTS
    System.IO.FileInfo

    .NOTES
    Copyright (c) Sean Wheeler.
    Licensed under the MIT License.

    .LINK
    https://sdwheeler.github.io/seanonit/docs/

    .LINK
    https://github.com/sdwheeler/seanonit/blob/main/content/downloads/binding/make-echoargs.ps1

#>

[CmdletBinding(HelpUri = 'https://sdwheeler.github.io/seanonit/docs/')]
param(
    [ValidateScript({
        $result = Get-Item -LiteralPath $_ -ErrorAction SilentlyContinue
        if ($result -isnot [System.IO.DirectoryInfo]) {
            $false
        } else {
            $true
        }
    })]
    [string]$OutputFolder = '.'
)
$outpath = Join-Path -Path $OutputFolder -ChildPath 'echoargs.exe'
$code = @'
using System;
static class ConsoleApp {
    private static void Main(string[] args)
    {
        Console.WriteLine(
            "\n{0} argument(s) received (enclosed in <...> for delineation):\n", (int)args.Length
        );
        for (int i = 0; i < (int)args.Length; i++)
        {
            Console.WriteLine("  <{0}>", args[i]);
        }
        Console.WriteLine("");
    }
}
'@
if ($PSVersionTable.PSVersion.Major -lt 6) {
    Write-Verbose "Creating the echoargs.exe application in $OutputFolder."
    Add-Type -OutputType ConsoleApplication -OutputAssembly $outpath -TypeDefinition $code
    Get-Item -LiteralPath $outpath
} else {
    Write-Error "This script must be run in Windows PowerShell 5.1."
}