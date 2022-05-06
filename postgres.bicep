param location string 
param servername string
param administratorLogin string
param administratorLoginPassword string

resource pgss 'Microsoft.DBforPostgreSQL/servers@2017-12-01' = {
  name: servername
  location: location
  sku: {
    capacity: 2
    family: 'Gen5'
    name: 'GP_Gen5_2'
    tier: 'GeneralPurpose'
  }
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    infrastructureEncryption: 'Disabled'
    minimalTlsVersion: 'TLS1_2'
    publicNetworkAccess: 'Disabled'
    sslEnforcement: 'Enabled'
    version: '11'
    administratorLogin: administratorLogin
    administratorLoginPassword: administratorLoginPassword

    storageProfile: {
      backupRetentionDays: 7
      geoRedundantBackup: 'Disabled'
      storageAutogrow: 'Enabled'
      storageMB: 102400
    }
    createMode: 'Default'
  }
}

output pgssprincipalId string = pgss.identity.principalId



