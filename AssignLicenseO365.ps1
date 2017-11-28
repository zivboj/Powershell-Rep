## USER.TXT FILE MUST HAVE USER UPN ROW BY ROW
#
Connect-MsolService
$users = Get-Content C:\Temp\Users.txt #can be replaced by get-aduser ..

$licenseOptions = New-MsolLicenseOptions -AccountSkuId "AccountSkuID" -DisabledPlans "SWAY", "Deskless", "FLOW_O365_P1", "POWERAPPS_O365_P1", "TEAMS1", "PROJECTWORKMANAGEMENT", "INTUNE_O365", "YAMMER_ENTERPRISE", "MCOSTANDARD"

foreach($user in $users)
{

Set-MsolUser -UserPrincipalName $user -UsageLocation 'AU'
Set-MsolUserLicense -UserPrincipalName $user -AddLicenses AccountSkuID -LicenseOptions $licenseOptions

}