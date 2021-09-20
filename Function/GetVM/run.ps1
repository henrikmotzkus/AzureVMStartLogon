using namespace System.Net

# Input bindings are passed in via param block.
param($Request, $TriggerMetadata)

# Write to the Azure Functions log stream.
Write-Host "GetVM triggered"

# Get the VMs from a file



$body = get-content ./GetVM/vms.json | ConvertFrom-Json 

$bodies = @($body)


# Associate values to output bindings by calling 'Push-OutputBinding'.
Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
    StatusCode = [HttpStatusCode]::OK
    Body = $bodies
})
