# Requires AWSPowershell.Core module to be installed
# Requires Ec2Profile to be setup in powershell

New-EC2Instance -ImageId 'amiID' -MaxCount 1 -MinCount 1 -InstanceType 'InstanceType eg t2.small' -KeyName 'PrivateKeyName' -SubnetId 'SubnetID' -SecurityGroupId 'SecGroupID' -Region 'Region' -verbose