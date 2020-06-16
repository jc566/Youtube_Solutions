param(
[string]$targetFiles = "Second",
[string]$targetRename = "",
[string]$directory = "E:\Action Video Capture\New folder"
)

$filesToReplace = (Get-ChildItem -Path $directory -Filter *$targetFiles* -Recurse).FullName

foreach($file in $filesToReplace)
{
    $originalFile = $file.replace("$($targetFiles)","$($targetRename)")  
    
    if(test-path $originalFile)
    {
    remove-item $originalFile -force  
    }
    else
    {
        write-host "Could not find the file"
    }

   
    rename-item $file $originalFile -force
}