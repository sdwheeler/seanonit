---
title: Using PowerShell and EWS to monitor a mailbox
date: 2014-10-29
draft: false
showReadTime: false
categories:
  - PowerShell
tags:
  - Exchange Web Services
  - EWS
description: An example of using PowerShell and Exchange Web Services to monitor a mailbox.
---
<!-- markdownlint-disable MD041 -->
> [!NOTE]
> This article was originally posted to my old [WordPress blog][wp]. The content is still relevant
> but some details may have changed.

I support a suite of application services that implement our ITIL processes. One of the functions
allows users to create trouble tickets by sending a specially crafted email message to a specific
email address. The application has a service that polls that mailbox once a minute to retrieve those
messages and create new Incidents. Periodically, that email polling service stops working causing
messages to queue up in the mailbox. The process is still running and providing other functions but
it is no longer processing the inbound messages. We have monitoring on the system to watch that
service and alert us when it hangs or crashes. However, since the service is still running, we never
get alerted.

I needed another way to monitor for this problem. What if I could create a script that would check
the mailbox to see if there were any messages in the Inbox that had arrived more than a few minutes
ago? Since the service polled the mailbox every minute, any message more than five minutes old would
indicate that the polling service had stopped functioning. But how can you read the Inbox?

In the past, I have used VBScript to automate Outlook and manage email on my desktop. However, I
didn't want to install Outlook on the server. Installing Outlook incurs licensing costs and is way
more overhead than I really need. That also means that I need to manage patching for Outlook and
other Office components on a server which we don't normally do in our environment. Searching the
internet I found some scriptable POP3 and IMAP clients. Some were commercial and some open source.
But the cost of these options (in money and learning curve) was too high and the supportability was
questionable.

We use Microsoft Exchange for our email services. I know that PowerShell is now the preferred method
for most management tasks in Exchange. This led me to search for Exchange PowerShell options.

Enter Exchange Web Services (EWS) and its friendly.NET managed API. Installing and using the EWS
Managed API is simple. It can be installed on any Windows machine and does not require any other
Exchange components. Simply download the MSI package and install it.

- The EWS Managed API is now available as an open source project on [GitHub][01]
- See the [EWS Managed API reference][02]

I am running this script as a scheduled task on Window Server 2008 R2. The scheduled task runs once
per hour and is configured to run with domain credentials that have access to the target mailbox.
The script uses EWS to access the mailbox and check for stale messages. It also uses
Net.Mail.SmtpClient to send alert messages. I could have used EWS to send the alert message but
Net.Mail.SmtpClient is so much easier to use.

```powershell
# title="Scan-Mailbox.ps1"
param(
    $mailboxName = 'new-tickets@contoso.com',
    $smtpServerName = 'smtp.contoso.com',
    $emailFrom = 'monitorservice@contoso.com',
    $emailTo = 'support@contoso.com'
)

# Load the EWS Managed API
Add-Type -Path 'C:\Program Files\Microsoft\Exchange\Web Services\2.2\Microsoft.Exchange.WebServices.dll'

try {
    $Exchange2007SP1 = [Microsoft.Exchange.WebServices.Data.ExchangeVersion]::Exchange2007_SP1
    $Exchange2010    = [Microsoft.Exchange.WebServices.Data.ExchangeVersion]::Exchange2010
    $Exchange2010SP1 = [Microsoft.Exchange.WebServices.Data.ExchangeVersion]::Exchange2010_SP1
    $Exchange2010SP2 = [Microsoft.Exchange.WebServices.Data.ExchangeVersion]::Exchange2010_SP2
    $Exchange2013    = [Microsoft.Exchange.WebServices.Data.ExchangeVersion]::Exchange2013
    $Exchange2013SP1 = [Microsoft.Exchange.WebServices.Data.ExchangeVersion]::Exchange2013_SP1

    # create EWS Service object for the target mailbox name
    $exchangeService = [Microsoft.Exchange.WebServices.Data.ExchangeService]::new($Exchange2010SP2)
    $exchangeService.UseDefaultCredentials = $true
    $exchangeService.AutodiscoverUrl($mailboxName)

    # bind to the Inbox folder of the target mailbox
    $inboxFolderName = [Microsoft.Exchange.WebServices.Data.WellKnownFolderName]::Inbox
    $inboxFolder = [Microsoft.Exchange.WebServices.Data.Folder]::Bind(
        $exchangeService, $inboxFolderName)

    # Optional: reduce the query overhead by viewing the inbox 10 items at a time
    $itemView = [Microsoft.Exchange.WebServices.Data.ItemView]::new(10)
    # search the mailbox for messages older than 15 minutes
    $dateTimeItem = [Microsoft.Exchange.WebServices.Data.ItemSchema]::DateTimeReceived
    $15MinutesAgo = (Get-Date).AddMinutes(-15)
    $searchFilter = [Microsoft.Exchange.WebServices.Data.SearchFilter+IsLessThanOrEqualTo]::new(
        $dateTimeItem, $15MinutesAgo)
    $foundItems = $exchangeService.FindItems($inboxFolder.Id, $searchFilter, $itemView)

    # report the results via email and Application event log
    $entryType = 'Information'
    $date = Get-Date -Format 'MM/dd/yyyy hh:mm:ss'
    $messageBody = "Self-service mailbox scan completed at {0}.`r`n" -f $date
    if ($foundItems.TotalCount -ne 0) {
        $entryType = 'Warning'
        $subject = 'Self-service mailbox hung'
        $messageBody = "Inbox has {0} message(s) that are more than 15 minutes old.`r`n" -f $foundItems.TotalCount
        $messageBody += "Inbox has {0} message(s) total.`r`n`r`n" -f $inboxFolder.TotalCount
        $messageBody += "Please restart the Email Engine on SERVER01`r`n"
        $messageBody += "Self-service mailbox scan completed at {0}.`r`n" -f $date
        $messageBody += "Script run from $env:computername`r`n"

        $smtpClient = [Net.Mail.SmtpClient]::new($smtpServerName)
        $smtpClient.Send($emailFrom, $emailTo, $subject, $messageBody)
    }
    $writeEventLogSplat = @{
        LogName = 'Application'
        Source = 'Application'
        EventId = 1
        Category = 4
        EntryType = $entryType
        Message = $messageBody
    }
    Write-EventLog @writeEventLogSplat
} catch {
    $entryType = 'Error'
    $subject = 'Error in mailbox monitor script'
    $messageBody = "{0}`r`n{1}" -f $_.Exception.Message, $_.InvocationInfo.PositionMessage
    $writeEventLogSplat = @{
        LogName = 'Application'
        Source = 'Application'
        EventId = 1
        Category = 4
        EntryType = $entryType
        Message = $messageBody
    }
    Write-EventLog @writeEventLogSplat
    $smtpClient = [Net.Mail.SmtpClient]::new($smtpServerName)
    $smtpClient.Send($emailFrom, $emailTo, $subject, $messageBody)
}
```

<!-- link references -->
[01]: https://github.com/officedev/ews-managed-api
[02]: https://learn.microsoft.com/dotnet/api/microsoft.exchange.webservices.data.emailmessage?view=exchange-ews-api
[wp]: https://seanonit.wordpress.com/
