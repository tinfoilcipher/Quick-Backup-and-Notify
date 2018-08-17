# Quick-Backup-and-Notify
Quick and Dirty Backup and Notification Routine utilizing robocopy and the PowerShell SMTP sending function.

## OUTLINE
The purpose of this script is to provide a "quick and dirty" solution to opearting a backup and notification function where a
proper backup system does not exist.

## USE - GENERAL
The script should work with any mail server than supports the SMTP protocol, have tested with Exchange (2010, 2013, Exchange Online
and EXIM) though as the protocol is standardized not much variance should be expected.

After making the configurations to the various blocks below, the robocopy routine runs a mirror to a datestamped folder with secfix
and sends an email. The default configuration is to email over an open relay over port 25. Comment/Uncomment one of the three "Send-MailMessage" statements as appropriate for your configuration.

## CONFIGURATION
### MAIL CONFIG
The following variables should be set<br/>
**$strSMTPServer - The FQDN or routable IP address of the SMTP server being used for send**<br/>
**$strEmailFrom - Sender is irrelevant in accordance with the SMTP protocol, the domain is all that matters**<br/>
**$strEmailTo - Valid SMTP address in the recipient domain**<br/>
**$strSubject - Email Subject**<br/>

### AUTHENTICATION CONFIG
These variables can remain commented out if there is an open relay to the target SMTP server and are used for authenticated
sending only.</br>
**In the event of needing to use authenticated sending it is strongly advised not to use plain text to to run the encrypted_string_generation.ps1 script to generate an encrypted password**</br>
<br/>
**$strCryptString - .txt file containing the encrypted password for authenticting user, output of encrypted_string_generation.ps1**<br/>
**$strUsername - Authenticating username**<br/>

### BACKUP CONFIG
These variables will define how the backup runs and which data is backed up
**$strSource = The folder to be backed up, by default all child folders are backed up**<br/>
**strTarget = The folder that data is being backed up to, this will be automatically modified to be unique**<br/>
**strLogName = An itentifiable name for your logs**

