using namespace System.Net



# Input bindings are passed in via param block.
param($Request, $TriggerMetadata)


function BadRequest([string]$message){
    Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
        StatusCode = [HttpStatusCode]::BadRequest
        Body = $message
    })
}

# Write to the Azure Functions log stream.
Write-Host "PowerShell HTTP trigger function processed a request."

# VM name must be provided
$vmname = $Request.Query.vmname
if (-not $vmname) {
   BadRequest("Provide a vmname") 
}

# Resource group name must be provided
$resourcegroupname = $Request.Query.resourcegroupname
if (-not $resourcegroupname) {
    BadRequest("Provide a resourcegroup name") 
}

# User for access to the vm is needed
$user = $Request.Query.user
if (-not $user) {
    BadRequest("Provide a valid user name") 
}

# Access hash is needed
$accesshash = $Request.Query.accesshash
if (-not $accesshash) {
    BadRequest("Provide a valid access hash") 
}

# Try to connect to Azure



try {
    Connect-AzAccount -Identity -tenant $env:APPSETTING_tenantid -AccountId $env:APPSETTING_AccountId
} catch {
    BadRequest("Could not connect to Azure")
}


# Try to start the vm
try {

    $statuses = (get-azvm -ResourceGroupName $resourcegroupname -Name $vmname -status).Statuses  
    #$statuses[1].code

    if ($statuses[1].code -ne "PowerState/running"){
        Start-AzVM -Name $vmname -resourcegroupname $resourcegroupname
    }

} catch {
    BadRequest("Could not start VM")
}

#$vmname = "verwaltung"
#$resourcegroupname = "janice"
#$user = "adminlocal"
#$accesshash = "01000000D08C9DDF0115D1118C7A00C04FC297EB0100000003A657D52FE8C349ACA865376FA5782804000000020000000000106600000001000020000000F5F0CF775E2199E369D3FD02984B4F995DDE4C361B10539FEA537F9B65406A3B000000000E800000000200002000000018ECA8934722E68012D6368EA23391DC5E3F1D4EBEB496D11A703ACBDBDEC35D200000000B02EF664F71ABA8EB0F73B9C205B1385DC26D64EC4EFE7F3BF0D6F0756E29984000000011A3E1461DF4E3787039D49425C965C61A0A6992BA4C79364EDEB47A1AEF6F43F9EB93399DC6CA55B1B1B146068043DC294A99711E0DD3A2B71BF6B81AE3F190"

# Try to get the url to the VM
try {

        if ($statuses[1].code -eq "PowerState/running"){
        
            $nicid = $vm.NetworkProfile.NetworkInterfaces[0].Id
            $nic = Get-AzNetworkInterface -ResourceId $nicid
            $pupipid = $nic.IpConfigurations[0].PublicIpAddress.Id
            $res = Get-AzResource -ResourceId $pupipid
            $pup = Get-AzPublicIpAddress -Name $res.Name -ResourceGroupName $res.ResourceGroupName
            $fqdn = $pup.DnsSettings.Fqdn
            $url = "https://$fqdn/Myrtille/?__EVENTTARGET=&__EVENTARGUMENT=&server=&user=$user&passwordHash=$accesshash&program=&connect=Connect%21"
            
            Write-Host $url
        } else {
            BadRequest("Cannot get the fqdn of the vm. VM not running")
        }

} catch {
    BadRequest("Cannot get the fqdn of the vm")
}

# Try to redirect to browser to the url
Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
    StatusCode = [HttpStatusCode]::Redirect
    Headers = @{Location = $url}
})

# Debug code

#Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
#    StatusCode = [HttpStatusCode]::OK
#    Body = $(Get-Module -ListAvailable | Select-Object Name, Path)
#})





