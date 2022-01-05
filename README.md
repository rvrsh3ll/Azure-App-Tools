# Azure-App-Tools
 Collection of tools to use with Azure Applications.  https://azure.microsoft.com/en-us/get-started/apps/

## Prerequisites
Azure Powershell Module https://docs.microsoft.com/en-us/powershell/azure/install-az-ps?view=azps-3.8.0

## Examples:

### Static HTML Phishing Page
az webapp up --location eastus --resource-group mynewresourcegroup --name mynewsubdomain --html --sku FREE

### IIS Redirector
az webapp up --location eastus --resource-group mynewresourcegroup --name mynewsubdomain --html --sku FREE

Navigate to the Azure App Console and copy the applicationHost.xdt back a directory.

![alt text](images/console.png "Console")

### Python Flask Redirector
The redirector acts as a "dumb" redirector unless you modify the variables in application.py. See below.

Protect your servers with a secret header per my blog at https://medium.com/@rvrsh3ll/hardening-your-azure-domain-front-7423b5ab4f64

Be sure to comment the first HEADER variable and then uncomment HEADER and HEADER_KEY to use magic headers in application.py.
HEADER = None
#HEADER = "X-Aspnet-Version"
#HEADER_KEY = "1.5"

az webapp up --location eastus --resource-group mynewresourcegroup --name mynewsubdomain --SKU FREE

