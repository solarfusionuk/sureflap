param (
	[string]$householdID
)

. ./Get-SureFlapToken.ps1

if (!$householdID) {
	$householdID = (./Get-SureFlapHousehold.ps1).id
}

$uri = $endpoint + "/api/household/$householdID/pet"

$headers = @{}
$headers.Add("Authorization","Bearer $token" ) | Out-Null

$querystring = "?with[]=photo&with[]=tag&with[]=position"
$uri += $querystring

$res = Invoke-RestMethod -Method Get -Uri $uri -Headers $headers -ContentType "application/json"
$res.data