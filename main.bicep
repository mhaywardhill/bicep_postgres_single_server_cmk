targetScope = 'subscription'

param location string = 'UK South'
param resourcegroup string = 'bicep-resources'
param keyvaultresourcegroup string = 'kv-resources'

@secure()
param tenantId string

@secure()  
param keyvaultname string

@secure()  
param keyname string
 
@secure()  
param administratorLogin string

@secure() 
param administratorLoginPassword string

@secure() 
param servername string

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourcegroup
  location: location
}

resource kvrg 'Microsoft.Resources/resourceGroups@2021-04-01' existing = {
  name: keyvaultresourcegroup
}

module getkey 'getkey.bicep' = {
  name: 'Bicep_Get_Key'
  scope: kvrg
  params: {
    keyvaultname: keyvaultname
    keyname: keyname
  }
}

module postgresDeploy 'postgres.bicep' = {
  name: 'Bicep_Postgres_Deployment'
  scope: rg
  params: {
    location: location
    servername: servername
    administratorLogin: administratorLogin
    administratorLoginPassword: administratorLoginPassword
  }
  dependsOn: [
    getkey
  ]
}

module kvaccesspolicy 'kvaccesspolicy.bicep' = {
  name: 'Bicep_Add_Cccesspolicy'
  scope: kvrg
  params: {
    keyvaultname: keyvaultname
    tenantId: tenantId
    pgssprincipalId: postgresDeploy.outputs.pgssprincipalId
  }
  dependsOn: [
    postgresDeploy
  ]
}

module addcmk 'encrypt_with_cmk.bicep' = {
  name: 'Bicep_encryption_with_customer-managed_key'
  scope: rg
  params: {
    serverkeyname: getkey.outputs.serverkeyname
    uri: getkey.outputs.keyuri
    servername: servername
  }
  dependsOn: [
    kvaccesspolicy
  ]
}
