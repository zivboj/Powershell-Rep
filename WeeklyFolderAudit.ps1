$adminPassword = ConvertTo-SecureString "Passsword" -AsPlainText -Force
$adminCreds = New-Object System.Management.Automation.PSCredential("AdminAccount", $adminPassword)

$folderAccess = Get-WinEvent -FilterHashtable @{logname="LogType";id="logId"} | Select-Object -Property TimeCreated, Message 



#For Each record the below will print of a list of specific details
$body = foreach($folderAccesses in $folderAccess)
{
echo $folderAccesses.TimeCreated
echo $folderAccesses.Message
echo "======================================"
echo " "
}

#echo $body > C:\temp\WeeklySecureFileAudit.txt

Send-MailMessage -Credential $adminCreds -SmtpServer 'ServerName' -UseSsl -Port 'ofChoiceUsually443or587;' -To 'EmailTo' -From 'EmailFrom' -Subject 'SubjectOfChoice' -Body ($body | Out-string)
