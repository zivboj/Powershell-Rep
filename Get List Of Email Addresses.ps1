﻿Get-Mailbox -ResultSize Unlimited -SortBy Name |Select-Object DisplayName,ServerName,PrimarySmtpAddress, @{Name=“EmailAddresses”;Expression={$_.EmailAddresses |Where-Object {$_.PrefixString -ceq “smtp”} | ForEach-Object {$_.SmtpAddress}}}