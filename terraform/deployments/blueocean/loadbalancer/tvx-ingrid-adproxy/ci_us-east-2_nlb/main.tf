terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform"
    key    = "coast/staging/nlb/blueocean/us-east-2/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "ci-east-nlb" {
  source                           = "../../../../../modules/nlb_profile"
  aws_region                       = "us-east-2"
  aws_vpc                          = "vpc-0dc2bb57a8fde711a"
  aws_subnets                      = ["subnet-0776ec04ba261a419"]
  aws_profile                      = "tvx-ingrid-adproxy_acct_02112025"
  comcast_application_name         = "blueocean"
  comcast_application_role         = "LoadBalancer"
  comcast_application_env          = "ci"
  comcast_iop_appid                = "67699"
  application_port                 = "443"
  hc_call_protocol                 = "HTTP"
  health_api                       = "/allheartbeat"
  enable_cross_zone_load_balancing = false
  description                      = "NLB for BlueOcean - CI"
  deployment_type                  = "XVP CS Terraform"
  enable_deletion_protection       = true
  iteration                        = var.iteration
}

#Workspace naming format is blueocean_nlb_de_(base date)_(iteration number)