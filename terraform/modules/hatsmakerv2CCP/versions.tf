#both variants work with terraform v0.13.7

#terraform {
#  required_providers {
#    vra = {
#      source = "vmware/vra"
#      version = "0.5.4"
#    }
#  }
#  required_version = ">= 0.12"
#}

terraform {
  required_providers {
    null = {
      source = "hashicorp/null"
    }
    vra = {
      source = "vmware/vra"
    }
  }
  required_version = ">= 0.13"
}