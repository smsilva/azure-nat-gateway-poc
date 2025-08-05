locals {
  vnets = {
    hub = {
      name          = "hub"
      address_space = "10.255.0.0/16"

      subnets = {
        firewall = {
          name           = "AzureFirewallSubnet"
          address_prefix = "10.255.0.0/26"
        }

        bastion = {
          name           = "AzureBastionSubnet"
          address_prefix = "10.255.0.64/26"
        }
      }
    }

    spokes = {
      core = {
        name          = "spoke-core"
        address_space = "10.0.0.0/16"

        subnets = {
          workloads = {
            name           = "workloads"
            address_prefix = "10.0.0.0/26"
          }

          databases = {
            name           = "databases"
            address_prefix = "10.0.0.64/26"
          }

          container_app_environment = {
            name           = "container-app-environment"
            address_prefix = "10.0.1.0/24"
          }
        }
      }
    }
  }
}
