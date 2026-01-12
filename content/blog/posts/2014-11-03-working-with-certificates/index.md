---
title: Working with certificates in PowerShell
date: 2014-11-03
draft: false
showReadTime: false
categories:
  - PowerShell
tags:
  - Certificates
  - X.509
description: >
  An example script for working with certificates. The example also illustrates some advanced
  PowerShell scripting techniques like, parameter sets, comment-based help, and error handling.
---
<!-- markdownlint-disable MD041 -->
> [!NOTE]
> This article was originally posted to my old [WordPress blog][wp]. The content is still relevant
> but some details may have changed.

Today's script is an attempt to bring together several things I have learned about writing good
PowerShell scripts. I still have a lot to learn and this is not necessarily a sterling example of
best practices. However, it does illustrate some more advanced scripting topics, including:

- Comment-based help
- Parameter sets
- Parameters passing on the pipeline
- Error handling with try-catch blocks
- Simple HTTP downloads using System.Net.Webclient
- Inspecting certificates imported from external sources (http or file)
- Inspecting certificates in the local store

I rarely use comment-based help in my scripts since I am usually writing scripts for my own use.
They tend to be one-off utilities designed to fulfill an immediate need. This script, however, is
going to be used by other support technicians outside of my immediate team. So documentation was
important. Comment-based help allows you to include documentation in the script (rather than a
separate file that can get lost or out of date). And it gives help in a format that users expect for
any other PowerShell command.

Parameter handling in PowerShell is extremely versatile. Through the advanced parameter options, you
can create parameter sets, specify which parameters are mandatory, perform data validation, define
input from the pipeline, and much more. All of this controlled via parameter definition. No need to
write code to validate parameters or ensure valid parameter combinations. PowerShell does the heavy
lifting for you.

My focus will be on the certificate management portions of the script and to outline the scenario
that this script is attempting to support.

## The Scenario

