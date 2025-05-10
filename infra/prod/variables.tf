
variable "environment" {
  description = "Environment name (dev or prod)"
  type        = string
}

variable "location" {
  description = "Azure location"
  default     = "East US"
}
