terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform-prod"
    key    = "coast/tvx-appds/dataService/cmTagDataService/us-east-2-asg/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "prod-autoscaling-ohio-cmtagds" {
  source                      = "../../../../../modules/autoscaling/with_no_nlb"
  aws_instance_type           = "c5.xlarge"
#tag-service-haproxy-ohio - sg-0ac560ce709040bb6
  aws_security_groups         = ["sg-0d23099147f350ce3", "sg-6ed1db05", "sg-01082ccfa43c59529" ,"sg-03b36e730e5a07e45", "sg-0ac560ce709040bb6"]
  aws_region                  = "us-east-2"
  aws_subnets                 = ["subnet-918f79eb"]
  user_data                   = "${file("userdata_ohio_prod")}"
  comcast_application_name    = "taggingservice"
  comcast_application_role    = "tagds"
  comcast_application_env     = "prod"
  comcast_service_name        = "tagds"
  comcast_iop_appid           = "31928"
  domain                      = "appds.xcal.tv"
  data_center                 = "ao"
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
#Workspace naming format is tagds_(version)_ao_(iteration number)