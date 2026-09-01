terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform-prod"
    key    = "coast/prod/nlb/configuratorService/us-east-1/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "prod-east-configds-nlb" {
  source                           = "../../../../../modules/nlb"
  aws_vpc                          = "vpc-08b9236c"
  aws_subnets                      = ["subnet-da41b882"]
  aws_region                       = "us-east-1"
  comcast_application_name         = "xreconfigurator"
  comcast_application_role         = "LoadBalancer"
  comcast_application_env          = "prod"
  comcast_iop_appid                = "31865"
  hc_call_protocol                 = "HTTP"
  enable_cross_zone_load_balancing = false
  description                      = "NLB For configuratorService - PROD"
  deployment_type                  = "XVP CS Terraform"
  enable_deletion_protection       = true
  health_api                       = "/allheartbeat"
  application_port                 = "9480"
  iteration                        = var.iteration
}

#For PROD, standard LB count is 2+1.
#Workspace naming format is xreconfigds_nlb_ae_(base date)_(iteration number)
#One of the LBs is used exclusively for ingest processes. This LB should be behind xrecowfish.configuratorservice.appds.r53.xcal.tv.
#The SG sg-0e61a5bacc3b3417c is for the ingest LB, sg-410e7034 is for the standard LBs. To make things easier to manage, both are in the SG list.