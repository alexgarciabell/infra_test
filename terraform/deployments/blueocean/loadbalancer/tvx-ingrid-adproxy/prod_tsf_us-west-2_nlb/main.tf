terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform-prod"
    key    = "coast/tvx-ingrid-adproxy/nlb/blueocean/prod-tsf-us-west-2/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "prod-tsf-west-nlb" {
  source                           = "../../../../../modules/nlb_profile"
  aws_region                       = "us-west-2"
  aws_vpc                          = "vpc-0112ca7406c72b4c8"
  aws_subnets                      = ["subnet-0b77a3bd071f4655d"]
  aws_profile                      = "tvx-ingrid-adproxy_acct_02112025"
  comcast_application_name         = "blueocean"
  comcast_application_role         = "LoadBalancer"
  comcast_application_env          = "prod"
  comcast_iop_appid                = "67699"
  application_port                 = "443"
  hc_call_protocol                 = "HTTP"
  health_api                       = "/allheartbeat"
  enable_cross_zone_load_balancing = false
  description                      = "NLB for BlueOcean - PROD TSF"
  deployment_type                  = "XVP CS Terraform"
  enable_deletion_protection       = true
}

#Workspace naming format is blueocean_nlb_de_(base date)_(iteration number)