$Managers = Get-ADUser -Filter * -SearchBase "OU=SCManagers-7,OU=SalesOperationsWin7,OU=Departments,OU=People,DC=hfs,DC=local" | Select-Object -Property SamAccountName, Name
$SalesAgents = Get-ADUser -Filter * -SearchBase "OU=ServiceAgents-7,OU=SalesOperationsWin7,OU=Departments,OU=People,DC=hfs,DC=local" | Select-Object -Property SamAccountName, Name

$Managers | Export-Csv C:\Temp\test.csv
$SalesAgents | Export-Csv C:\Temp\test2.csv


