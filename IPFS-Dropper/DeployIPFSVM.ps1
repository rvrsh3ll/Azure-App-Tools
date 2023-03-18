
function Invoke-DeployIPFSVM {
    <#
    .DESCRIPTION
        Deploy the token capture setup in Azure
    .EXAMPLE
        Invoke-DeployIPFSVM -ResourceGroup Myresourcegroup -location eastus -vmName ipfsserver -vmPublicDNSName <DNS_NAME> -pubKey ./mykey.pub
    #>

    [cmdletbinding()]
    Param([Parameter(Mandatory=$true)]
    [string]$ResourceGroup,
    [Parameter(Mandatory=$false)]
    [string]$location = "eastus",
    [Parameter(Mandatory=$False)]
    [String]$vmName,
    [Parameter(Mandatory=$True)]
    [String]$vmPublicDNSName,
    [Parameter(Mandatory=$True)]
    [String]$pubKey
    )

Write-Output "Running Commands.."
Write-Output "az group create --name $ResourceGroup --location $location"
az group create --name $ResourceGroup --location $location
Start-Sleep -Seconds 5
Write-Output "az vm create --resource-group $ResourceGroup --name webinar --image UbuntuLTS --public-ip-sku Standard --public-ip-address-dns-name bhistokenwebinar --admin-username azureuser --ssh-key-values $pubKey"
az vm create --resource-group $ResourceGroup --name $vmName --image UbuntuLTS --public-ip-sku Standard --public-ip-address-dns-name $vmPublicDNSName --admin-username azureuser --ssh-key-values $pubKey
Start-Sleep -Seconds 5
Write-Output "az vm open-port --port 22,4001 --resource-group $ResourceGroup --name $vmName"
az vm open-port --port 22,4001 --resource-group $ResourceGroup --name $vmName
Start-Sleep -Seconds 5
Write-Output "az vm run-command invoke -g $ResourceGroup -n $vmName --command-id RunShellScript --scripts 'apt-get update && apt-get install -y git python3-pip certbot wget apt-transport-https software-properties-common screen'"
az vm run-command invoke -g $ResourceGroup -n $vmName --command-id RunShellScript --scripts 'apt-get update && apt-get install -y git python3-pip certbot wget apt-transport-https software-properties-common screen'
Start-Sleep -Seconds 5
Write-Output "az vm run-command invoke -g $ResourceGroup -n $vmName --command-id RunShellScript --scripts 'wget https://dist.ipfs.tech/kubo/v0.18.1/kubo_v0.18.1_linux-amd64.tar.gz'"
az vm run-command invoke -g $ResourceGroup -n $vmName --command-id RunShellScript --scripts 'wget -O /home/azureuser/kubo.tar.gz https://dist.ipfs.tech/kubo/v0.18.1/kubo_v0.18.1_linux-amd64.tar.gz'
Start-Sleep -Seconds 5
Write-Output "az vm run-command invoke -g $ResourceGroup -n $vmName --command-id RunShellScript --scripts 'tar -xvzf kubo.tar.gz'"
az vm run-command invoke -g $ResourceGroup -n $vmName --command-id RunShellScript --scripts 'tar -xvzf kubo.tar.gz'
Start-Sleep -Seconds 5
Write-Output "az vm run-command invoke -g $ResourceGroup -n $vmName --command-id RunShellScript --scripts 'sudo bash /home/azureuser/kubo/install.sh'"
az vm run-command invoke -g $ResourceGroup -n $vmName --command-id RunShellScript --scripts 'sudo bash /home/azureuser/kubo/install.sh'
}