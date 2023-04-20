# 
variable "resource_group_name" {
  default = "ResourceGroup-AKS"
}

variable "resource_group_location" {
  default = "eastus2"
}

variable "network_name" {
  default = "aksNetwork"
}

variable "aks_cluster_name" {
  default = "AKStest"
}

variable "aks_dns_prefix" {
  default = "AKStest"
}

variable "aks_nodes_count" {
  default = 2
}

variable "aks_service_principal_app_id" {
  default = "e7071635-a296-46f9-900e-3fdd39c634c7"
}

variable "aks_service_principal_client_secret" {
  default = "1.K8Q~dkDF2dycEIhW1JI6EkcR8dBHTyJYEEBbN8"
  #a4a880ab-1924-414a-b8a0-377f6ba8afcd
}

variable "tag_environment" {
  default = "DEV"
}

variable "tag_team" {
  default = "DEvOps"
}