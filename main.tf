                                                                                                  
# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

# Create a resource group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.resource_group_location

  tags = {
    Environment = var.tag_environment
    Team = var.tag_team
  }
}

# Create a virtual network
resource "azurerm_virtual_network" "vnet" {
  name                = var.network_name
  address_space       = ["10.0.0.0/16"]
  location            = var.resource_group_location
  resource_group_name = azurerm_resource_group.rg.name

  tags = {
    Environment = var.tag_environment
    Team = var.tag_team
  }
}

# Create a subnet
resource "azurerm_subnet" "test" {
   name                 = "subnetTF"
   resource_group_name  = azurerm_resource_group.rg.name
   virtual_network_name = azurerm_virtual_network.vnet.name
   address_prefixes     = ["10.0.1.0/24"]
 }

# Create the AKS cluster
resource "azurerm_kubernetes_cluster" "aks" {
  location            = azurerm_resource_group.rg.location
  name                = var.aks_cluster_name
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = var.aks_dns_prefix

  tags = {
    Environment = var.tag_environment
    Team = var.tag_team
  }

  default_node_pool {
    name       = "agentpool"
    vm_size    = "Standard_D2_v2"
    node_count = var.aks_nodes_count
  }
  
  identity {
    type = "SystemAssigned"
  }
  /*
  network_profile {
    network_plugin    = "kubenet"
    load_balancer_sku = "standard"
  }

  service_principal {
    client_id     = var.aks_service_principal_app_id
    client_secret = var.aks_service_principal_client_secret
  }

*/
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.aks.kube_config_raw

  sensitive = true
}


