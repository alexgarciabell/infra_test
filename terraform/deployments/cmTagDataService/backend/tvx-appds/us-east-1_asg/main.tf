terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform-prod"
    key    = "coast/tvx-appds/dataService/cmTagDataService/us-east-1-asg/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "prod-autoscaling-east-cmtagds" {
  source                      = "../../../../../modules/autoscaling/with_no_nlb"
  aws_instance_type           = "c5.xlarge"
#tag-service-haproxy-east - sg-0b796cf112858b7ee
  aws_security_groups         = ["sg-39f23949", "sg-784b7209", "sg-052433529d8e704f9" , "sg-4ac30f3f", "sg-0b796cf112858b7ee"]
  aws_region                  = "us-east-1"
  aws_subnets                 = ["subnet-da41b882"]
  user_data                   = "${file("userdata_east_prod")}"
  comcast_application_name    = "taggingservice"
  comcast_application_role    = "tagds"
  comcast_application_env     = "prod"
  comcast_iop_appid           = "31928"
  comcast_service_name        = "tagds"
  domain                      = "appds.xcal.tv"
  data_center                 = "ae"
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
#Workspace naming format is tagds_(version)_ae_(iteration number)