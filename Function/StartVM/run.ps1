using namespace System.Net

# Input bindings are passed in via param block.
param($Request, $TriggerMetadata)

# Write to the Azure Functions log stream.
Write-Host "PowerShell HTTP trigger function processed a request."

# Interact with query parameters or the body of the request.
#$name = $Request.Query.Name
#if (-not $name) {
#    $name = $Request.Body.Name
#}
#
#$body = "This HTTP triggered function executed successfully. Pass a name in the query string or in the request body for a personalized response."

#if ($name) {
#    $body = "Hello, $name. This HTTP triggered function executed successfully."
#}

$location ="https://verwaltung.westeurope.cloudapp.azure.com/Myrtille/?__EVENTTARGET=&__EVENTARGUMENT=&server=&user=adminlocal&passwordHash=01000000D08C9DDF0115D1118C7A00C04FC297EB0100000003A657D52FE8C349ACA865376FA5782804000000020000000000106600000001000020000000F5F0CF775E2199E369D3FD02984B4F995DDE4C361B10539FEA537F9B65406A3B000000000E800000000200002000000018ECA8934722E68012D6368EA23391DC5E3F1D4EBEB496D11A703ACBDBDEC35D200000000B02EF664F71ABA8EB0F73B9C205B1385DC26D64EC4EFE7F3BF0D6F0756E29984000000011A3E1461DF4E3787039D49425C965C61A0A6992BA4C79364EDEB47A1AEF6F43F9EB93399DC6CA55B1B1B146068043DC294A99711E0DD3A2B71BF6B81AE3F190&program=&connect=Connect%21"

$location = $env:APPSETTING_location

Select-AzSubscription -SubscriptionID "2abc2ec1-2238-430d-bf52-40cb7dc8b652"

Start-AzVM -Name "verwaltung" -resourcegroupname "Janice"



# Associate values to output bindings by calling 'Push-OutputBinding'.
Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
    StatusCode = [HttpStatusCode]::Redirect
    Headers = @{Location = $location}
})

#Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
#    StatusCode = [HttpStatusCode]::OK
#    Body = $(Get-Module -ListAvailable | Select-Object Name, Path)
#})



