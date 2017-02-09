#PLEASE RUN AS ADMINISTRATOR
#
echo "Enter username(firstname.lastname) to disable:"
$userInput = Read-Host

Import-Module ActiveDirectory
Disable-ADAccount -server gr-vmdc01 -Identity $userInput

$AdGroups = Get-ADPrincipalGroupMembership -Identity $userInput | where {$_.Name -ne "Domain Users"}
Remove-ADPrincipalGroupMembership -Identity "$userInput" -MemberOf $ADgroups -Confirm:$false