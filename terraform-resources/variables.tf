  provider "azurerm" {
  features {}
}

# Define variables for sensitive configuration
variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the Resource Group"
  type        = string
}

variable "location" {
  description = "Location for the Resources"
  type        = string
}

variable "aks_cluster_name" {
  description = "Name of the AKS Cluster"
  type        = string
}

variable "dns_prefix" {
  description = "DNS Prefix for the AKS Cluster"
  type        = string
}

variable "node_count" {
  description = "Number of Nodes in the AKS Cluster"
  type        = number
}

variable "acr_name" {
  description = "Name of the Azure Container Registry"
  type        = string
}

# Resource Group
resource "azurerm_resource_group" "aks_rg" {
  name     = var.resource_group_name
  location = var.location
}

# Azure Container Registry
resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = azurerm_resource_group.aks_rg.name
  location            = azurerm_resource_group.aks_rg.location
  sku                 = "Basic"
  admin_enabled       = true
}

# AKS Cluster
resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_cluster_name
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name
  dns_prefix          = var.dns_prefix

  default_node_pool {
    name       = "default"
    node_count = var.node_count
    vm_size    = "Standard_DS2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  role_based_access_control {
    enabled = true

    azure_active_directory {
      managed = true
    }
  }

  network_profile {
    network_plugin      = "azure"
    dns_service_ip      = "10.2.0.10"
    service_cidr        = "10.2.0.0/16"
    docker_bridge_cidr  = "172.17.0.1/16"
  }

  depends_on = [
    azurerm_container_registry.acr
  ]
}
