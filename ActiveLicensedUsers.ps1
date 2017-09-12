Connect-MsolService

Get-MsolUser -all | Where-Object {$_.isLicensed -eq $true} | Select-Object -Property UserPrincipalName, DisplayName, Country, Department, lastlogontime | Export-Csv C:\Temp\asLicensedUsers.csv