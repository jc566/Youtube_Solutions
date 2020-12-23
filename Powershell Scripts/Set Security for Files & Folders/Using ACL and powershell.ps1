$folderPath = "C:\Users\Joe\Documents\YT Video Folder\testFolder"

$user = "ExampleUser1"

$accesstype = "FullControl"

$allowOrDeny = "Allow"

$argList = $user,$accesstype,$allowOrDeny

$acl = Get-Acl $folderPath

$AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule -ArgumentList $argList

$acl.SetAccessRule($AccessRule)

$acl | Set-Acl $folderPath

#https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.security/set-acl?view=powershell-7.1

#https://docs.microsoft.com/en-us/dotnet/api/system.security.accesscontrol.filesystemrights?view=net-5.0