param(
[string]$backupDirectory = "C:\Users\Joe\Documents\youtube_repo\Youtube_Solutions\Powershell Scripts\RetentionRate\testMaxThreshold",
[int]$RetentionRate = 3 #set retention rate to last 5 by default
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

#get only the most recent files based on retentionRate value passes, most recent one first
$FilestoDelete = Get-Childitem -Path $backupDirectory | Sort CreationTimeUTC -Descending | Select -Skip $RetentionRate

try{
    write-host $files
        #delete all items that are older then the $lastFile
        foreach($item in $FilestoDelete)
        {
            Write-Host "The following will be deleted : $($item.FullName)"
            Remove-item $item.FullName -Force      
        }

    Write-Host "Completed Checking Retention..."
}
catch
{
    $errorMessage = $_.Exception.Message
    Throw $errorMessage
}