@maxLength(10)
param prefix string
param location string
param adminEmail string
param adminName string
param adminPublicKey string

targetScope = 'subscription'

resource hubResourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: '${prefix}-hub-rg'
  location: location
}

module hubNetwork 'network.bicep' = {
  name: 'hubNetworkModule'
  scope: hubResourceGroup
  params: {
    location: hubResourceGroup.location
  }
}

module apim '../apim.bicep' = {
  name: 'apimModule'
  scope: hubResourceGroup
  params: {
    prefix: prefix
    location: location
    adminEmail: adminEmail
    adminName: adminName
    subnetId: hubNetwork.outputs.apimSubnetId
  } 
}

// module aks '../aks.bicep' = {
//   name: 'aksModule'
//   scope: hubResourceGroup
//   params: {
//     prefix: prefix
//     location: location
//     subnetId: hubNetwork.outputs.workloadSubnetId
//     adminPublicKey: adminPublicKey
//   }
// }
