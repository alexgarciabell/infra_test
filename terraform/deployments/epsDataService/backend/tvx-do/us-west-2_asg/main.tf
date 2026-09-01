terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform"
    key    = "coast/tvx-do/dataService/epsds/us-west-2-asg/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "ci-autoscaling-west-epsds" {
  source                      = "../../../../../modules/autoscaling/with_no_nlb"
  aws_instance_type           = "c5.xlarge"
  aws_security_groups         = ["sg-d8da89a5", "sg-b0000dcc", "sg-6776cd02", "sg-f57d2d91", "sg-28e5374f"]
  aws_region                  = "us-west-2"
  user_data                   = "${file("userdata_west")}"
  aws_subnets                 = ["subnet-66fb3103"]
  comcast_application_name    = "eps"
  comcast_application_role    = "epsds"
  comcast_application_env     = "ci"
  comcast_iop_appid           = "31858"
  comcast_service_name        = "epsds"
  domain                      = "do.xcal.tv"
  data_center                 = "dw"
  name                        = "xvpsvc"
  desired_capacity            = 3
  min_size                    = 3
  max_size                    = 5
  cpu_min                     = 50
  cpu_max                     = 70
  health_check_type           = "ELB"
  application_version         = var.application_version
  deployment_type             = "Auto Scaling Group"
  description                 = "description about release"
  version_id                  = var.version_id
  role_id                     = var.role_id
  secret_id                   = var.secret_id
}

#For CI, standard DS host count is 3.
#Workspace naming format is epsds_(version)_de_(iteration number)