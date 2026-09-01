terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform-prod"
    key    = "coast/prod/nlb/epsadmin/us-east-1/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "prod-east-epsadmin-nlb" {
  source                           = "../../../../../modules/nlb"
  aws_vpc                          = "vpc-08b9236c"
  aws_subnets                      = ["subnet-da41b882"]
  aws_region                       = "us-east-1"
  comcast_application_name         = "epsadmin"
  comcast_application_role         = "LoadBalancer"
  comcast_application_env          = "prod"
  comcast_iop_appid                = "31858"
  hc_call_protocol                 = "HTTP"
  enable_cross_zone_load_balancing = false
  description                      = "NLB For epsadmin - PROD"
  deployment_type                  = "XVP CS Terraform"
  enable_deletion_protection       = true
  health_api                       = "/allheartbeat"
  application_port                 = "9443"
  iteration                        = var.iteration
}

#Workspace naming format is epsadmin_nlb_ae_(base date)_(iteration number)