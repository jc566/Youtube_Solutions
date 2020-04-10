param(
[string]$targetFiles = "", #target string to look for
[string]$targetRename = "", #what you want to change $targetFiles to be replaced with
[string]$directory = ""
)

$filesToReplace = (Get-ChildItem -Path $directory -Filter *$targetFiles* -Recurse).FullName

foreach($file in $filesToReplace)
{
    #create a variable that finds a file with $targetFiles and replaces it with the "original" files name.

    write-Host "Beginning file replacement for $file"
    $originalFile = $file.replace("$($targetFiles)","$($targetRename)")

    write-host "File Name is $originalFile"
    if(test-path $originalFile)
    {
        remove-item $originalFile -force
        write-host "Original file $originalFile is removed"
    }
    else
    {
        write-warning "Original File, $originalFile , is not found" 
    }

    if(Test-Path $file)
    {
        Write-Host "$file is renamed to $originalFile"
        Rename-Item $file $originalFile -force
    }
}