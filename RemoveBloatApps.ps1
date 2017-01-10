$ExcludedApps = '.*photos.*|.*calculator.*|.*alarms.*|.*desktopapp*.|.*sticky*.|.*soundrecorder*.|.*zunevideo*.'

$Apps = (Get-AppxPackage -PackageTypeFilter Bundle | Where-Object {$_.Name -notmatch $ExcludedApps}) 

if ($Apps) {

$Apps | Remove-AppxPackage

}
