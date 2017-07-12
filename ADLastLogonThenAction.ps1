$users = Get-ADUser -Filter * -pr lastlogondate
$CutOffDate = (Get-Date).adddays(-30)


foreach ($user in $users)

 {
 if ($user.LastLogonDate -le $CutOffdate -and $user.Enabled -eq $True)
 {
 echo $user # replace with Disable-ADAccount -Identity $user.SamAccountName
 }

 }
