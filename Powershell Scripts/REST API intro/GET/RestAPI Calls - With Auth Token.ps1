#https://docs.microsoft.com/en-us/rest/api/azure/devops/distributedtask/variablegroups/get%20variable%20groups?view=azure-devops-rest-5.1

$url_base = "YOUR_BASE_ENDPOINT_URL"
$url_endpoint = "YOUR_ENDPOINT"
$url = $url_base + $url_endpoint
$Personal_Access_Token = "YOUR_ACCESS_TOKEN"
$user = ""

$token = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $user, $Personal_Access_Token)))
$header = @{authorization = "Basic $token"}

$response = Invoke-RestMethod -uri $url -Method Get -ContentType "application/json" -headers $header

$response | ConvertTo-Json -Depth 4