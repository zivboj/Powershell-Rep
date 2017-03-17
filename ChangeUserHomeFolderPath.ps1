$oldServerName = 'OldServerName'
$newServerName = 'NewServer'

$AllUsers = Get-ADUser -SearchBase 'OUWhereChangesAreMade' -Filter * -Properties HomeDirectory

foreach($user in $AllUsers)
{
    if(($user.HomeDirectory -match $oldServerName.HomeDirectory))
    {
        Set-ADUser $user.DistinguishedName -HomeDirectory $($newServerName + $user.SamAccountName) -HomeDrive 'U:' -verbose
    }
}