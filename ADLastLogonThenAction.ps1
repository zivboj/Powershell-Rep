$Deparmentusers = Get-ADUser -Filter {(Enabled -eq "True")} -SearchBase "OU OF CHOICE" -Properties lastlogondate | ?{($_.distinguishedname -notlike '*ServiceAcc*') -or ($_.name -notlike "*svc*")}| Select-Object -Property Name, Enabled, lastlogondate | select-string "^(?!.*train)" | select-string "^(?!.*yes)"
$CutOffDate = (Get-Date).adddays(-30)


foreach ($user in $users)

 {
 if ($user.LastLogonDate -le $CutOffdate -and $user.Enabled -eq $True)
 {
 echo $user # replace with Disable-ADAccount -Identity $user.SamAccountName
 }

 }