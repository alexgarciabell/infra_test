terraform {
  backend "s3" {
    bucket = "coast-infrastructure"
    key    = "coast/ci/nlb/configuratorAdminService/us-east-1/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "ci-east-configadmin" {
  source                     = "../../../../../modules/nlb"
  aws_region                 = "us-east-1"
  aws_vpc                    = "vpc-0cb21169"
  aws_subnets                = ["subnet-e42182bd"]
  comcast_application_name   = "xreconfiguratoradmin"
  comcast_application_role   = "network_load_balancer"
  application_port           = "9443"
  comcast_application_env    = "ci"
  description                = "NLB For xreconfiguratoradmin - CI"
  deployment_type            = "XVP CS Terraform"
  enable_deletion_protection = true
  health_api                 = "/allheartbeat"
  hc_call_protocol           = "HTTP"
  iteration                        = var.iteration
}

#Workspace naming format is xreconfigadmin_lb_de_(base date)_(iteration number)