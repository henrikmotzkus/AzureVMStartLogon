[CmdletBinding()]
param (
    [Parameter()]
    [String]
    $repositoryToken
)


$resourcegroupname = "testdeploy18henrik"
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
-repositoryToken $repositoryToken