param location string = resourceGroup().location

var apimSubnetName = 'apimSubnet'
var loadbalancerSubnetName = 'loadbalancerSubnet'
var workloadSubnetName = 'workloadSubnet'
var azureFirewallSubnetName = 'AzureFirewallSubnet'

resource apimSubnetNsg 'Microsoft.Network/networkSecurityGroups@2022-01-01' = {
  name: '${apimSubnetName}-nsg'
  location: location
  properties: {
    securityRules: [
      
    ]
  }
}

resource loadbalancerSubnetNsg 'Microsoft.Network/networkSecurityGroups@2022-01-01' = {
  name: '${loadbalancerSubnetName}-nsg'
  location: location
  properties: {
    securityRules: [
      
    ]
  }
}

resource workloadSubnetNsg 'Microsoft.Network/networkSecurityGroups@2022-01-01' = {
  name: '${workloadSubnetName}-nsg'
  location: location
  properties: {
    securityRules: [
      
    ]
  }
}

// resource defaultRouteTable 'Microsoft.Network/routeTables@2022-05-01' = {
//   name: 'defaultRouteTable'
//   location: location
//   properties: {
//     routes: [
//       {
//         name: 'defaultRoute'
//         properties: {
//           addressPrefix: '0.0.0.0/0'
//           nextHopIpAddress: ''
//           nextHopType: 'VirtualAppliance'
//         }
//       }

//     ]
//   }
// }

resource vnet 'Microsoft.Network/virtualNetworks@2022-01-01' = {
  name: 'hub-vnet'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    subnets: [
      {
        name: apimSubnetName
        properties: {
          addressPrefix: '10.0.0.0/24'
          networkSecurityGroup: {
            id: apimSubnetNsg.id
          }
        }
      }
      {
        name: azureFirewallSubnetName
        properties: {
          addressPrefix: '10.0.1.0/26'
        }
      }
      {
        name: loadbalancerSubnetName
        properties: {
          addressPrefix: '10.0.1.0/24'
          networkSecurityGroup: {
            id: loadbalancerSubnetNsg.id
          }
        }
      }
      {
        name: workloadSubnetName
        properties: {
          addressPrefix: '10.0.4.0/22'
          networkSecurityGroup: {
            id: workloadSubnetNsg.id
          }
        }
      }
    ]
  }

  resource apimSubnet 'subnets' existing = {
    name: apimSubnetName
  }

  resource workloadSubnet 'subnets' existing = {
    name: 'workloadSubnet'
  }
}

output vnetId string = vnet.id
output apimSubnetId string = vnet::apimSubnet.id
output workloadSubnetId string = vnet::workloadSubnet.id
