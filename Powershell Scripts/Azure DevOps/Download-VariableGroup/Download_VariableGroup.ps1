#Generate URL
$organization = "DevopsTest00001"
$project = "CICD"
$url_base = "https://dev.azure.com/$organization/$project/"
$url_endpoint = "_apis/distributedtask/variablegroups?api-version=6.0-preview.2"
$url = $url_base + $url_endpoint


#Generate PAT

#Make HTTP Request

#Save response into JSON file locally