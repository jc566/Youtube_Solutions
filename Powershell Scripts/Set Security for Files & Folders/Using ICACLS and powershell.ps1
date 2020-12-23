$folderPath = "C:\Users\Joe\Documents\YT Video Folder\testFolder"

$user = "ExampleUser1"

$grant = "/grant:r"

$permission = ":(OI)(CI)(F)"

$inheritance = "/inheritance:e"

Invoke-Expression -Command ('icacls $folderPath $inheritance $grant "${user}${permission}"')

#https://ss64.com/nt/icacls.html

#https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/icacls