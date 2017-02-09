$dateEnd = get-date 
$dateStart = $dateEnd.AddHours(-(HOURS)

Get-MessageTrace -StartDate $dateStart -EndDate $dateEnd | Select-Object Received, SenderAddress, RecipientAddress, Subject, Status, ToIP, FromIP, Size, MessageID, MessageTraceID | Out-GridView 

