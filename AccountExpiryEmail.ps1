$users = Get-ADUser -filter {Enabled -eq $True -and PasswordNeverExpires -eq $False} –Properties "samaccountname", "accountExpires" | Select-Object -Property "samaccountname",@{Name="ExpiryDate";Expression={[datetime]::FromFileTime($_."accountExpires")}} | Where-Object {($_.ExpiryDate -ne 'Monday, 1 January 1601 11:00:00 AM') -and ($_.ExpiryDate -notlike $null)} 
$date = (get-date).AddDays(14)
$usersExpiry = @()
$today = get-date -Format "dd-MMM-yyyy"

foreach($user in $users)
{
    if ($user.ExpiryDate -ge (get-date)) 
    {
        if ($user.ExpiryDate -le $date)
        {
        $usersExpiry += $user
        }
    }
}

$content = $usersExpiry | Sort-Object ExpiryDate -Descending |out-string

$body= @(
"
Please note; accounts below will expire in 14 days or less.

$content


"
)
 
Send-MailMessage (FillInASRequiredbyYourCompany)
