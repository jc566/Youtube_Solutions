$folderPath = "C:\Users\Joe\Downloads\TEST_FOLDER_2020"
$user = "ExampleUser1"

$acl = Get-Acl $folderPath

$AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("$user","FullControl","Allow")

$acl.SetAccessRule($AccessRule)

$acl | Set-Acl $folderPath