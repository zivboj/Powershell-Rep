$adGroupUsers = Get-ADGroupMember -Identity "O365 Sync" | Select -Property samaccountname 
$table = @()
foreach($user in $adGroupUsers)
{
$table +=   Get-ADUser -Identity $user.samaccountname -Properties proxyaddresses | % {
    foreach ($addr in ($_.proxyaddresses | ? {$_ -match '^*'})) {
        [pscustomobject]@{
            name = $_.samaccountname
            SMTPproxyaddresses = $addr
        }
    }
}

} 
