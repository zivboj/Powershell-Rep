### Run in same directory as location of servers.txt
### 
$ComputerName = Get-Content ".\servers.txt"
$Cred = Get-Credential
$Cred2 = Get-Credential

ForEach($Computer in $ComputerName)
{
$localUsers = Get-WmiObject -Class win32_useraccount -ComputerName $Computer -Filter "LocalAccount = True"
    If ($localUsers.Name -like 'admin')
    {
        if(!(Get-HotFix -Id KB974332 -ComputerName $ComputerName -Credential $Cred ))
            {
             Write-Output $Computer.Name " Missing KB" >> C:\test.txt
            }

    }
    elseif ($localUsers -like '_GFSGuest') 
    {
       {
        if(!(Get-HotFix -Id KB974332 -ComputerName $ComputerName -Credential $Cred2 ))
            {
             Write-Output $Computer.Name + "Missing KB" >> C:\test.txt
            }

    }

    }
}



##ForEach($Computer in $ComputerName)
##{   
#       if(!(Get-HotFix -Id KB974332 -ComputerName $ComputerName -Credential $Cred ))
#    {
#        Write-Output $Computer.Name >> C:\test.txt
#    }
#
#}




