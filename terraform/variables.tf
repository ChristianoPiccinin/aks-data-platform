variable "location" {
  description = "Azure region"
  default     = "eastus"
}

variable "prefix" {
  description = "Prefixo para nome dos recursos"
  default     = "aksdata"
}

variable "resource_group_dev" {
  default = "rg-aks-dev"
}

variable "resource_group_prod" {
  default = "rg-aks-prod"
}
