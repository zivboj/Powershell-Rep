<# Script Information

Script Name:        Form2.ps1
Script Location:    
Script Author:      Bojan and Michael
Script Maintainer:  

Run Command:        .\Form2.ps1
Parameters:         (none)                   

Script Requirement:
Replace the manual form 2 process

Script Outline:
Read the code

#>
Clear-Host
Import-Module ActiveDirectory
[System.Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic') | Out-Null
$strTargetUser = [Microsoft.VisualBasic.Interaction]::InputBox("Enter a username in samAccountName format", "Set target user", $strTargetUser)
$strCurrentManager = Get-ADUser -Identity $strTargetUser -Properties manager
$strCurrentManager = $strCurrentManager.Manager
$strCurrentManager = Get-ADUser -Identity $strCurrentManager
$strCurrentManager = $strCurrentManager.SamAccountName
$strDirectReports = Get-ADUser -Filter {manager -eq $strCurrentManager} -ResultSetSize 1
$strDirectReports = $strDirectReports.SamAccountName
Write-Host "Target: $strTargetUser"
Write-Host "Current Manager: $strCurrentManager"
Write-Host "Current Direct Reports: $strDirectReports"

    $strMemberOf = Get-ADPrincipalGroupMembership $strDirectReports | select name
        foreach ($strMembergroup in $strMemberOf)
            {
                
               $strAddG = Add-ADGroupMember -Identity ($strMembergroup.Name) -Members $strTargetUser
                
            }

#$strTargetManager = [Microsoft.VisualBasic.Interaction]::InputBox("Enter a manager in samAccountName format", "Set target manager")
