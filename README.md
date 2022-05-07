## Deploy Postgres Single Server and in Azure using Bicep

I use this project to create a Postgres server encrypted with a customer-managed key CMK in Azure using Bicep. I execute the commands from a Linux terminal on Windows (Ubuntu on WSL).
<p>&nbsp;</p>

The goals of the project:

* deploy a PostgreSQL Single Server in Azure in a new resource group
* encrypt the server with a customer-managed key CMK
* customer-managed key already exists in an Azure Key Vault

* deployment gets the current version of the key, i.e. the version is not hardcoded or passed as a parameter, prevents the template from becoming outdated when the key is rotated
<p>&nbsp;</p>


### Login to Azure using the CLI

```
az Login
```

Use `az account show` to check the subscription context.


### Deploy using Bicep

```terraform
az deployment sub create -f ./main.bicep --parameters tenantId='xxxxxx-xxxxxx-xxxxx-xxxxxxxxx' keyvaultname='xxxxxx'  keyname='xxxxxx' administratorLogin=xxxxxx' administratorLoginPassword='xxxxxx' servername='xxxxxx' -l UKSouth -c
```



## Prerequisites

Install Bicep

```
az bicep install
```