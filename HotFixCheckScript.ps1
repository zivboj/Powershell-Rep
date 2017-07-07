### Run in same directory as location of servers.txt
### 

$ComputerName = Get-Content ".\servers.txt"
$Cred = Get-Credential
ForEach($Computer in $ComputerName)
{

if(!(Get-HotFix -Id KB974332 -ComputerName $ComputerName -Credential $Cred ))
{
    Write-Output $Computer.Name >> C:\test.txt
}

}