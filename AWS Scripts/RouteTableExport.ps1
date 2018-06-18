$table = @()

$ec2RouteTables = Get-EC2RouteTable | select RouteTableID, Routes 

foreach($ec2RouteTable in $ec2RouteTables)
{
     $table += [pscustomobject]@{
       
        "RouteTableID" = $ec2RouteTable.RouteTableID
        "Route" = $ec2RouteTable.Routes
        }
        
    $rtID = $ec2RouteTable.RouteTableID
    $rtID2 = $rtID + '.csv'

    $ec2RouteTable | select Routes -ExpandProperty Routes | select DestinationCidrBlock, GatewayID, NatGatewayID, NetworkInterfaceID | ft | Export-Csv "UPNLocation\$rtID2" 

        }

