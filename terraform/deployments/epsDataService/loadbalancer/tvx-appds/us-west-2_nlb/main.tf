terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform-prod"
    key    = "coast/prod/nlb/epsDataService/us-west-2/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "prod-west-epsDataService-nlb" {
  source                           = "../../../../../modules/nlb"
  aws_region                       = "us-west-2"
  aws_vpc                          = "vpc-74695511"
  aws_subnets                      = ["subnet-d5286a8c"]
  comcast_application_name         = "eps"
  comcast_application_role         = "LoadBalancer"
  comcast_application_env          = "prod"
  comcast_iop_appid                = "31858"
  application_port                 = "9483"
  hc_call_protocol                 = "HTTP"
  health_api                       = "/allheartbeat"
  enable_cross_zone_load_balancing = false
  description                      = "NLB For epsDataService - PROD"
  deployment_type                  = "XVP CS Terraform"
  enable_deletion_protection       = true
  iteration                        = var.iteration
}

#Workspace naming format is epsDataService_nlb_aw_(base date)_(iteration number)