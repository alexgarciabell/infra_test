terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform-prod"
    key    = "coast/tvx-appds/dataService/cmTagDatsService/us-west-2-asg/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "prod-autoscaling-west-cmtagds"{
  source                      = "../../../../../modules/autoscaling/with_no_nlb"
  aws_instance_type           = "c5.xlarge"
#tag-service-haproxy-west - sg-06f4d98acf6e3d475
  aws_security_groups         = ["sg-f545c58f", "sg-e5cbb89f", "sg-0a84b276c07a06611", "sg-0e091a73", "sg-06f4d98acf6e3d475"]
  aws_region                  = "us-west-2"
  aws_subnets                 = ["subnet-d5286a8c"]
  user_data                   = "${file("userdata_west_prod")}"
  comcast_application_name    = "taggingservice"
  comcast_application_role    = "tagds"
  comcast_application_env     = "prod"
  comcast_iop_appid           = "31928"
  comcast_service_name        = "tagds"
  domain                      = "appds.xcal.tv"
  data_center                 = "aw"
  name                        = "xvpsvc"
  desired_capacity            = 35
  min_size                    = 35
  max_size                    = 50
  cpu_min                     = 50
  cpu_max                     = 70
  health_check_type           = "ELB"
  application_version         = var.application_version
  deployment_type             = "Auto Scaling Group"
  description                 = "description about release"
  version_id                  = var.version_id
}

#For PROD, standard DS host count is 35.
#Workspace naming format is tagds_(version)_aw_(iteration number)