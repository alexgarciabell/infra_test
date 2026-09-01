terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform-prod"
    key    = "coast/prod/nlb/configuratorAdminService/us-west-2/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "prod-west-configadmin" {
  source                     = "../../../../../modules/nlb"
  aws_region                 = "us-west-2"
  aws_vpc                    = "vpc-74695511"
  aws_subnets                = ["subnet-d5286a8c"]
  comcast_application_name   = "xreconfiguratoradmin"
  comcast_application_role   = "network_load_balancer"
  application_port           = "9443"
  comcast_application_env    = "prod"
  description                = "NLB For xreconfiguratoradmin - PROD"
  deployment_type            = "XVP CS Terraform"
  enable_deletion_protection = true
  health_api                 = "/allheartbeat"
  hc_call_protocol           = "HTTP"
  iteration                        = var.iteration
}

#Workspace naming format is xreconfigadmin_lb_aw_(base date)_(iteration number)