Param(
    [string]$FirstPart,
    [string]$SecondPart = "World"
)
Write-Host "Create a new variable called 'NewString' whose value should be $($FirstPart) $($SecondPart)"
Write-Host ("{0} {1} : File Execution!" -f $FirstPart,$SecondPart)
Write-Host "##vso[task.setvariable variable=NewString]$FirstPart $SecondPart"
