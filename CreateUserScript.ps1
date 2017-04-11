##String Declarations 
$letterValidation = '^[a-zA-Z]+$'
$emailAddress= '@lifecycledigital.com'

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


$userFullName= ($userFirstName + ' ' + $userLastName)
 
$userFirstLast = ($userFirstName + '.' + $userLastName)



##User creation script
New-ADUser -Name $userFullName -DisplayName $userFullName -GivenName $userFirstName -Surname $userLastName -EmailAddress ($userFirstLast + $emailAddress) -SamAccountName $userFirstLast -Department $userDepartment -Manager $userManager -Path 'OU=Staff,DC=lifecycledigital,DC=com'-OtherAttributes @{title=$userTitle; proxyAddresses="SMTP:" + ($userFirstLast + $emailAddress)}


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
