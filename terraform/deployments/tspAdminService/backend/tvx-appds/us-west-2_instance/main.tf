terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform-prod"
    key    = "coast/tvx-appds/dataService/tspadmin/us-west-2-instance/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "prod-west-tspadmin" {
  source                      = "../../../../../modules/tspAdminInstance"
  aws_instance_type           = "c5.xlarge"
  aws_security_groups         = ["sg-695f640d", "sg-e4dadb82", "sg-e5cbb89f", "sg-0c52413f6f931c854","sg-e5cbb89f"]
  aws_region                  = "us-west-2"
  user_data                   = "${file("userdata_west")}"
  aws_subnets                 = ["subnet-d5286a8c"]
  comcast_application_name    = "tspadmin"
  comcast_application_role    = "tspadmin"
  comcast_service_name        = "tspui"
  comcast_application_env     = "prod"
  comcast_iop_appid           = "108479"
  domain                      = "appds.xcal.tv"
  data_center                 = "aw"
  name                        = "xvpsvc"
  application_version         = var.application_version
  version_id                  = var.version_id
  role_id                     = var.role_id
  secret_id                   = var.secret_id
}