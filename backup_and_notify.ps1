#Generic Script for dirty backup and notification - tinfoilcipher 2016

####################################################################################################################################
# Mail Configuration block
$strSMTPServer = "mailserver.domain" #--FQDN or routable IP address of the SMTP server you will be sending your mail via
$strEmailFrom = "no-reply@yourdomain"  #--Sender is irrelevant in accordance with the SMTP protocol, the domain is all that matters
$strEmailTo = "validaddress@yourdomain" #--Valid SMTP address in the recipient domain
$strSubject = "Data Backup Report" #--Email Subject
####################################################################################################################################

####################################################################################################################################
# Authentication Configuration Block
# 
# If the email is to be sent over an open relay, this whole segment can remain commented out. It
# only needs to be uncommented below this point if you intend to authenticate over an authenticated
# connector.
# 
# $strCryptString = Get-Content "EncryptedString.txt" #--Use the encrypted_string_generation.ps1 script to generate a key
# $strUsername = "username@domain" #--Authenticating username for mail server sending
# $strPassword = ConvertTo-SecureString -String $strCryptString -Key (1..16)
# $strCredential = New-Object System.Management.Automation.PsCredential($strUsername,$strPassword)
####################################################################################################################################

####################################################################################################################################
# Backup Config Block
$strDate = Get-Date -format "MM-dd-yyyy"
$strSource = "C:\FolderName" #--Source for copy, a local path works best
$strTarget = "\\Server\Share\Folder" #--Target for copy, UNC works best
$strTargetReal = ($strTarget + $strDate) #--DO NOT
$strLogName = "BACKUP_LOG_NAME" #--Set a name to identify the name
$strLog = ("C:\FolderName\" + $strLogName + $strDate + ".txt") #--Log location, .txt file works best
####################################################################################################################################

# Backup
robocopy $strSource $strTargetReal /MT:8 /MIR /SEC /SECFIX /R:5 /W:0 /LOG:"$strLog" /TEE #--This statement runs a mirror with secfix on a daily basis to a new folder, any robocopy syntax is fine

#Sending Methods
$strBody = Get-Content $strLog
Send-MailMessage -To $strEmailTo -From $strEmailFrom -Subject $strSubject -Body $strBody -smtpServer $strSMTPServer #--Open Relay
# Send-MailMessage -To $strEmailTo -From $strEmailFrom -Subject $strSubject -Body $strBody -smtpServer $strSMTPServer -Credential $strCredential -usessl #--Use Authentication and SSL
# Send-MailMessage -To $strEmailTo -From $strEmailFrom -Subject $strSubject -Body $strBody -smtpServer $strSMTPServer -Credential $strCredential #--Use Authentication without SSL
