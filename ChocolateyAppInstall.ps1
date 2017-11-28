##Install Primary Software

iwr https://chocolatey.org/install.ps1 -UseBasicParsing | iex

choco install jre8 -Y
choco install adobereader -Y
choco install googlehcrome -Y
choco install firefox -Y
choco install flashplayerplugin -Y
choco install 7zip -Y
choco install teamviewer -Y
choco install slack -Y

#install package

##Remove Bloatware Windows Apps on Windows 8,8.1,10

$ExcludedApps = '.*photos.*|.*calculator.*|.*alarms.*|.*desktopapp*.|.*sticky*.|.*soundrecorder*.|.*zunevideo*.'

$Apps = (Get-AppxPackage -PackageTypeFilter Bundle | Where-Object {$_.Name -notmatch $ExcludedApps}) 

if ($Apps) {

    $Apps | Remove-AppxPackage

}