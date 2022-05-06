param keyvaultname string 
param tenantId string
param pgssprincipalId string

resource keyVault  'Microsoft.KeyVault/vaults@2019-09-01' existing = {
  name: keyvaultname
}

resource kvaccesspolicy 'Microsoft.KeyVault/vaults/accessPolicies@2021-11-01-preview' = {
  parent: keyVault
  name: 'add'
  properties: {
    accessPolicies: [
      {
        objectId: pgssprincipalId
        permissions: {
          keys: [ 
            // used all as this is a test
            'all'
          ]
        }
        tenantId: tenantId
      }
    ]
  }
}
