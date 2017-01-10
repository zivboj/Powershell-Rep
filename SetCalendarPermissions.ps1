
$allusers = Get-DistributionGroupMember -Identity "Global Red Sydney" | ForEach-Object {Add-MailboxFolderPermission -identity "IT Leave Calendar" -user $_.Name -accessrights reviewer} 

# echo $allusers.Name

##echo $allusers

#ForEach-Object {Add-MailboxFolderPermission -identity "IT Leave Calendar" -user $allusers.Name -accessrights reviewer}
