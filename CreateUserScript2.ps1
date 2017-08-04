## add here the run as

##String Declarations 
$letterValidation = '^[a-zA-Z]+$'
$emailAddress= '@email.com'


##Import Modules for Script to Work
Import-Module ActiveDirectory

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


$userPassword = Read-host -Prompt 'Input User Password' -AsSecureString

##Post input Strings
$userFullName= ($userFirstName + ' ' + $userLastName)
$userFirstLast = ($userFirstName + '.' + $userLastName)
$userEmail = ($userFirstLast + $emailAddress)

$userFirstNameTrim = $userFirstName.Substring(0,5)
$userlastNameTrim = $userlastName.Substring(0,1)
$userCountNum = 1
$userSamaccountName = $userFirstNameTrim + $userlastNameTrim + "0" + $userCountNum

#############FUUUUUUUUUUUU stuck at user search

# $userSamaccountName = $userFirstNameTrim + $userlastNameTrim + "0" + $userCountNum
# $userCountNum++

# }
# while((Get-ADUser -Identity $userSamaccountName) -ne $Null)


# else {
#     $userSamaccountName = $userFirstNameTrim + $userlastNameTrim + "02"
#     Write-Output 02
# }



##User creation script
##New-ADUser -Name $userFullName -UserPrincipalName $userEmail -DisplayName $userFullName -GivenName $userFirstName -Surname $userLastName -EmailAddress $userEmail -SamAccountName $userFirstLast -Department $userDepartment -Manager $userManager -Path 'OUPATH'-OtherAttributes @{title=$userTitle; proxyAddresses="SMTP:" + ($userFirstLast + $emailAddress)} -Server coredc004

