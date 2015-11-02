Set-ExecutionPolicy Unrestricted

add-azureaccount

Select-AzureSubscription -SubscriptionName "MTC Workshop"
Get-AzureSubscription 

Switch-AzureMode AzureResourceManager 

$deployName="TestDeployment"
$RGName="biexperiencevms"
$locname="Central US"
$templateURI=".\azuredeploy.json"
New-AzureResourceGroup -Name $RGName -Location $locName
New-AzureResourceGroupDeployment -Name $deployName -ResourceGroupName $RGName -TemplateUri $templateURI
