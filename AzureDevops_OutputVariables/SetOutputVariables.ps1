Write-Host "##vso[task.setvariable variable=NotASecret]You should see me!"
Write-Host "##vso[task.setvariable variable=IsASecret;issecret=true]You should NOT see me!"
