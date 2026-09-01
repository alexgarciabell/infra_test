terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform"
    key    = "coast/tvx-do/dataService/cmTagWebService/us-east-1/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "ci-east-cmTagWebService" {
  source                      = "../../../../../modules/dataService"
  instance_type               = "c5.xlarge"
  security_groups             = ["sg-74b49806", "sg-00c93ee44224bd5c8", "sg-01ce77aea6663f4b9"]
  aws_region                  = "us-east-1"
  single_subnet_instance_count = 2
  subnet_id                   = "subnet-e42182bd"
  user_data                   = "${file("userdata_east_ci")}"
  vpc_id                      = "vpc-0cb21169"
  comcast_application_name    = "taggingservice"
  comcast_application_role    = "tagui"
  comcast_application_env     = "ci"
  comcast_iop_appid           = "31921"
  comcast_service_name        = "tagui"
  domain                      = "do.xcal.tv"
  key_pair                    = "coast-master-key-dev"
  data_center                 = "ae"
  role_id                     = "${var.role_id}"
  secret_id                   = "${var.secret_id}"
}

#For CI, standard UI host count is 2.
#Workspace naming format is tagportal_(version)_de_(iteration number)