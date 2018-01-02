## Bonobo Git Server Install
## Installs & Configures default settings for Bonobo Git Server on Windows 2008/2012/2016
## Official Bonobo Git Server Available at https://bonobogitserver.com/

## Start Script

# Firewall Configurations
New-NetFirewallRule -Name PSRemote -DisplayName ‘PS Remoting’ -Enabled true -Profile any -Direction Inbound -LocalPort 5985 -Protocol TCP
New-NetFirewallRule -Name HTTPS -Displayname 'HTTPS' -Enabled true -Profile any -Direction Inbound -LocalPort 443 -Protocol TCP
New-NetFirewallRule -Name HTTP -DisplayName 'HTTP' -Enabled true -Profile any -Direction Inbound -LocalPort 80 -Protocol TCP

# IIS
Install-WindowsFeature -Name Web-Server -IncludeAllSubFeature -IncludeManagementTools

# Variables
$BonoboSource = 'C:\BonoboSource'
$BonoboExtract = 'C:\BonoboSource\6_2_1.zip'
$BonoboDestination = 'C:\inetpub\wwwroot'


If (!(Test-Path $BonoboSource)) {
    New-Item -ItemType Directory -Path $BonoboSource
}


Add-Type -assembly "system.io.compression.filesystem"
[io.compression.zipfile]::ExtractToDirectory($BonoboExtract, $BonoboDestination)

Install-PackageProvider -Name Nuget -MinimumVersion 2.8.5.201 -Force
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
Install-Module -Name NTFSSecurity

Add-NTFSAccess -Path 'C:\inetpub\wwwroot\bonobo.git.server\App_Data' -Account 'BUILTIN\IIS_IUSRS' -AccessRights Modify

Import-Module -Name WebAdministration

ConvertTo-WebApplication -PSPath 'IIS:\Sites\Default Web Site\Bonobo.Git.Server'


# Browse to http://localhost/bonobo.Git.Server/
# First time login info:
# User: admin
# Pass: admin

