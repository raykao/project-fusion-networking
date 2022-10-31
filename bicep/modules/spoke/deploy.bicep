@maxLength(10)
param prefix string
param location string
targetScope = 'subscription'

resource spokeResourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: '${prefix}-spoke-rg'
  location: location
}

module spokeNetwork 'network.bicep' = {
  name: 'spokeNetworkModule'
  scope: spokeResourceGroup
  params: {
    location: spokeResourceGroup.location
  }
}
