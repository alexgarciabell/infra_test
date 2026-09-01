terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform-prod"
    key    = "coast/prod/nlb/blueocean/us-west-2/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "prod-west-blueocean-nlb" {
  source                           = "../../../../../modules/nlb_profile"
  aws_region                       = "us-west-2"
  aws_vpc                          = "vpc-0d37635f180093974"
  aws_subnets                      = ["subnet-0527663451bb87223"]
  aws_profile                      = "tvx-ingrid-adproxy_acct_02112025"
  comcast_application_name         = "blueocean"
  comcast_application_role         = "LoadBalancer"
  comcast_application_env          = "prod"
  comcast_iop_appid                = "67699"
  application_port                 = "443"
  hc_call_protocol                 = "HTTP"
  health_api                       = "/allheartbeat"
  enable_cross_zone_load_balancing = false
  description                      = "NLB For BlueOcean - PROD"
  deployment_type                  = "XVP CS Terraform"
  enable_deletion_protection       = true
  iteration                        = var.iteration
}

#Workspace naming format is blueocean_nlb_aw_(base date)_(iteration number)