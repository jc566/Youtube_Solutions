#Generate URL
$organization = "[YOUR ORGANIZATION]"
$project = "[YOUR PROJECT]"
$url_base = "https://dev.azure.com/$organization/$project/"
$url_endpoint = "_apis/distributedtask/variablegroups?api-version=6.0-preview.2"
$url = $url_base + $url_endpoint

#Generate PAT
$Personal_Access_Token= "YOUR PERSONAL ACCESS TOKEN"
$user = ""
$token = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $user, $Personal_Access_Token)))
$header = @{authorization = "Basic $token"}
#Make HTTP Request
$response = Invoke-RestMethod -Uri "$url" -Method GET -ContentType "application/json" -headers $header | convertto-json -depth 100

#Save response into JSON file locally
$output = "YOUR LOCAL PATH"
$response | out-file $output