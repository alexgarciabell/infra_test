terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform"
    key    = "coast/ci/nlb/epsDataService/us-west-2/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "ci-west-epsDataService-nlb" {
  source                           = "../../../../../modules/nlb"
  aws_vpc                          = "vpc-ffc0399a"
  aws_subnets                      = ["subnet-66fb3103"]
  aws_region                       = "us-west-2"
  comcast_application_name         = "eps"
  comcast_application_role         = "LoadBalancer"
  comcast_application_env          = "ci"
  comcast_iop_appid                = "31858"
  hc_call_protocol                 = "HTTP"
  enable_cross_zone_load_balancing = false
  description                      = "NLB For epsDataService - CI"
  deployment_type                  = "XVP CS Terraform"
  enable_deletion_protection       = true
  health_api                       = "/allheartbeat"
  application_port                 = "9483"
  iteration                        = var.iteration
}

#For CI, standard LB count is 1.
#Workspace naming format is epsds_nlb_aw_(base date)_(iteration number)