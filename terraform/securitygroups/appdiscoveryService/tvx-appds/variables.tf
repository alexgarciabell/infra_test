
/*
  Refer the below doc and read the comments in this terraform script before making changes to the Security group.
  https://etwiki.sys.comcast.net/display/xcalPDEV/ADS+HAProxy+Security+Groups
*/

/* XRE
  "x1:prod:xbo:bows", "x1:prod:xre:requestor0", and "x1:prod:xre:guide:7cf92a" SAT Clients correspond to XRE.
  Contact Evan Gordon, Mykhailo Tatarinov, and Manoj Patel for XRE and OTTX/XRE CIDR ranges. The below doc page
  has all the CIDR blocks except those shared by Manoj Patel (96.113.104.0/22, 96.99.169.0/25, 96.99.171.0/24, 96.99.172.0/24)
  https://etwiki.sys.comcast.net/pages/viewpage.action?pageId=90440505
*/

variable "XRE" {
  type        = "list"
  description = "XRE"
  default     = ["96.114.0.0/16", "96.115.0.0/16", "96.118.0.0/16", "96.119.0.0/16", "162.150.0.0/16", "69.252.0.0/16",
    "96.112.232.0/22", "96.112.149.176/28", "96.112.149.192/28", "96.115.80.0/22", "96.114.96.0/22", "96.114.100.0/22",
    "96.115.136.0/22", "96.113.104.0/22", "96.113.16.0/22", "96.115.84.0/22", "96.114.104.0/22", "96.115.140.0/22",
    "96.113.108.0/22", "96.99.169.0/25", "96.113.232.0/22", "96.99.171.0/24", "96.99.172.0/24", "96.103.112.0/22",
    "96.102.8.0/22", "96.102.232.0/22", "96.97.112.0/22", "96.97.116.0/22", "96.97.120.0/22", "96.97.124.0/22"]
}

/* Codebig
  We are now in TVX-PO and TVX-CH of Codebig. We want to move to their Openstack regions in AS-D and HO-C.
*/

variable "Codebig_TVX_PO" {
  type        = "list"
  description = "Codebig TVX-PO"
  default     = ["96.115.96.0/25", "96.115.112.0/25"]
}

variable "Codebig_TVX_CH" {
  type        = "list"
  description = "Codebig TVX-CH"
  default     = ["96.114.171.0/24", "96.114.172.0/23"]
}

variable "Codebig_AS_D_HO_C_Openstack" {
  type        = "list"
  description = "Codebig AS-D and HO-C in Openstack"
  default     = ["96.116.0.0/14", "96.115.224.0/20"]
}

variable "Overcast" {
  type        = "list"
  description = "Overcast"
  default     = ["96.114.96.0/24", "96.114.97.0/24", "96.114.98.0/24"]
}

variable "Perseus" {
  type        = "list"
  description = "Perseus"
  default     = ["96.112.193.0/24"]
}

/* DVR
  Marc Barrowclift from DVR team shared the CIDR ranges.
*/

variable "DVR" {
  type        = "list"
  description = "DVR"
  default     = ["96.114.116.0/22", "96.115.192.0/22", "96.114.72.0/21", "96.112.80.0/20", "96.115.88.0/22"]
}

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

variable "XRE_xCloud_Ashburn" {
  type        = "list"
  description = "XRE - xCloud - Ashburn"
  default     = ["96.102.83.0/24", "96.103.132.0/22", "96.104.28.0/22", "96.104.32.0/22"]
}

variable "XRE_xCloud_Chicago" {
  type        = "list"
  description = "XRE - xCloud - Chicago"
  default     = ["96.102.1.0/24", "96.102.12.0/22", "96.106.0.0/22", "96.102.60.0/22"]
}

variable "XRE_xCloud_Hillsboro" {
  type        = "list"
  description = "XRE - xCloud - Hillsboro"
  default     = ["96.102.207.0/24", "96.102.248.0/22", "96.103.208.0/22", "96.103.212.0/22"]
}

variable "CodeBig_CCP_Public_Ashburn" {
  type        = "list"
  description = "CodeBig CCP (xCloud) - Public - Ashburn"
  default     = ["96.103.1.160/28"]
}

variable "CodeBig_CCP_Public_Chicago" {
  type        = "list"
  description = "CodeBig CCP (xCloud) - Public - Chicago"
  default     = ["96.102.0.80/28"]
}

variable "CodeBig_CCP_Public_Hillsboro" {
  type        = "list"
  description = "CodeBig CCP (xCloud) - Public - Hillsboro"
  default     = ["96.102.221.192/28"]
}

variable "CodeBig_CCP_Public_Chicago_Ex" {
  type        = "list"
  description = "CodeBig CCP (xCloud) - Public - Chicago Extra"
  default     = ["96.102.0.192/26"]
}

variable "CodeBig_CCP_Public_Hillsboro_Ex" {
  type        = "list"
  description = "CodeBig CCP (xCloud) - Public - Hillsboro Extra"
  default     = ["96.102.221.128/26"]
}

variable "CodeBig_CCP_Public_Ashburn_Ex" {
  type        = "list"
  description = "CodeBig CCP (xCloud) - Public - Ashburn Extra"
  default     = ["96.103.23.0/26"]
}

variable "XRE_Thor_xCloud_Chicago_1" {
  type        = "list"
  description = "OTTX/XRE (Thor) - xCloud - Chicago AZ1a"
  default     = ["96.102.26.0/24"]
}

variable "XRE_Thor_xCloud_Hillsboro_1" {
  type        = "list"
  description = "OTTX/XRE (Thor) - xCloud - Hillsboro AZ1a"
  default     = ["96.102.254.0/24"]
}

variable "XRE_Thor_xCloud_Ashburn_1" {
  type        = "list"
  description = "OTTX/XRE (Thor) - xCloud - Ashburn AZ1a"
  default     = ["96.103.148.0/24"]
}

variable "XRE_GCP_Virginia_1" {
  type        = "list"
  description = "XRE - Google Cloud - Virginia 1"
  default     = ["96.104.42.64/26"]
}
