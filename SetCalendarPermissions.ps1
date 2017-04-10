
$allusers = Get-DistributionGroupMember -Identity "DistGroupName" | ForEach-Object {Add-MailboxFolderPermission -identity "CalendarRequiringAccess" -user $_.Name -accessrights reviewer} 
