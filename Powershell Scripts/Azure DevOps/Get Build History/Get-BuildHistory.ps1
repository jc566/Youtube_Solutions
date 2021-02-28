#Azure Devops params
$AzureDevops_org = "GK2021"
$AzureDevops_project = "AzureDevops"

#API Calls
$url_base = "https://dev.azure.com/"
$url_endpoint = "$AzureDevops_org/$AzureDevops_project/_apis/build/builds?api-version=6.1-preview.6"
$url = $url_base + $url_endpoint
$Personal_Access_Token = "rjffdijo2kjjlcz3qp3yrcg2gtlhkymyx5v3sjjgda4pd4rgh4eq"
$user = ""

$token = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $user, $Personal_Access_Token)))
$header = @{authorization = "Basic $token"}

$response = Invoke-RestMethod -uri $url -Method Get -ContentType "application/json" -headers $header

#Class
class BuildInfo 
{
    [string]$BuildName
    [string]$BuildID
    [string]$Status
    [string]$Result
}

#Declare Arraylist to easily add/remove
$Builds = [System.Collections.ArrayList]@()

#Populate the Arraylist with instances based on the class we created earlier
foreach($item in $response.value)
{
    $build = [BuildInfo]::new()
    $build.BuildName = $item.definition.name
    $build.BuildID = $item.definition.id
    $build.Status = $item.status
    $build.Result = $item.result

    $Builds.Add($build) | Out-null #if you comment out 'Out-Null' you will see that this outputs the Count of items. Do this to remove the gibberish
}

#Filter the list for Unique values only
$Builds = $Builds | Select-Object BuildName,BuildID,Status,Result -Unique

#Display the information we care about
for ($i=0;$i -lt $Builds.Count; $i++)
{
    write-host "
                Build Name :  $($Builds[$i].BuildName) `n 
                Build ID : $($Builds[$i].BuildID) `n 
                Build Status : $($Builds[$i].status) `n
                Build Result : $($Builds[$i].result) `n"
}


#Declare the output file name
$output_file = "C:\Users\Joe\Documents\SampleJson.Json"

#Write the entire json object retrieved into a output file
$response | ConvertTo-Json -Depth 4 | Out-File $output_file

