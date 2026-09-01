terraform {
  backend "s3" {
    bucket = "coast-infrastructure"
    key    = "coast/ci/nlb/tspadmin/us-west-2/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "ci-west-tspadmin-nlb" {
  source                           = "../../../../../modules/nlb"
  aws_vpc                          = "vpc-ffc0399a"
  aws_subnets                      = ["subnet-66fb3103"]
  aws_region                       = "us-west-2"
  comcast_application_name         = "tspadmin"
  comcast_application_role         = "LoadBalancer"
  comcast_application_env          = "ci"
  application_port                 = "9443"
  hc_call_protocol                 = "HTTP"
  health_api                       = "/allheartbeat"
  enable_cross_zone_load_balancing = false
  description                      = "NLB For TSP Admin - CI"
  deployment_type                  = "XVP CS Terraform"
  enable_deletion_protection       = true
  iteration                        = var.iteration
}

#Workspace naming format is tspadmin_lb_dw_(base date)_(iteration number)