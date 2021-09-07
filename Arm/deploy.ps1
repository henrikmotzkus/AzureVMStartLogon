$resourcegroupname = "testdeploy6"
$location = "westeurope"

#Connect-AzAccount

New-AzResourceGroup -Name $resourcegroupname -Location "westeurope"

$params = @{
    principalID = "212"
    tenant = $tenantid
}

New-AzResourceGroupDeployment `
-ResourceGroupName $resourcegroupname `
-TemplateParameterObject $params `
-TemplateFile "./Arm/azuredeploy.json"