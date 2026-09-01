variable "access_token" {
    type = string
    description = "An Azure AD access_token"
}

variable "cmi" {
    type = string
    description = "Select the Comcast Machine Image of format [CMI name]"
    default = "NA"
}
