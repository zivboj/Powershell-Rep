# get-content computers.txt | foreach \{ if (!(get-hotfix -id KB974332 -computername $_)) \{ add-content $_ -path Missing-KB974332.txt \}\}




$ComputerName = Get-ADComputer -SearchBase "Choose OU"
$Cred = Get-Credential
ForEach($Computer in $ComputerName)
{

if(!(Get-HotFix -Id KB974332 -ComputerName $ComputerName -Credential $Cred ))
{
    Write-Output $Computer.Name >> C:\test.txt
}

}