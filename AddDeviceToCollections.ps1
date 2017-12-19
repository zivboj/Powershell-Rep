Import-Module ConfigurationManager
Import-Module (Join-Path $(Split-Path $env:SMS_ADMIN_UI_PATH) ConfigurationManager.psd1)
$sccmserver = "syd05sccm01"
new-psdrive -Name HFS -PSProvider "AdminUI.PS.Provider\CMSite" -Root $sccmserver
Set-Location -Path HFS:
$content = Get-Content "C:\temp\New folder\New Text Document.txt"

foreach ($device in $content)

{ 

Add-CMDeviceCollectionDirectMembershipRule -CollectionName "Bojan - Collection" -ResourceID (Get-CMDevice -Name $device).ResourceID 

}