variable "application_version" {
  description = "suffix of the instance name"
  type        = string
  default     = "1.0.0"
}

variable "version_id" {
  description = "suffix of the instance name"
  type        = number
  default     = "1"
}

variable "role_id" {
  description = "The role ID for Vault authentication"
  type        = string
}

variable "secret_id" {
  description = "The secret ID for Vault authentication"
  type        = string
}
