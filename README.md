## Deploy Postgres Single Server in Azure using Bicep

I use this project to create a Postgres server encrypted with a customer-managed key CMK in Azure using Bicep. I execute the commands from a Linux terminal on Windows (Ubuntu on WSL).

The goals of the project:

* deploy a PostgreSQL Single Server in Azure in a new resource group
* encrypt the server with a customer-managed key CMK
* customer-managed key already exists in an Azure Key Vault

* deployment gets the current version of the key, i.e. the version is not hardcoded or passed as a parameter, prevents the template from becoming outdated when the key is rotated
<p>&nbsp;</p>

### Why not a single file or template?

The deployment is broken down into smaller Bicep templates and then deployed together through the main template. Each template runs in the scope of a resource group, and because we did not want the Postgres server to reside in the same resource group as the Key Vault, it required the deployments to be separated. Although it is best practice to modularise for ease of reuse, I needed to separate more than I intended as this project is a proof-of-concept.

Please note because this is a proof-of-concept, the permissions granted to the Postgres server to the Key Vault are overly generous, and the parameters for the server are hardcoded; you may want to change this if you are reusing the code in Production.

<p>&nbsp;</p>

### Login to Azure using the CLI

```
az Login
```

Use `az account show` to check the subscription context.


### Deploy using Bicep

```terraform
az deployment sub create -f ./main.bicep --parameters tenantId='xxxxxx-xxxxxx-xxxxx-xxxxxxxxx' keyvaultname='xxxxxx'  keyname='xxxxxx' administratorLogin='xxxxxx' administratorLoginPassword='xxxxxx' servername='xxxxxx' -l UKSouth -c
```



## Prerequisites

Install Bicep

```
az bicep install
```