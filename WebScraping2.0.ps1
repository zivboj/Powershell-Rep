#$gcreds = Get-Credential
#$uri = 'https://btcmarkets.net/'
add-type @"
    using System.Net;
    using System.Security.Cryptography.X509Certificates;
    public class TrustAllCertsPolicy : ICertificatePolicy {
        public bool CheckValidationResult(
            ServicePoint srvPoint, X509Certificate certificate,
            WebRequest request, int certificateProblem) {
            return true;
        }
    }
"@
[System.Net.ServicePointManager]::CertificatePolicy = New-Object TrustAllCertsPolicy

$coins = 'neo', 'power-ledger'

foreach($coin in $coins)
{
$coinbaseInfo = Invoke-WebRequest -Uri ("https://coinmarketcap.com/currencies/" + $coin + "/") -UseBasicParsing
$coinbaseInfo.Content | Out-File tester.txt
$coinValue = Get-Content .\tester.txt | Select-String -Pattern '<span class="text-large" id="quote_price">' | out-string


$start= $coinValue.IndexOf(">$") + 1
$end = $coinValue.IndexOf("</", $start)
$length = $end - $start

$result = $coinValue.substring($start, $length)

$coinValuePrice = $result.Trim('$') | Out-String

$coin
$coinValuePrice
}
#Send-MailMessage6