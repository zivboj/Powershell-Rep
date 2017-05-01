$printerName = 'Konica Printer'
$printerDriverList = Get-PrinterDriver 



if(($printerDriverList -match "PrintDriverName"))
{
Add-Printer -DriverName 'PrintDriverName' -PortName 'IP' -Name $printerName
}
else
{
echo "No print driver found, please install Printer Driver"
Start-Sleep -Seconds 60
}

#echo $printerDriverList

