terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform-prod"
    key    = "coast/prod/nlb/appdiscoveryService/us-east-2/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "prod-ohio-appdiscoveryService-nlb" {
  source                           = "../../../../../modules/nlb"
  aws_vpc                          = "vpc-8918a4e1"
  aws_subnets                      = ["subnet-918f79eb"]
  aws_region                       = "us-east-2"
  comcast_application_name         = "ads"
  comcast_application_role         = "LoadBalancer"
  comcast_application_env          = "prod"
  comcast_iop_appid                = "31851"
  application_port                 = "9472"
  hc_call_protocol                 = "HTTP"
  health_api                       = "/allheartbeat"
  enable_cross_zone_load_balancing = false
  description                      = "NLB For appdiscoveryService - PROD"
  deployment_type                  = "XVP CS Terraform"
  enable_deletion_protection       = true
  iteration                        = var.iteration
}

#For PROD, standard LB count is 12.
#Workspace naming format is adsds_nlb_ao_(base date)_(iteration number)