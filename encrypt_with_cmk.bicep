param serverkeyname string
param uri string
param servername string

resource pgss 'Microsoft.DBforPostgreSQL/servers@2017-12-01' existing = {
  name: servername
}


resource cmk 'Microsoft.DBforPostgreSQL/servers/keys@2020-01-01' = {
  name: serverkeyname
  parent: pgss
  properties: {
    serverKeyType: 'AzureKeyVault'
    uri: uri
  }
}
