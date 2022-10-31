param location string = resourceGroup().location

var loadbalancerSubnetName = 'loadbalancerSubnet'
var workloadSubnetName = 'workloadSubnet'

resource workloadSubnetNsg 'Microsoft.Network/networkSecurityGroups@2022-01-01' = {
  name: '${workloadSubnetName}-nsg'
  location: location
  properties: {
    securityRules: [
      
    ]
  }
}

resource vnet 'Microsoft.Network/virtualNetworks@2022-01-01' = {
  name: 'hub-vnet'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.1.0.0/16'
      ]
    }
    subnets: [
      {
        name: loadbalancerSubnetName
        properties: {
          addressPrefix: '10.1.1.0/24'
        }
      }
      {
        name: workloadSubnetName
        properties: {
          addressPrefix: '10.1.4.0/22'
          networkSecurityGroup: {
            id: workloadSubnetNsg.id
          }
        }
      }
    ]
  }

  resource loadbalancerSubnet 'subnets' existing = {
    name: loadbalancerSubnetName
  }

  resource workloadSubnet 'subnets' existing = {
    name: loadbalancerSubnetName
  }
}

output vnetId string = vnet.id
output loadbalancerSubnetId string = vnet::loadbalancerSubnet.id
output workloadSubnetId string = vnet::workloadSubnet.id
