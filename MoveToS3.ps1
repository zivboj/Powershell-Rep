#THIS WILL REQUIRE YOU TO HAVE A PRESETUP AWS CRED SETUP IN POWERSEHLL (Set-AWSCredentials)
$filePath = "FilePathYouWishChecked"
$timeSpan = New-TimeSpan -Days 1 -Hours 1 -Seconds 1 -Minutes 1
$writeDate = (Get-Item -Path $filePath).LastWriteTime


if (((get-date) - $writedate) -gt $timeSpan) 
{
Write-S3Object -BucketName 'bucketPath' -File $filepath
}
else
{
echo 'WhatYouWant'
} 