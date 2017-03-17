$ADUsers = Get-ADUser -SearchBase "MainOUWhereSubOUFoldersAreFound" -Filter "*"

ForEach($ADUser in $ADUsers){

if(($ADUser.DistinguishedName -match "SpecificOUPAth1"))
{
Add-ADGroupMember -Identity "Group1" -Members $ADUser
}

{
if(($ADUser.DistinguishedName -match "SpecificOUPAth2"))
{
Add-ADGroupMember -Identity "Group2" -Members $ADUser

}
if(($ADUser.DistinguishedName -match "SpecificOUPAth3"))
{
Add-ADGroupMember -Identity "Group3" -Members $ADUser
}
}
}