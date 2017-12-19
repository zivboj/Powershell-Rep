$newproxy = "@domain.com.au"
$userou = "Specific OU with Users"
$users = Get-ADUser -Filter * -SearchBase $userou -Properties SamAccountName, ProxyAddresses 

Foreach ($user in $users) {
    Get-ADUser -Filter "SamAccountName -eq '$($user.SamAccountName)'" -Properties * | 
    Set-ADUser -Add @{Proxyaddresses="SMTP:"+($user.SamAccountName + $newproxy)}
    echo $user
    
    } 
    


