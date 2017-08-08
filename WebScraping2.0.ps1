#$gcreds = Get-Credential
#$uri = 'https://btcmarkets.net/'
$coinbaseInfo = Invoke-WebRequest -Uri  https://coinmarketcap.com/currencies/bitcoin-cash/ -UseBasicParsing
$coinbaseInfo.Content | Out-File tester.txt
$bitcoinCash = Get-Content .\tester.txt | Select-String -Pattern '<span class="text-large" id="quote_price">' | out-string


$start= $bitcoinCash.IndexOf(">$") + 1
$end = $bitcoinCash.IndexOf("</", $start)
$length = $end - $start

$result = $bitcoinCash.substring($start, $length)

$bitcoinCashPrice = $result.Trim('$') | out-string

$bitcoinCashPrice



#Send-MailMessage