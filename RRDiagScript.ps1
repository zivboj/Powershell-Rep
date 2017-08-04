#Requires -RunAsAdministrator
######WARNING######
#MUST BE RUN AS ADMINISTRATOR
###################
#
############################################################
#Check if VRPOS and VRServer Utilties are running

if((get-service VRServerUtilities).Status -eq "Running")
{ $VRServerMessage = 'VRServerUtilties is running' }
else
{ $VRServerMessage = 'VRServerUtilties has stopped' }

$VRServerMessage  >> C:\Temp\VR_Diag.txt

if((get-service VRPOSUtilities).Status -eq "Running")
{ $VRPOSMessage = 'VRPOSUtilties is running' }
else
{ $VRPOSMessage = 'VRPOSUtilties has stopped' }

$VRPOSMessage  >> C:\Temp\VR_Diag.txt

#############################################################
#Get Current Java Version

$JavaVer = dir "HKLM:\SOFTWARE\JavaSoft\Java Runtime Environment"  | select -expa pschildname -Last 1

$JavaVer >> C:\Temp\VR_Diag.txt

#############################################################
#Check if Port 443 is accessible

$PortTest = New-Object Net.Sockets.TcpClient "twc.webservices.visibleresults.net", 443 
   
   if($PortTest.Connected)
    {
       $Port443MSG = "Port 443 is operational"
    }
    else
    {
       $Port443MSG = "Unable to contact Port 443"
    }

$Port443MSG >> C:\Temp\VR_Diag.txt

#############################################################
# Check if firewall is on

Get-NetFirewallProfile >> C:\Temp\VR_Diag.txt


#############################################################
#Check if javaw.exe is in firewall exceptions

$JavaFireWall = Get-NetFirewallRule -DisplayName 'Java(TM) Platform SE binary'

if($JavaFireWall.Enabled -eq 'True')
{
    $JavaFirewallMSG = "Javaw.exe is allowed through firewall"
}
else
{
    $JavaFireWallMSG = "Javaw.exe is not allowed through firewall"
}

$JavaFirewallMSG >> C:\Temp\VR_Diag.txt

#############################################################
#Search Posutlitiles log for failed messages

$POSWrapper = Select-String -Pattern "Fail" -Path 'C:\VisibleResults\LoyaltyLogic\POSUtilities\logs\POSUtilitiesWrapper.log.0'

if($POSWrapper.Pattern -eq "Fail")
{
    $POSWrapper >> C:\Temp\SearchFailPOSLogs.txt
}
else
{
    $POSWrapperMSG = "No Fail messages found in POS log"
    $POsWrapperMSG >> C:\Temp\VR_Diag.txt
}

#############################################################
#Search Serverutlitiles log for failed messages

$ServerWrapper = Select-String -Pattern "Fail" -Path 'C:\VisibleResults\LoyaltyLogic\ServerUtilities\logs\ServerUtilitiesWrapper.log.0'

if($ServerWrapper.Pattern -eq "Fail")
{
    $ServerWrapper >> C:\Temp\SearchFailServerLogs.txt
}
else
{
    $ServerWrapperMSG = "No Fail messages found in Server logs"
    $ServerWrapperMSG >> C:\Temp\VR_Diag.txt
}
