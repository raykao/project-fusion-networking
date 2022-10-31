@maxLength(10)
param prefix string
param location string
param adminEmail string
param adminName string
param adminPublicKey string

targetScope = 'subscription'


module hub 'modules/hub/deploy.bicep' = {
  name: 'hubModule'
  params: {
    prefix: prefix
    location: location
    adminEmail: adminEmail
    adminName: adminName
    adminPublicKey: adminPublicKey
  }
}

module spoke 'modules/spoke/deploy.bicep' = {
  name: 'spokeModule'
  params: {
    prefix: prefix
    location: location
  }
}
