using namespace System.Net

# Input bindings are passed in via param block.
param($Request, $TriggerMetadata)

# Write to the Azure Functions log stream.
Write-Host "GetVM triggered"

# Get the VMs from a file
$vms = get-content ./GetVM/vms.json | ConvertFrom-Json
$body = ConvertTo-Json -InputObject $vms
# Associate values to output bindings by calling 'Push-OutputBinding'.
Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
    StatusCode = [HttpStatusCode]::OK
    Body = $body
})
