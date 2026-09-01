variable "application_version" {
  description = "Service Version"
  type        = string
#  default     = "2.56.15"
}

variable "version_id" {
  description = "ASG Iteration With Respect To Service Version (Start with 1 if first iteration)"
  type        = number
#  default     = "1"
}

variable "role_id" {
  description = "The role ID for Vault authentication"
  type        = string
}

variable "secret_id" {
  description = "The secret ID for Vault authentication"
  type        = string
}