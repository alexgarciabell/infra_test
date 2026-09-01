terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform-prod"
    key    = "coast/prod/nlb/tspAdminService/us-east-1/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "prod-east-tspadmin-nlb" {
  source                           = "../../../../../modules/nlb"
  aws_vpc                          = "vpc-08b9236c"
  aws_subnets                      = ["subnet-da41b882"]
  aws_region                       = "us-east-1"
  comcast_application_name         = "tspadmin"
  comcast_application_role         = "LoadBalancer"
  comcast_application_env          = "prod"
  application_port                 = "9443"
  hc_call_protocol                 = "HTTP"
  health_api                       = "/allheartbeat"
  enable_cross_zone_load_balancing = false
  description                      = "NLB For TSP Admin - PROD"
  deployment_type                  = "XVP CS Terraform"
  enable_deletion_protection       = true
  iteration                        = var.iteration
}

#Workspace naming format is tspadmin_lb_ae_(base date)_(iteration number)