using namespace System.Net

# Input bindings are passed in via param block.
param($Request, $TriggerMetadata)

# Write to the Azure Functions log stream.
Write-Host "GetVM triggered"

# Get the VMs from a file

get-content ./GetVM/vms.json

$body = ConvertTo-Json -InputObject $vms

$bodies = @($body)


# Associate values to output bindings by calling 'Push-OutputBinding'.
Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
    StatusCode = [HttpStatusCode]::OK
    Body = $bodies
})
