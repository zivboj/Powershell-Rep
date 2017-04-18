## MUST BE RUN FROM DC
##
## Must Have Following Modules Installed
## ActiveDirectory,  MSOnline, ADSync
## 


##String Declarations 
$letterValidation = '^[a-zA-Z]+$'
$emailAddress= '@lifecycledigital.com'


##Import Modules for Script to Work
Import-Module ActiveDirectory
Import-Module MSOnline
Import-Module ADSync

##Connect to O365
Connect-MsolService

##User input validation
do 
{
$userFirstName = Read-Host -Prompt 'Input FirstName of New User' 
}
Until($userFirstName -match $letterValidation)

do
{
$userLastName = Read-Host -Prompt 'Input Lastname of New User'
}
Until($userlastName -match $letterValidation)

do
{
$userTitle = Read-Host -Prompt 'Input Title of user i.e. accountant, engineer'
}
Until($userTitle -match $letterValidation)

do
{
$userDepartment = Read-Host -Prompt 'Input User Department i.e. Development, Marketing'
}
Until($userDepartment -match $letterValidation)


$userManager = Read-Host -Prompt 'Input Users Manager e.g John.Smith'

do
{
$userCountry = Read-Host -Prompt 'Input Users Country of work e.g Australia, India, Singapore'
}
Until ($userCountry -match $letterValidation)

$userPassword = Read-host -Prompt 'Input User Password' -AsSecureString

##Post input Strings
$userFullName= ($userFirstName + ' ' + $userLastName)
$userFirstLast = ($userFirstName + '.' + $userLastName)
$userEmail = ($userFirstLast + $emailAddress)

##User creation script
New-ADUser -Name $userFullName -UserPrincipalName $userEmail -DisplayName $userFullName -GivenName $userFirstName -Surname $userLastName -EmailAddress $userEmail -SamAccountName $userFirstLast -Department $userDepartment -Manager $userManager -Path 'OU=Staff,DC=lifecycledigital,DC=com'-OtherAttributes @{title=$userTitle; proxyAddresses="SMTP:" + ($userFirstLast + $emailAddress)}

##Based on country moves user to specific OU
switch ($userCountry)
{
"Australia" {Get-ADuser $userFirstLast | Move-ADObject -TargetPath "OU=Users,OU=AU,OU=Staff,DC=lifecycledigital,DC=com"}
"India" {Get-ADUser $userFirstLast | Move-ADObject -TargetPath 'OU=Users,OU=IN,OU=Staff,DC=lifecycledigital,DC=com'}
"Singapore" {Get-ADUser $userFirstLast | Move-ADObject -TargetPath 'OU=Users,OU=SG,OU=Staff,DC=lifecycledigital,DC=com'}
default {echo "no country provided"}

} 

##Based on user role title add user to dis/sec groups
if(($userTitle -eq 'Developer'))
{
Add-ADGroupMember -Identity 'Devalerts' -Members $userFirstLast
Add-ADGroupMember -Identity 'Developers' -Members $userFirstLast
Add-ADGroupMember -Identity 'Reporting QA' -Members $userFirstLast
Add-ADGroupMember -Identity 'Reporting Prod' -Members $userFirstLast
}

if(($userTitle -eq 'Marketing'))
{
Add-ADGroupMember -Identity 'Group1' -Members $userFirstLast
Add-ADGroupMember -Identity 'Group2' -Members $userFirstLast
Add-ADGroupMember -Identity 'Group3' -Members $userFirstLast
}


if(($userTitle -eq 'Sales'))
{
Add-ADGroupMember -Identity 'Group1' -Members $userFirstLast
Add-ADGroupMember -Identity 'Group2' -Members $userFirstLast
Add-ADGroupMember -Identity 'Group3' -Members $userFirstLast
}

if(($userTitle -eq 'Finance'))
{
Add-ADGroupMember -Identity 'Group1' -Members $userFirstLast
Add-ADGroupMember -Identity 'Group2' -Members $userFirstLast
Add-ADGroupMember -Identity 'Group3' -Members $userFirstLast
}


##Starts Sync to O365, Enable Account, Reset Password
Get-ADUser -Identity $userFirstLast | Set-ADAccountPassword -NewPassword $userPassword -Reset             
Enable-ADAccount -Identity $userFirstLast
Start-ADSyncSyncCycle -PolicyType Delta -Verbose

Start-Sleep -Seconds 480


$mailboxExists = Get-MsolUser -UserPrincipalName $userEmail

##Set User Office License to Australia and provide license
do{
Sleep -Seconds 120
Set-MsolUser -UserPrincipalName $userEmail -UsageLocation 'AU'
Set-MsolUserLicense -UserPrincipalName $userEmail -AddLicenses globalredpty:O365_BUSINESS_PREMIUM 
$mailboxExists = Get-MsolUser -UserPrincipalName $userEmail
}while($mailboxExists -eq $null)
