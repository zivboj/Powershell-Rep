## AtThisMoment the $adminPassword and $adminCreds are used to specifically to bypass O365 Login
## Ideally having a local SMTP server or one that does not need authentication would simplify the script

$cpuCount = 0
$adminPassword = ConvertTo-SecureString "PassWord" -AsPlainText -Force
$adminCreds = New-Object System.Management.Automation.PSCredential("EmailUserName", $adminPassword)

#Sets Checks the CPU Usage every 30 Seconds
do{
Start-Sleep -Seconds 30
$cpuCounter = Get-Counter '\Processor(_Total)\% Processor Time' | Select-Object -ExpandProperty CounterSamples | Select-Object -ExpandProperty CookedValue
$cpuCount = $cpuCount + 1
}while ($cpuCount -le '3')


if($cpuCount -gt '3' -and $cpuCounter -gt '90.0')
{
Send-MailMessage -Credential $adminCreds -SmtpServer smtp.office365.com -UseSsl -Port 587 -To 'EmailTo' -From 'EmailFrom' -Subject 'CPU UsageOver 90' -Verbose -Body

}

