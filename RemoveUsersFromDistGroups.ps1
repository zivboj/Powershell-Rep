#Removes all dist groups from users in Ou of choice

$users = Get-ADUser -Filter * -Properties * -SearchBase "OUPATH"


Foreach ($user in $users)
{

$user.MemberOf | Select-String -Pattern ($user.MemberOf -notmatch "Domain Users") | Remove-ADGroupMember -Members $user.distinguishedName 

}
