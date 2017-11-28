##REQUIRES TO RUN AS ACCOUNT WITH AD PERMSSIONS (i.e. CREATE FOLDERS)
##REQUIRES TO BE FIRST CONNECTED TO OFFICE365 VIA SESSION NOT CONNECT-MSOLSERVICE
##Connect to Office365 Script in same repo titled ConnectToO365.PS1


#Change filepath of ConnectToO365.ps1 as required.
#.\ConnectToO365.ps1

#Removing Identity gets all Distribution Groups
$O365DistGroups = Get-DistributionGroup -Identity "GroupOfChoice"

#Main For each loop that creates groups
foreach ($O365Group in $O365DistGroups)
{
$0365GroupSamAcc = $O365Group.PrimarySmtpAddress -replace '@domain.com.au'

New-ADGroup $O365Group.DisplayName -SamAccountName $O365GroupSamAcc -Path "OUOfChoice" -GroupScope Universal -GroupCategory Distribution -DisplayName $O365Group.DisplayName -OtherAttributes @{'mail'=$O365Group.PrimarySmtpAddress}

$O365GroupMembers = Get-DistributionGroupMember -Identity $O365Group.Name 



    #For Each loop that adds users to newly created AD Group
    foreach ($O365GroupMember in $O365GroupMembers)
    {
    $AdName = $O365GroupMember.Name
    $AdUserName = Get-Aduser -Filter {name -like $adName}
    Add-ADGroupMember -Identity $O365Group.DisplayName -Members $AdUserName.samaccountname
    }
}

 