terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform-prod"
    key    = "coast/prod/nlb/cmTagWebService/us-west-2/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "prod-west-cmtagws-nlb" {
  source                           = "../../../../../modules/nlb"
  aws_vpc                          = "vpc-74695511"
  aws_subnets                      = ["subnet-d5286a8c"]
  aws_region                       = "us-west-2"
  comcast_application_name         = "taggingservice"
  comcast_application_role         = "LoadBalancer"
  comcast_application_env          = "prod"
  comcast_iop_appid                = "31921"
  hc_call_protocol                 = "HTTP"
  enable_cross_zone_load_balancing = false
  description                      = "NLB For cmTagWebService - PROD"
  deployment_type                  = "XVP CS Terraform"
  enable_deletion_protection       = true
  health_api                       = "/allheartbeat"
  application_port                 = "9482"
  iteration                        = var.iteration
}

#Workspace naming format is tagportal_nlb_aw_(base date)_(iteration number)