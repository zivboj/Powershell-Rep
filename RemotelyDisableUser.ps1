##Run within Enter-PSSession on AD server

echo "Enter username to disable:"
$userInput = Read-Host

Import-Module ActiveDirectory
Disable-ADAccount -server gr-vmdc01 -Identity $userInput
