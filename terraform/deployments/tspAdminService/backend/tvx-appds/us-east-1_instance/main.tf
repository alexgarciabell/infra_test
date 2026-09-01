terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform-prod"
    key    = "coast/tvx-appds/dataService/tspadmin/us-east-1-instance/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "prod-east-tspadmin" {
  source                      = "../../../../../modules/tspAdminInstance"
  aws_instance_type           = "c5.xlarge"
  aws_security_groups         = ["sg-39f23949", "sg-996f84e0", "sg-b50adbcf", "sg-096aa2960f02ad591","sg-74212605"]
  aws_region                  = "us-east-1"
  user_data                   = "${file("userdata_east")}"
  aws_subnets                 = ["subnet-da41b882"]
  comcast_application_name    = "tspadmin"
  comcast_application_role    = "tspadmin"
  comcast_application_env     = "prod"
  comcast_iop_appid           = "108479"
  comcast_service_name        = "tspui"
  domain                      = "appds.xcal.tv"
  data_center                 = "ae"
  name                        = "xvpsvc"
  application_version         = var.application_version
  version_id                  = var.version_id
  role_id                     = var.role_id
  secret_id                   = var.secret_id
}