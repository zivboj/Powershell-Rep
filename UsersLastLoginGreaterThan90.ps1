$searchBases = "OUPATH" 

foreach($searchBase in $searchBases)
{
$users = Search-ADAccount -UsersOnly -AccountInactive -TimeSpan 90 -SearchBase $searchBase 
foreach($user in $users)
{
if($user -notmatch 'train' -and $user -notmatch 'after')
{
    if($user -notmatch 'test' -and $user -notmatch 'syd')
    {
        if($user -notmatch 'svc' -and $user -notmatch 'service')
        {
        echo $user | Select-Object -Property Name, LastLogonDate
        }
    
    }
}
}
}

#dsquery user "OU=DistributionGroups,OU=People,DC=hfs,DC=local" -inactive 12 -limit 0 | dsget user -upn -disabled | select-string "^(?!.*train)" | select-string "^(?!.*yes)"  > C:\Temp\PCI-DistributionGroupssep2016.txt
#dsquery user "OU=External,OU=People,DC=hfs,DC=local" -inactive 12 -limit 0 | dsget user -upn -disabled | select-string "^(?!.*train)" | select-string "^(?!.*yes)" > C:\Temp\PCI-Externalsep2016.txt
