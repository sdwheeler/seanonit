---
title: Understanding Byte Arrays in PowerShell
date: 2014-11-11
draft: false
showReadTime: false
categories:
  - PowerShell
tags:
  - byte arrays
  - encoding
  - Unicode
  - UTF8
description: >
  Not all strings are created equal. Text encoding can change how strings are stored in memory.
  Learn how to use byte arrays to work with binary data in PowerShell.
---
<!-- markdownlint-disable MD041 -->
> [!NOTE]
> This article was originally posted to my old [WordPress blog][wp]. The content is still relevant
> but some details may have changed.

In a previous [article][04], I presented a PowerShell script for inspecting and validating
certificates stored as PFX files. My goal is to get data into an X509Certificate2 object so that I
can validate the certificate properties. The [X509Certificate2 Import() methods][05] have two sets
variations. One set takes a filename for the certificate file to be imported. The second set takes a
Byte array containing the certificate data to be imported.

In this script, I can import PFX certificate files by downloading a byte stream from a web server or
by reading a file stored on disk. I want to avoid creating temporary files and I want to make a
generic import function that could be used independently of the data retrieval method. I settled on
using an array of bytes as the import format for either scenario.

To import a PFX file from disk I use the [Get-Content][06] cmdlet. Let's take a closer look at how
Get-Content works and what it returns.

```powershell
PS C:\temp> $pfxbytes = Get-Content .\DEV113.pfx
PS C:\temp> $pfxbytes.GetType().Name
Object[]
PS C:\temp> $pfxbytes[0].GetType().Name
String
PS C:\temp> $pfxbytes[0].length
18
PS C:\temp> $pfxbytes.length
70
PS C:\temp> $pfxbytes | ForEach-Object { $count += $_.length }
PS C:\temp> $count
7489
PS C:\temp> Get-ChildItem .\DEV113.pfx

Directory: C:\temp

Mode              LastWriteTime     Length Name
----              -------------     ------ ----
-a---       9/30/2014   1:03 PM       7558 DEV113.pfx
```

By default, we see that `Get-Content` returns an array of String objects. There are two problems
with this for my use case.

1. If you add up the length of all 70 strings you get a total of 7489 characters. But the files size
   is 7558 bytes, so this does not match. The data in a PFX files is not string-oriented. It is
   binary data.
1. I need a Byte array to import the data into an X509Certificate2 object.

Fortunately, using the **Encoding** parameter you can specify that you want Byte encoded data
returned instead of strings.

```powershell
PS C:\temp> $pfxbytes = Get-Content .\DEV113.pfx -Encoding Byte
PS C:\temp> $pfxbytes.GetType().Name
Object[]
PS C:\temp> $pfxbytes[0].GetType().Name
Byte
PS C:\temp> $pfxbytes[0].length
1
PS C:\temp> $pfxbytes.length
7558
```

Notice that Get-Content still returns an array of objects but those objects are Bytes. The total
length of `$pfxbytes` now matches the size on disk. To download the PFX file from the web server I
am using the **System.Net.Webclient** class. **System.Net.Webclient** has three main ways of
downloading content from a web server:

- The [DownloadString][02] methods are useful when you are only expecting to receive text data (e.g.
  HTML, XML, or JSON). Since the PFX file format is binary, not text, this will not work as I have
  already shown above with `Get-Content`.
- The [DownloadFile][01] methods would work except that I don't want to have to save the file to
  disk as required by these methods.
- The [DownloadData][03] methods return a byte array containing the data requested. This is the
  method that best meets our needs.

**But what is a Byte array? How is a Byte array different than a string?**

A byte array can contain any arbitrary binary data. The data does not have to be character data.
Character data is subject to interpretation. Character data implies encoding. There is more than one
way to encode a character. Take the following example:

```powershell
PS C:\temp> $string = 'Hello World'
PS C:\temp> $string.length
11
PS C:\temp> $bytes = [System.Text.Encoding]::Unicode.GetBytes($string)
PS C:\temp> $bytes.length
22
```

As you can see, the length of `$string` is 11 characters. If we convert that to a **byte[]** we get
22 bytes of data. It is also important to know the format of the source data when you are converting
between encoding schemes. Take for example:

```powershell
PS C:\temp> $array = @(72,101,108,108,111,32,87,111,114,108,100)
PS C:\temp> $string = [System.Text.Encoding]::UTF8.GetString($array)
PS C:\temp> $string.length
11
PS C:\temp> $string
Hello World
```

You see it is possible to convert the **byte[]** `$array` to a UTF8 encoded string because each byte
represents one character. However, if you try to convert that same array to Unicode it will treat
each pair of bytes as a single character.

```powershell
PS C:\temp> $string = [System.Text.Encoding]::Unicode.GetString($array)
PS C:\temp> $string.length
6
PS C:\temp> $string
??????
```

The result is an unreadable value stored in `$string`.

<!-- link references -->
[01]: https://learn.microsoft.com/dotnet/api/system.net.webclient.downloadfile?view=net-8.0#System_Net_WebClient_DownloadFile_System_String_System_String_
[02]: https://learn.microsoft.com/dotnet/api/system.net.webclient.downloadstring?view=net-8.0#System_Net_WebClient_DownloadString_System_String_
[03]: https://learn.microsoft.com/dotnet/api/system.net.webclient.downloaddata?view=net-8.0#System_Net_WebClient_DownloadData_System_String_
[04]: ../2014-11-03/
[05]: https://learn.microsoft.com/dotnet/api/system.security.cryptography.x509certificates.x509certificate2.import#overloads
[06]: https://learn.microsoft.com/powershell/module/Microsoft.PowerShell.Management/Get-Content
[wp]: https://seanonit.wordpress.com/