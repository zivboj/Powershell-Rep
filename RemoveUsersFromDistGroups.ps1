#Removes all dist groups from users in Ou of choice

$users = Get-ADUser -Filter * -Properties * -SearchBase "OU of Choice"


Foreach ($user in $users)
{

$groups = Get-ADPrincipalGroupMembership -Identity $user.SamAccountName 

    if ($groups -contains "Domain Users")
    {
    echo "No users to remove for $user.Name"
    }
        Else
        {
            foreach ($group in $groups) 
            {
            Remove-ADGroupMember -Identity $group.Name -Members $user.distinguishedName 
            }
        }
}