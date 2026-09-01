terraform {
  backend "s3" {
    bucket = "coast-infrastructure"
    key    = "coast/ci/nlb/epsadmin/us-west-2/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "ci-west-epsadmin-nlb" {
  source                           = "../../../../../modules/nlb"
  aws_vpc                          = "vpc-ffc0399a"
  aws_subnets                      = ["subnet-66fb3103"]
  aws_region                       = "us-west-2"
  comcast_application_name         = "epsadmin"
  comcast_application_role         = "LoadBalancer"
  comcast_application_env          = "ci"
  comcast_iop_appid                = "31858"
  hc_call_protocol                 = "HTTP"
  enable_cross_zone_load_balancing = false
  description                      = "NLB For epsadmin - CI"
  deployment_type                  = "XVP CS Terraform"
  enable_deletion_protection       = true
  health_api                       = "/allheartbeat"
  application_port                 = "9443"
  iteration                        = var.iteration
}

#Workspace naming format is epsadmin_nlb_dw_(base date)_(iteration number)