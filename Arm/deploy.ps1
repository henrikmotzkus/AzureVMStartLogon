$resourcegroupname = "testdeploy17henrik"
$location = "westeurope"

#Connect-AzAccount

New-AzResourceGroup -Name $resourcegroupname -Location $location

$params = @{
    repositoryUrl="https://github.com/henrikmotzkus/AzureVMStartLogon"
    functionappname = $resourcegroupname
}

New-AzResourceGroupDeployment `
-ResourceGroupName $resourcegroupname `
-TemplateFile "./azuredeploy.json" `
-TemplateParameterObject $params `
-repositoryToken "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"