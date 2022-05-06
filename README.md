## Deploy Postgres Single Server and in Azure using Bicep

I use this project to create a Postgres server encrypted with a customer-managed key in Azure using Bicep. I execute the commands from a Linux terminal on Windows (Ubuntu on WSL).


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