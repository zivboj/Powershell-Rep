﻿Get-MsolAccountSku | %{$_.accountskuID;Write "Remaining Licenses:";($x =$_.ActiveUnits - $_.ConsumedUnits);$_.ServiceStatus | ft -hide}