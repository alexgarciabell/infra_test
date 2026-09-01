
/*
  Refer the below doc and read the comments in this terraform script before making changes to the Security group.
  https://etwiki.sys.comcast.net/display/ICFAR/CustomSplitEvaluator+-+Security+Groups+for+Load+Balancers
*/

variable "AWS_N_Virginia" {
  type        = "list"
  description = "N. Virginia - TVX-DO"
  default     = ["96.115.88.0/23"]
}

variable "AWS_Oregon" {
  type        = "list"
  description = "Oregon - TVX-DO"
  default     = ["96.115.90.0/23"]
}

variable "xQube" {
    type        = "list"
    description = "xQube"
    default     = ["96.118.128.0/20"]
}

/* We use Overcast Prod (instead of CI) CIDRs since Overcast does cert checks from its Prod instances */
variable "Overcast" {
  type        = "list"
  description = "Overcast"
  default     = ["96.114.96.0/24", "96.114.97.0/24", "96.114.98.0/24"]
}

variable "Localhost" {
  type        = "list"
  description = "Localhost"
  default     = ["10.0.0.0/8"]
}