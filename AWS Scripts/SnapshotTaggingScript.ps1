$volumes = Get-EC2Volume
$volTable = @()
$volumes = $volumes 

foreach($volume in $volumes)
{
    $volfiller = $volume.Attachments
    $volTags =  $volume.Tags
    $voltable += [pscustomobject]@{
        "InstanceID" = $volfiller.InstanceId
        "VolumeId" = $volfiller.VolumeID
        "Tag" = foreach($tagval in $tags){ foreach($tag in $voltags){ if($tag.Value -eq $tagval){ $tagval  } }}
}
}


$snapshots = get-ec2snapshot | select SnapshotId, VolumeId
$tagvolTable = @()
$tags = 'COE', 'COE - PD', 'COE - PQ', 'COE - TQ', 'COE - TY', 'COE-EAM', 'EIAM', 'PPM-POC', 'Test Team', 'Tibco'


foreach($snap in $snapshots) 
{ 
    foreach ($voll in $volTable) 
    { 
        if ($snap.volumeId -eq $voll.volumeID) 
            { 

            $voltags = $voll.Tag
            $tagvolTable += [pscustomobject]@{
       
        "SnapshotID" = $snap.SnapshotID
        "VolumeID" = $snap.VolumeID
        "Tag" = foreach($tag in $tags){ foreach($voltag in $voltags){ if($tag -eq $voltag){ $tag  } }}
        
            }
           
            } 
    } 
}


    $ec2tag = New-Object Amazon.EC2.Model.Tag
    $ec2tag.Key = "Cost Allocation"
    

foreach ($record in $tagvoltable)
{  
   
    if($record.Tag -ne "")
    {
   
    $ec2tag.Value = $record.Tag


    New-EC2Tag -Resource $record.SnapshotID -Tag $ec2tag
    start-sleep -Seconds 1  
    }
    
}