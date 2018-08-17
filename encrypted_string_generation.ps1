# Generate Secure String for 365 Connection - A Welsh 2016
# https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.security/convertto-securestring?view=powershell-6

Clear-Host
Write-Host "Enter Password to Be Encrypted Below"
$strSecure = Read-Host -AsSecureString
$strOutput = "EncryptedString.txt"
$strEncrypted = ConvertFrom-SecureString -SecureString $strSecure -Key (1..16)
$strEncrypted | Set-Content $strOutput

Write-Host ""
Write-Host "Encrypted string has been saved to" $strOutput "- Copy this file to the same location as the backup and notify script."
