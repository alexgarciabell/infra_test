terraform {
  backend "s3" {
    bucket = "coast-infrastructure"
    key    = "coast/ci/nlb/appdiscoveryService/us-east-1/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "ci-east-appdiscoveryService-nlb" {
  source                           = "../../../../../modules/nlb"
  aws_vpc                          = "vpc-0cb21169"
  aws_subnets                      = ["subnet-e42182bd"]
  aws_region                       = "us-east-1"
  comcast_application_name         = "ads"
  comcast_application_role         = "LoadBalancer"
  comcast_application_env          = "ci"
  comcast_iop_appid                = "31851"
  hc_call_protocol                 = "HTTP"
  enable_cross_zone_load_balancing = false
  description                      = "NLB For appdiscoveryService - CI"
  deployment_type                  = "XVP CS Terraform"
  enable_deletion_protection       = true
  health_api                       = "/allheartbeat"
  application_port                 = "9472"
  iteration                        = var.iteration
}

#For CI, standard LB count is 1.
#Workspace naming format is adsds_nlb_de_(base date)_(iteration number)