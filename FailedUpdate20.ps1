$adminPassword = ConvertTo-SecureString "PASSWORD" -AsPlainText -Force
$adminCreds = New-Object System.Management.Automation.PSCredential("EmailOfChocie", $adminPassword)
$server = hostname
$UpdateResult = Get-WinEvent -FilterHashtable @{LogName = "System";ID= 20} | ForEach-Object -Process {            
    Get-EventLog -Index ($_.RecordID)  -LogName $($_.LogName)            
} | Select-Object -Property InstanceID, Message 


$body = if (($UpdateResult.InstanceID -match '20'))
{

echo "Updates have failed on $hostname"
echo "================================"
echo $UpdateResult

}

Send-MailMessage -Credential $adminCreds -SmtpServer smtp.office365.com -UseSsl -Port '587' -To 'EmailTo' -From 'FromEmail' -Subject 'Update Failed' -Body ($body | Out-string)

