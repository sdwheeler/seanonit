---
title: Opening the door to the Mystery of Dates in PowerShell
date: 2015-11-27T16:26:43
draft: false
showReadTime: false
categories:
  - PowerShell
tags:
  - datetime
  - epoch
description: >
  Different applications and operating systems store dates in differing formats. This article
  summarizes the most common formats and how to convert between them.
---
> This article was originally posted to my old [WordPress blog][wp].

Formatting and converting dates can be very confusing. Every programming language, operating system,
and runtime environment seem to do it differently. And part of the difficulty in conversion is
knowing what units you are starting with. First, it is helpful to know the [Epoch][07] (or starting
date) a stored value is based on. Wikipedia has a good article on this. Here is a brief excerpt.

| Epoch date      | Notable uses                                                                                                                                                                                          | Rationale for selection                                                                                                                        |
|-----------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------|
| January 1, AD 1 | Microsoft .NET                                                                                                                                                                                        | Common Era, ISO 2014, RFC 3339                                                                                                                 |
| January 1, 1601 | NTFS, COBOL, Win32/Win64                                                                                                                                                                              | 1601 was the first year of the 400-year Gregorian calendar cycle at the time Windows NT was made                                               |
| January 0, 1900 | Microsoft Excel, Lotus 1-2-3                                                                                                                                                                          | While logically January 0, 1900 is equivalent to December 31, 1899, these systems do not allow users to specify the latter date.               |
| January 1, 1904 | Apple Inc.'s macOS through version 9                                                                                                                                                                 | 1904 is the first leap year of the 20th century                                                                                                |
| January 1, 1970 | Unix Epoch aka POSIX time. Used by Unix and Unix-like systems (Linux, macOS X), and programming languages: most C/C++ implementations, Java, JavaScript, Perl, PHP, Python, Ruby, Tcl, ActionScript. |                                                                                                                                                |
| January 1, 1980 | IBM BIOS INT 1Ah, DOS, OS/2, FAT12, FAT16, FAT32, exFAT filesystems                                                                                                                                   | The IBM PC with its BIOS as well as 86-DOS, MS-DOS and PC DOS with their FAT12 file system were developed and introduced between 1980 and 1981 |

## **Common Date Conversion Tasks**

- **WMI Dates**

  ```powershell
  PS> $installDate = (Get-WmiObject win32_operatingsystem | select Installdate ).InstallDate
  PS> [system.management.managementdatetimeconverter]::ToDateTime($InstallDate)
  Friday, September 12, 2008 6:50:57 PM

  PS> [System.Management.ManagementDateTimeConverter]::ToDmtfDateTime($(get-date))
  20151127144036.886000-480
  ```

- **Excel dates** - Excel stores dates as sequential serial numbers so that they can be used in
  calculations. By default, January 1, 1900, is serial number 1.

  ```powershell
  PS> ((Get-Date).AddDays(1) - (get-date "12/31/1899")).Days
  42335
  ```

  In this example, the value Days is `42335` which is the serial number for 11/27/2015 in Excel. The
  date `12/31/1899` is equivalent to January 0, 1900. The difference between `12/31/1899` and
  `11/27/2015` is `42334` but since the serial numbers start a 1 you need to add 1 day to get the
  serial number for `11/27/2015`.

- **Converting from custom string formats**

  ```powershell
  PS> $information = '12Nov(2012)18h30m17s'
  PS> $pattern = 'ddMMM\(yyyy\)HH\hmm\mss\s'
  PS> [datetime]::ParseExact($information, $pattern, $null)
  Monday, November 12, 2012 6:30:17 PM
  ```

- **FILETIME conversion** - FILETIME is a 64-bit value representing the number of 100-nanosecond
  intervals since January 1, 1601 (UTC).

  ```powershell
  PS> Get-AdUser username -prop badPasswordTime,lastLogonTimestamp | select badPasswordTime, lastLogonTimestamp
  badPasswordTime : 130927962789982434
  lastLogonTimestamp : 130931333173599571

  PS> [datetime]::fromfiletime(130927962789982434)
  Monday, November 23, 2015 3:51:18 PM

  PS> [datetime]::fromfiletime(130931333173599571)
  Friday, November 27, 2015 1:28:37 PM
  ```

- **CTIME or Unix format** - is an integral value representing the number of seconds elapsed since
  00:00 hours, Jan 1, 1970 UTC (i.e., a Unix timestamp).

  ```powershell
  PS> $epoch = get-date "1/1/1970"
  PS> $epoch.AddMilliseconds(1448302797803)
  Monday, November 23, 2015 6:19:57 PM

  PS> $epoch.AddSeconds(1448302797.803)
  Monday, November 23, 2015 6:19:57 PM
  ```

## References

- [Standard Date and Time Format Strings in .NET][04]
- [Custom Date and Time Format Strings in .NET][03]
- [Formatting Dates and Times in PowerShell][05]
- [PowerTip: Use PowerShell to Format Dates][02]
- [Parsing Custom Date and Time Formats][01]
- [ParseExact() method][06]
- [Wikipedia - Epoch (reference date)][07]

<!-- link references -->
[01]: http://community.idera.com/powershell/powertips/b/tips/posts/parsing-custom-date-and-time-formats
[02]: https://devblogs.microsoft.com/scripting/powertip-use-powershell-to-format-dates/
[03]: https://docs.microsoft.com/dotnet/standard/base-types/custom-date-and-time-format-strings
[04]: https://docs.microsoft.com/dotnet/standard/base-types/standard-date-and-time-format-strings
[05]: https://docs.microsoft.com/previous-versions/windows/it-pro/windows-powershell-1.0/ee692801(v=technet.10)
[06]: https://learn.microsoft.com/dotnet/api/system.datetime.parseexact?view=net-8.0#overloads
[07]: https://wikipedia.org/wiki/Epoch_(reference_date)
[wp]: https://seanonit.wordpress.com/
