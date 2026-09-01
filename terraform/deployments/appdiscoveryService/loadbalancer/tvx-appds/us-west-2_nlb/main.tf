terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform-prod"
    key    = "coast/prod/nlb/appdiscoveryService/us-west-2/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "prod-west-appdiscoveryService-nlb" {
  source                           = "../../../../../modules/nlb"
  aws_vpc                          = "vpc-74695511"
  aws_subnets                      = ["subnet-d5286a8c"]
  aws_region                       = "us-west-2"
  comcast_application_name         = "ads"
  comcast_application_role         = "LoadBalancer"
  comcast_application_env          = "prod"
  comcast_iop_appid                = "31851"
  hc_call_protocol                 = "HTTP"
  application_port                 = "9472"
  health_api                       = "/allheartbeat"
  enable_cross_zone_load_balancing = false
  description                      = "NLB For appdiscoveryService - PROD"
  deployment_type                  = "XVP CS Terraform"
  enable_deletion_protection       = true
  iteration                        = var.iteration
}

#For PROD, standard LB count is 12.
#Workspace naming format is adsds_nlb_aw_(base date)_(iteration number)