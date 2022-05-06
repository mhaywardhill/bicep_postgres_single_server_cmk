param keyvaultname string 
param keyname string

resource keyVault  'Microsoft.KeyVault/vaults@2019-09-01' existing = {
  name: keyvaultname
}

resource key 'Microsoft.KeyVault/vaults/keys@2021-11-01-preview' existing = {
  parent: keyVault 
  name: keyname
}

var keyuriwithversion = split(key.properties.keyUriWithVersion, '/') 
output serverkeyname string = '${keyvaultname}_${keyname}_${keyuriwithversion[5]}'
output keyuri string = key.properties.keyUriWithVersion
