terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform-prod"
    key    = "coast/prod/nlb/configuratorService/us-west-2-ingest/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "prod-west-configds-ingest-nlb" {
  source                           = "../../../../../modules/nlb"
  aws_vpc                          = "vpc-74695511"
  aws_subnets                      = ["subnet-d5286a8c"]
  aws_region                       = "us-west-2"
  comcast_application_name         = "xreconfigurator"
  comcast_application_role         = "LoadBalancer"
  comcast_application_env          = "prod"
  comcast_iop_appid                = "31865"
  hc_call_protocol                 = "HTTP"
  enable_cross_zone_load_balancing = false
  description                      = "NLB for XRE Configurator DS - Ingest - PROD"
  deployment_type                  = "XVP CS Terraform"
  enable_deletion_protection       = true
  health_api                       = "/allheartbeat"
  application_port                 = "9480"
}

#For PROD, standard LB count is 1.
#Workspace naming format is xreconfigds_ingest_nlb_aw_(base date)_(iteration number)
#This is a special dedicated LB for the ingest.configuratorservice.coast.xcal.tv (xrecowfish.configuratorservice.appds.r53.xcal.tv) endpoint