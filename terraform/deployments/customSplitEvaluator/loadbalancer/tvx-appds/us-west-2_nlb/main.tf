terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform-prod"
    key    = "coast/prod/nlb/customSplitEvaluator/us-west-2/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "prod-west-customSplitEvaluator-nlb" {
  source                           = "../../../../../modules/nlb"
  aws_vpc                          = "vpc-74695511"
  aws_subnets                      = ["subnet-d5286a8c"]
  aws_region                       = "us-west-2"
  comcast_application_name         = "cseval"
  comcast_application_role         = "LoadBalancer"
  comcast_application_env          = "prod"
  comcast_iop_appid                = "103103"
  hc_call_protocol                 = "HTTP"
  application_port                 = "443"
  health_api                       = "/allheartbeat"
  enable_cross_zone_load_balancing = false
  description                      = "NLB For customSplitEvaluator - PROD"
  deployment_type                  = "XVP CS Terraform"
  enable_deletion_protection       = true
  iteration                        = var.iteration
}

#For PROD, standard LB count is 2.
#Workspace naming format is cse_nlb_aw_(base date)_(iteration number)