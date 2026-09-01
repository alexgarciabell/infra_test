terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform"
    key    = "coast/tvx-do/dataService/tspadmin/us-west-2-instance/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "ci-west-tspadmin" {
  source                      = "../../../../../modules/tspAdminInstance"
  aws_instance_type           = "c5.xlarge"
  aws_security_groups         = ["sg-d8da89a5", "sg-b0000dcc", "sg-28e5374f", "sg-f57d2d91"]
  aws_region                  = "us-west-2"
  user_data                   = "${file("userdata_west")}"
  aws_subnets                 = ["subnet-66fb3103"]
  comcast_application_name    = "tspadmin"
  comcast_application_role    = "tspadmin"
  comcast_application_env     = "ci"
  comcast_iop_appid           = "108479"
  comcast_service_name        = "tspui"
  domain                      = "do.xcal.tv"
  data_center                 = "dw"
  name                        = "xvpsvc"
  application_version         = var.application_version
  version_id                  = var.version_id
  role_id                     = var.role_id
  secret_id                   = var.secret_id
}