param (
	[string]$petID
)

$petInfo = ./Get-SureFlapPet.ps1

If (!$petID) {
    Write-Warning "No pet ID passed, searching..."
    #Break
    $petID = $petInfo.id
}

. ./Get-SureFlapHousehold.ps1

<#
# Check if ID or name passed
If ($petID -is [int]) {
    Write-Host "ID passed"
} Else {
    Write-Host "Name passed"
}
#>

# Get pets name from ID
ForEach ($pet in $petInfo) {
    If ($pet.id -eq $petID) {
        $petName = $pet.Name
    }
}

$uri = $endpoint + "/api/pet/$petID/position"

$headers = @{}
$headers.Add("Authorization","Bearer $token" ) | Out-Null

$res = Invoke-RestMethod -Method Get -Uri $uri -Headers $headers -ContentType "application/json"
# where 1 = inside 2 = outside since = datetime seen
if ($res.data.where -eq 1) {
	$message = "$petName is inside"
} else {
	$message = "$petName is outside"
}

Write-Host $message

<#
Add-Type -AssemblyName System.speech
$speak = New-Object System.Speech.Synthesis.SpeechSynthesizer
$speak.Speak($message)
#>
