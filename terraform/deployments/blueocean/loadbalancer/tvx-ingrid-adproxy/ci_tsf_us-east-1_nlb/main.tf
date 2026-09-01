terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform"
    key    = "coast/tvx-ingrid-adproxy/dataService/nlb/blueocean/ci-tsf-us-east-1-asg/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "ci-tsf-east-nlb" {
  source                           = "../../../../../modules/nlb_profile"
  aws_region                       = "us-east-1"
  aws_vpc                          = "vpc-03893e6980a4a4010"
  aws_subnets                      = ["subnet-042a30bfe2f0239d1"]
  aws_profile                      = "tvx-ingrid-adproxy_acct_02112025"
  comcast_application_name         = "blueocean"
  comcast_application_role         = "LoadBalancer"
  comcast_application_env          = "ci"
  comcast_iop_appid                = "67699"
  application_port                 = "443"
  hc_call_protocol                 = "HTTP"
  health_api                       = "/allheartbeat"
  enable_cross_zone_load_balancing = false
  description                      = "NLB for BlueOcean - CI TSF"
  deployment_type                  = "XVP CS Terraform"
  enable_deletion_protection       = true
  iteration                        = var.iteration
}

#Workspace naming format is blueocean_nlb_de_(base date)_(iteration number)