---
title: Use PowerShell and EWS to find out who is sending you email
date: 2015-03-18T07:46:24
draft: false
---
I get a lot of email from a lot of different sources. A lot of it is from automated alerts generated
by services accounts that monitor various applications that my team supports. Each month I like to
see how many messages I have gotten from the various sources. Looking at these numbers over time can
be helpful to identify trends. If we are suddenly getting more alerts from a particular sender then
we may want to look more closely at the health of that system. Using Outlook's rules engine I send
all of these alert messages to a specific folder. Now I just need an easy way to count them. I
created a script that scans that folder and counts the number of messages from each sender. The
output looks like this:

```
Count Name
----- ----
   10 Service Account A <SMTP:svca@contoso.com>
   10 Ops Monitor 2 <SMTP:opsmon2@contoso.com>
    7 Ops Monitor 3 <SMTP:opsmon3@contoso.com>
    6 Service Account D <SMTP:svcd@contoso.com>
    6 Service Account E <SMTP:svce@contoso.com>
```

The script is pretty simple. I created two functions:

- one to find the specific folder in the mailbox
- one to iterate through all the items in the folder

To find the target folder you must walk the folder tree until you reach your destination. Once you
have the target folder you can create an ItemView and search for all the messages in the folder.
PowerShell's `Group-Object` cmdlet does the work of counting for you.

```powershell
# Filename: get-sendercount.ps1
# Load the EWS dll
Add-Type -Path 'C:\Program Files\Microsoft\Exchange\Web Services\2.2\Microsoft.Exchange.WebServices.dll'

#-----------------------------------------------------
function GetTargetFolder {
   param([string]$folderPath)

   $fldArray = $folderPath.Split("\")
   $tfTargetFolder = $MsgRoot

   for ($x = 1; $x -lt $fldArray.Length; $x++)
   {
      #$fldArray[$x]
      $fvFolderView = new-object Microsoft.Exchange.WebServices.Data.FolderView(1)
      $SfSearchFilter = new-object Microsoft.Exchange.WebServices.Data.SearchFilter+IsEqualTo(
         [Microsoft.Exchange.WebServices.Data.FolderSchema]::DisplayName,
         $fldArray[$x]
      )
      $findFolderResults = $service.FindFolders($tfTargetFolder.Id,$SfSearchFilter,$fvFolderView)
      if ($findFolderResults.TotalCount -gt 0)
      {
         foreach($folder in $findFolderResults.Folders)
         {
             $tfTargetFolder = $folder
         }
      }
      else
      {
         "Error Folder Not Found"
         $tfTargetFolder = $null
         break
      }
   }
   $tfTargetFolder
}
#-----------------------------------------------------
function GetItems {
   param ($targetFolder)
   #Define ItemView to retrive just 100 Items at a time
   $ivItemView = New-Object Microsoft.Exchange.WebServices.Data.ItemView(100)

   $AQSString = $null  #find all messages
   do
   {
        $fiItems = $service.FindItems($targetFolder.Id,$AQSString,$ivItemView)
        foreach($Item in $fiItems.Items)
        {
            $Item.Load()
            $Item
        }
        $ivItemView.Offset += $fiItems.Items.Count
   }
   while($fiItems.MoreAvailable -eq $true)
}
#-----------------------------------------------------
$ExchangeVersion = [Microsoft.Exchange.WebServices.Data.ExchangeVersion]::Exchange2010_SP2
$service = New-Object Microsoft.Exchange.WebServices.Data.ExchangeService($ExchangeVersion)

$service.UseDefaultCredentials = $true
$MailboxName = "mymailbox@contoso.com"
$service.AutodiscoverUrl($MailboxName)

#Bind to the Root of the mailbox so I can search the folder namespace for the target
$MsgRootId = [Microsoft.Exchange.WebServices.Data.WellKnownFolderName]::MsgFolderRoot
$MsgRoot = [Microsoft.Exchange.WebServices.Data.Folder]::Bind($service,$MsgRootId)
$targetFolder = GetTargetFolder '\Inbox\Alert Message\Current'

$itemList = GetItems $targetFolder
$itemList | group-object Sender -noelement | sort Count -desc | ft -a
```
