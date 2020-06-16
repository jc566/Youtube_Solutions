#Make sure to replace the URL values as it makes sense to match your scenario"
$url_base = "https://cat-fact.herokuapp.com"
$url_endpoint = "/facts"
$url = $url_base + $url_endpoint

$response = Invoke-RestMethod -uri $url -Method Get -ContentType "application/json" -headers $header

#option 1 for display/utilization
foreach($item in $response.all)
{
$item
}

#option 2 for display/utilization
$response | ConvertTo-Json #-Depth 4