We have a set of devices that require a device-specific certificate to be installed. We have a
scripted process for creating, publishing, and installing these certificates. The certificates are
created in bulk for a large number of devices. These certificates are then exported to PFX files
copied to a folder shared by a web server. The device can then download the PFX file and import it
into local certificate store on the device. The devices and the certificates have a standardized
naming scheme (e.g. DEV###). This makes it easy to identify which certificate belongs to which
device.

The certificate lifecycle an unmanaged process. There is no policy mechanism to ensure that the
device has installed the proper certificate or that the certificate installed is correct and valid.
Occasionally we can have problems where the installed certificate is not working properly or the PFX
file published to the web server does not match the certificated issued by the CA. To troubleshoot
these issues we need to be able to verify the certificates on the device in PFX files published on
the web server.

## The solution

This script looks for certificates in one of three locations: the certificate broker (web server),
the local certificate store, or PFX files stored in the file system. In all cases, the output is the
same for each certificate found. The script displays some basic information about the certificate
and then checks that each certificate in the validity chain is still valid.

### Example 1 - check the published PFX file for a device

This was the first scenario I needed to solve for. The script takes the specified device name and
attempts to download the matching PFX file from the certificate broker.

```
PS C:\> .\check-devicecert.ps1 -devices DEV101
```

You can specify one or more device IDs as an array of strings.

### Example 2 - search for the device certificate in the local store

The script takes the specified device name and searches for a certificate with a matching Subject
name in the local certificate store.

```
PS C:\> .\check-devicecert.ps1 -devices DEV101 -local
```

You can specify one or more device IDs as an array of strings.

### Example 3 - load a PFX file from disk

The script loads the specified PFX file(s) from disk.

```
PS C:\> .\check-devicecert.ps1 -pfxfilename .\DEV113.pfx
PS C:\> dir *.pfx | .\check-devicecert.ps1
```

You can specify one or more PFX filenames as an array of strings. You can also pass an array of
files on the pipeline.

For examples #1 and #3 we are working with PFX files. The first step is to obtain the contents of
the PFX file as an array of bytes so that we can create an X.509 certificate object. To download the
PFX file from the certificate broker we do the following:

```powershell
$client = New-Object -TypeName System.Net.WebClient
$url = "https://certbroker.contoso.com/pfxshare/$($num).pfx"
$pfxBytes = $client.DownloadData($url)
```

The `DownloadData()` method of System.Net.WebClient does this nicely for us.

To load a PFX file from disk I use the Get-Content cmdlet and specify that I want Byte encoding.

```powershell
$pfxBytes = Get-Content -path $file -encoding Byte -ErrorAction:SilentlyContinue
if ($error.count -ne 0) {throw $error}
```

Also, note the **ErrorAction** parameter. For some reason, exceptions occurring inside
of `Get-Content` were not being caught by my Try-Catch block. I had to override the
ErrorAction to force `Get-Content` to continue silently, check to see if an error
occurred, then re-throw the exception so that it would get caught by my `Try/Catch` block.

Once I had the Byte array containing the PFX-formatted data blob I needed to import it into an X.509
certificate object.

```powershell
function import-pfxbytes {
  param($pfxBytes)
  ## Import cert into a new object. No need to import it into a certificate device.
  $pfxPass = 'pFxP@$5w0rd'
  $X509Cert = New-Object -TypeName System.Security.Cryptography.X509Certificates.X509Certificate2
  $X509Cert.Import([byte[]]$pfxBytes, $pfxPass,"Exportable,PersistKeySet")
  return $X509Cert
}
```

The `import-pfxbytes` function creates an empty X.509 certificate and imports the data using a
static password and returns a certificate object. In this case, I have hard-coded the password. For
better security, you should prompt the user to enter a password (for example, using
`Read-Host -AsSecureString`).

For example #2 I am using PowerShell's built-in provider to access the local certificate store. With
this access method, you receive a certificate object, not a PFX-formatted data blob. Once I have an
X.509 certificate object I pass it to `show-certinfo` to inspect the important properties and verify
the validity of the trust chain.

```powershell
# title="Check-DeviceCert.ps1"]
<#
.SYNOPSIS
Checks a device certificate for validity.

.DESCRIPTION
The script downloads a device certificate PFX file from the cert broker or reads an existing PFX file then checks for the validity.

.PARAMETER devices
An array of device numbers .PARAMETER local Indicates that you want to search the local certificate device.

.PARAMETER pfxfiles
An array of pathnames to PFX files deviced on disk. .INPUTS You can provide an array of PFX file names in the pipeline.

.EXAMPLE
PS C:\> .\check-devicecert.ps1 -devices DEV101
    ==================================================
    Downloading DEV101.pfx

    Subject      : CN=DEV101@contoso.com
    Issuer       : CN=Contoso Corporate Enterprise CA 02, DC=contoso, DC=com
    NotBefore    : 5/2/2013 12:39:58 PM
    NotAfter     : 5/1/2017 12:39:58 PM
    SerialNumber : 27DC85E200060000B6D2

    Validating certficate chain...

    Valid   Certificate
    -----   -----------
    True    CN=DEV101@contoso.com
    True    CN=Contoso Corporate Enterprise CA 02, DC=contoso, DC=com
    True    CN=Contoso Corporate Root CA, O=CONTOSO
    ==================================================

The example above illustrates downloading the PFX file from the certificate broker and check the validity.
.EXAMPLE
PS C:\> .\check-devicecert.ps1 -devices DEV369,DEV123
    ==================================================
    Downloading DEV369.pfx

    Subject      : CN=DEV369@contoso.com
    Issuer       : CN=Contoso Corporate Enterprise CA 02, DC=contoso, DC=com
    NotBefore    : 5/2/2013 3:37:14 PM
    NotAfter     : 5/1/2017 3:37:14 PM
    SerialNumber : 287ED09B00060000CD63

    Validating certficate chain...

    Valid   Certificate
    -----   -----------
    True    CN=DEV369@contoso.com
    True    CN=Contoso Corporate Enterprise CA 02, DC=contoso, DC=com
    True    CN=Contoso Corporate Root CA, O=CONTOSO
    ==================================================
    Downloading DEV123.pfx
    Error downloading S123456 - The remote server returned an error: (404) Not Found.

The example above illustrates downloading multiple PFX files from the certificate broker and check their validity.
.EXAMPLE
PS C:\temp> .\check-devicecert.ps1 -devices DEV101 -local
    ==================================================
    Reading Cert:LocalMachine\My\584C772D4E9EAA9F5858742B2AE4F3E9A0D602C7

    Subject      : CN=DEV101@contoso.com
    Issuer       : CN=Contoso Corporate Enterprise CA 02, DC=contoso, DC=com
    NotBefore    : 5/2/2013 12:39:58 PM
    NotAfter     : 5/1/2017 12:39:58 PM
    SerialNumber : 27DC85E200060000B6D2

    Validating certficate chain...

    Valid   Certificate
    -----   -----------
    True    CN=DEV101@contoso.com
    True    CN=Contoso Corporate Enterprise CA 02, DC=contoso, DC=com
    True    CN=Contoso Corporate Root CA, O=CONTOSO
    ==================================================

The example above searches for a certificate in the local certificate device and test the validity.
.EXAMPLE
PS C:\temp> .\check-devicecert.ps1 -pfxfilename .\DEV113.pfx
    ==================================================
    Reading .\S10113.pfx

    Subject      : CN=DEV113@contoso.com
    Issuer       : CN=Contoso Corporate Enterprise CA 02, DC=contoso, DC=com
    NotBefore    : 5/2/2013 3:30:35 PM
    NotAfter     : 5/1/2017 3:30:35 PM
    SerialNumber : 2878BAEA00060000CCAD

    Validating certficate chain...

    Valid   Certificate
    -----   -----------
    True    CN=DEV113@contoso.com
    True    CN=Contoso Corporate Enterprise CA 02, DC=contoso, DC=com
    True    CN=Contoso Corporate Root CA, O=CONTOSO
    ==================================================

The example above checks the validity of an existing, locally-deviced PFX file.
.EXAMPLE
PS C:\temp> dir *.pfx | .\check-devicecert.ps1
    ==================================================
    Reading C:\temp\DEV113.pfx

    Subject      : CN=DEV113@contoso.com
    Issuer       : CN=Contoso Corporate Enterprise CA 02, DC=contoso, DC=com
    NotBefore    : 5/2/2013 3:30:35 PM
    NotAfter     : 5/1/2017 3:30:35 PM
    SerialNumber : 2878BAEA00060000CCAD

    Validating certficate chain...

    Valid   Certificate
    -----   -----------
    True    CN=DEV113@contoso.com
    True    CN=Contoso Corporate Enterprise CA 02, DC=contoso, DC=com
    True    CN=Contoso Corporate Root CA, O=CONTOSO
    ==================================================

The example above checks the validity of all the PFX files deviced in folder.
#>

[CmdletBinding(DefaultParametersetName="devices")]
param (
       [parameter(ParameterSetName="names",Position=0,Mandatory=$true,
        ValueFromPipeline=$false,HelpMessage="Enter device Number, Ex S12345")]
       [string[]]$devices,
       [parameter(ParameterSetName="names",Position=1,Mandatory=$false,
        ValueFromPipeline=$false,HelpMessage="Look for certificate in local device.")]
       [switch]$local,
       [parameter(ParameterSetName="files",Position=0,Mandatory=$true,
        ValueFromPipeline=$true,HelpMessage="Enter PFX file name, Ex C:\folder\DEV123.pfx")]
       [string[]]$pfxfiles
      )

function import-pfxbytes {
   param($pfxBytes)
   ## Import cert into a new object. No need to import it into a certificate device.
   $pfxPass = 'pFxP@$5w0rd'
   $X509Cert = New-Object -TypeName System.Security.Cryptography.X509Certificates.X509Certificate2
   $X509Cert.Import([byte[]]$pfxBytes, $pfxPass,"Exportable,PersistKeySet")
   return $X509Cert
}
function show-certinfo {
   param($cert)
   $cert | Select-Object -property Subject,Issuer,NotBefore,NotAfter,SerialNumber

   $certChain = New-Object -TypeName System.Security.Cryptography.X509Certificates.X509Chain
   $result = $certChain.Build($cert)
   $certChain.ChainPolicy.RevocationFlag = "EntireChain"
   $certChain.ChainPolicy.RevocationMode = "Online"
   Write-Host -Object "Validating certficate chain..." -foreground black -background yellow
   "`r`nValid`tCertificate"
   "-----`t-----------"
   foreach ($element in $certChain.ChainElements) {
       "{0}`t{1}" -f $element.Certificate.Verify(),$element.Certificate.Subject
   }
}

