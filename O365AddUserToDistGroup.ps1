.\ConnectToO365.ps1

$users = Get-content -Path C:\Temp\Users.txt

foreach($user in $users)
{
    Add-DistributionGroupMember -Identity "DistGroupName" -Member $users
}