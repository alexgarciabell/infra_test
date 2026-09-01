
/*
  Refer the below doc and read the comments in this terraform script before making changes to the Security group.
  https://etwiki.sys.comcast.net/display/ICFAR/CustomSplitEvaluator+-+Security+Groups+for+Load+Balancers
*/

variable "AWS_N_Virginia" {
  type        = "list"
  description = "N. Virginia - TVX-APPDS"
  default     = ["96.114.80.0/21", "96.114.108.0/22"]
}

variable "AWS_Ohio" {
  type        = "list"
  description = "Ohio - TVX-APPDS"
  default     = ["96.112.64.0/20"]
}

variable "AWS_Oregon" {
  type        = "list"
  description = "Oregon - TVX-APPDS"
  default     = ["96.114.88.0/21", "96.112.252.0/22"]
}

variable "Overcast" {
  type        = "list"
  description = "Overcast"
  default     = ["96.114.96.0/24", "96.114.97.0/24", "96.114.98.0/24"]
}

variable "xQube" {
    type        = "list"
    description = "xQube"
    default     = ["96.118.128.0/20"]
}