$Error.Clear()
("=" * 50)

try {
    switch ($PsCmdlet.ParameterSetName) {
        "names" {
            $client = New-Object  -TypeName System.Net.WebClient
            foreach ($num in $devices) {
                if ($local) {
                    $certs = Get-ChildItem -Recurse -Path Cert: | Where-Object { $_.Subject -like "CN=$num" }
                    if ($certs.count -eq 0) {
                        "No matching certificates found in the local device."
                        return ''
                    }
                    foreach ($cert in $certs) {
                        $certpath = $cert.pspath -replace 'Microsoft.PowerShell.Security\\Certificate::',"Cert:"
                        Write-host -Object "Reading $certpath"  -foreground black -background yellow
                        show-certinfo($cert)
                        ("=" * 50)
                    }
                }
                else {
                    $url = "https://certbroker.contoso.com/pfxshare/$($num).pfx"
                    Write-host -Object "Downloading $num.pfx" -foreground black -background yellow
                    $pfxBytes = $client.DownloadData($url)
                    $cert = import-pfxbytes($pfxBytes)
                    show-certinfo($cert)
                    ("=" * 50)
                }
            }
        }

        "files" {
            foreach ($file in $pfxfiles) {
                Write-host -Object "Reading $file" -foreground black -background yellow
                $pfxBytes = Get-Content -path $file -encoding Byte -ErrorAction:SilentlyContinue
                if ($error.count -ne 0) {throw $error}
                $cert = import-pfxbytes($pfxBytes)
                show-certinfo($cert)
                ("=" * 50)
            }
        }
    }
}
catch {
    $_.Exception.Message
    $_.InvocationInfo.PositionMessage
}
```

<!-- link references -->
[wp]: https://seanonit.wordpress.com/
