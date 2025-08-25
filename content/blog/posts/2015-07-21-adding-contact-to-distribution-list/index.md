---
title: Adding a Contact to a Distribution List with PowerShell
date: 2015-07-21T10:27:02
draft: false
showReadTime: false
categories:
  - PowerShell
  - Active Directory
tags:
  - contact
  - distribution list
  - ADSI
description: >
  Work around the limitation of the ActiveDirectory module using the [adsi] type accelerator.
---
<!-- markdownlint-disable MD041 -->
> [!NOTE]
> This article was originally posted to my old [WordPress blog][wp]. The content is still relevant
> but some details may have changed.

The PowerShell ActiveDirectory module has a lot of great features that I use on a daily basis.
However, there is one shortcoming that I have struggled with for a while. I did a lot of internet
searching and testing to see if I was missing some hidden secret. But, alas, this is one task that
the AD module does not do. Here is the scenario. We have a lot of AD Groups (Distribution Lists) we
use for notification messages. We want to send notifications to mobile devices. We do this by
sending an email to the devices email address. For example:

```
2065551212@mobilecarrier.xyz.com
```

These external email addresses are created as Contact objects in AD. The problem is that the cmdlets
for managing AD group objects only allow you to add objects that have a SamAccountName (and
therefore a SID) to a group. This is fine for user and group objects. But Contact objects to not
have SIDs. So now what do you do. The answer is you do it the old way you would have done it in
VBScript; use ADSI.

```powershell
$dlGroup = [adsi]'LDAP://CN=DL-Group Name,OU=Corp Distribution Lists,DC=contoso,DC=net'
$dlGroup.Member.Add('CN=mobile-username,OU=Corp Contacts,DC=contoso,DC=net')
$dlGroup.psbase.CommitChanges()
```
<!-- link references -->
[wp]: https://seanonit.wordpress.com/
