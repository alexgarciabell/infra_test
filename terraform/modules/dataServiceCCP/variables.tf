variable "access_token" {
  type = string
}

variable "region" {
  type        = string
  description = "CCP Region"
}

variable "az" {
  type        = string
  description = "CCP AZ"
}

variable "account_id" {
  type        = string
  description = "CCP Account ID"
}

variable "account_name" {
  type        = string
  description = "CCP Account name"
}

variable "data_center" {
  description = "datacenter in instance"
}

variable "catalog_item_name" {
  type        = string
  description = "Name of the catalog item to deploy"
}

variable "instance_count" {
  type        = number
  description = "Number of machines to build"
}

variable "flavor" {
  type        = string
  description = "Select the Flavor (CPU/memory size)"
}

variable "tenant" {
  type        = string
  description = "Select Network Tenant"
}

variable "rail" {
  type        = string
  description = "Select Network Rail"
}

variable "cmi" {
  type        = string
  description = "Select the Comcast Machine Image"
}

variable "ipv" {
  type        = string
  description = "Select the IP Address type (IPv6 = Single Stack, IPv4_IPv6 = Dual Stack)"
}

variable "deployment_count" {
  type        = number
  description = "Number of deployments to create"
}

variable "description" {
  type        = string
  description = "Description of Deployment - Optional"
}

variable "cloud_init" {
  type        = string
  description = "Enter any Cloud-init script (user data). Must begin with #cloud-config. See https://cloudinit.readthedocs.io/en/latest/index.html"
}

variable "bootcapacity" {
  type        = number
  description = "Size of the main disk.  50-1000 GB. Default: 50"
  default     = 50
}

variable "prefix_name" {
  description = "Hostname of instance"
  default     = "xvpsvc"
}

variable "comcast_application_name" {
  description = "The 'application name' describes the high-level service or component that the resource is associated with"
}

variable "comcast_application_role" {
  description = "The 'application role' describes functionally how the infrastructure component fits in to the overall deployment architecture"
}

variable "comcast_application_env" {
  description = "The 'application environment' describes the service level/operating tier of the infrastructure component."
}

variable "deployment_type" {
  description = "The strategy used to deploy the instance"
  default     = "COAST Infrastructure Terraform"
}


#Timeout variables
variable "tcreate" {
  description = "Timeout period for terraform to create the resources."
  type        = string
  default     = "60m"
}

variable "tdelete" {
  description = "Timeout period for terraform to delete the resources."
  type        = string
  default     = "60m"
}

variable "tupdate" {
  description = "Timeout period for terraform to update the resources."
  type        = string
  default     = "60m"
}

variable "devhub_appid" {
  description = "The iTRC/DevHub id for the service"
}

variable "full_env" {
  description = "An expanded form representing the environment of the resource. Values we will use are: production, development, ci, staging, qa"
}

variable "resource_type" {
  description = "Identifier for what type of resource the host is. Values we will use are: app (application host), web (UI host), load (load balancer)"
}

#For Comcast Vault and using runcmd in Terraform
variable "role_id" {
  description = "The role ID for Vault authentication"
  type        = "string"
}

variable "secret_id" {
  description = "The secret ID for Vault authentication"
  type        = "string"
}