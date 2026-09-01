variable "access_token" {
    type = string
    description = "An Azure AD access_token"
}

variable "cmi" {
    description = "Select the Comcast Machine Image of format [CMI name]"
    type = string
    #default = "NA"
}

variable "role_id" {
  description = "The role ID for Vault authentication"
  type        = string
}

variable "secret_id" {
  description = "The secret ID for Vault authentication"
  type        = string
}