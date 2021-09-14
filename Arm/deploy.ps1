$resourcegroupname = "testdeploy15henrik"
$location = "westeurope"

#Connect-AzAccount

New-AzResourceGroup -Name $resourcegroupname -Location $location

$params = @{
    repositoryUrl="https://github.com/henrikmotzkus/AzureVMStartLogon"
    repositoryToken = "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"
    functionappname = $resourcegroupname
}

New-AzResourceGroupDeployment `
-ResourceGroupName $resourcegroupname `
-TemplateFile "./azuredeploy.json" `
-TemplateParameterObject $params