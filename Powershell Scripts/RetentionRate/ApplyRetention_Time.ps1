param(
[string]$backupDirectory = "",
[int]$RetentionRate = 5 #set retention rate to last 5 by default
)

if(!(Test-Path -Path $backupDirectory))
{
    Write-Host "Creating $($backupDirectory)"
    New-Item -Itemtype Directory -Path $backupDirectory -Force
}
else
{
    Write-Host "$($backupDirectory) already exists..."
}

write-host "Checking $($backupDirectory) for available space & applying retention rules..."

#get all files in the backupDir
$files = Get-ChildItem -Path $backupDirectory -Recurse

#get the current date and calculate by current date minus retention rate
$currentTime = Get-Date

$RetentionPolicy = $currentTime.AddDays(-$RetentionRate)
#$RetentionPolicy = $currentTime.AddDays(-$RetentionRate).AddHours(-$RetentionRate).AddMinutes(-$RetentionRate).AddSeconds(-$RetentionRate)

write-host "Retention Policy is $($RetentionPolicy.ToUniversalTime())"

try
{
    foreach($item in $files)
    {
        if($item.CreationTimeUtc -lt $RetentionPolicy.ToUniversalTime())
        {
            Write-Host "The following will be deleted : $($item.FullName)"
            Remove-Item $item.FullName -Force
        }
    }
}
catch
{
    $errorMessage = $_.Exception.Message
    Throw $errorMessage
}
