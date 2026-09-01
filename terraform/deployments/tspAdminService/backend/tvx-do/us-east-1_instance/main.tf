terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform"
    key    = "coast/tvx-do/dataService/tspadmin/us-east-1-instance/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "ci-east-tspadmin" {
  source                      = "../../../../../modules/tspAdminInstance"
  aws_instance_type           = "c5.xlarge"
  aws_security_groups         = ["sg-74b49806", "sg-a8e1eccd", "sg-13387267", "sg-88b78bed", "sg-f1be0b8d"]
  aws_region                  = "us-east-1"
  user_data                   = "${file("userdata_east")}"
  aws_subnets                 = ["subnet-e42182bd"]
  comcast_application_name    = "tspadmin"
  comcast_application_role    = "tspadmin"
  comcast_application_env     = "ci"
  comcast_iop_appid           = "108479"
  comcast_service_name        = "tspui"
  domain                      = "do.xcal.tv"
  data_center                 = "de"
  name                        = "xvpsvc"
  application_version         = var.application_version
  version_id                  = var.version_id
  role_id                     = var.role_id
  secret_id                   = var.secret_id
}