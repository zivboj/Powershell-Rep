#Removes from disabled users All dist groups and sec groups they're memebers of
#With Adjustment could be used for mailbox permissions.
#
Import-Module ActiveDirectory

$searchOU = "OU=Example,DC=Example,DC=Example,DC=Example"

Get-ADGroup -Filter 'GroupCategory -eq "Security" -or GroupCategory -eq "Distribution"' -SearchBase $searchOU | ForEach-Object{ $group = $_
	Get-ADGroupMember -Identity $group -Recursive | %{Get-ADUser -Identity $_.distinguishedName -Properties Enabled | ?{$_.Enabled -eq $false}} | ForEach-Object{ $user = $_
		$uname = $user.Name
		$gname = $group.Name
		Write-Host "Removing $uname from $gname" -Foreground Yellow
		Remove-ADGroupMember -Identity $group -Member $user -Confirm:$false
	}
}
