$Managers = Get-ADUser -Filter * -SearchBase "OUOfChoicel" | Select-Object -Property SamAccountName, Name
$SalesAgents = Get-ADUser -Filter * -SearchBase "OUofChoice" | Select-Object -Property SamAccountName, Name

$Managers | Export-Csv C:\Temp\test.csv
$SalesAgents | Export-Csv C:\Temp\test2.csv


