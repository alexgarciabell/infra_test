terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform-prod"
    key    = "coast/tvx-appds/dataService/cmTagWebService/us-east-1/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "prod-east-cmTagWebService" {
  source                      = "../../../../../modules/dataService"
  instance_type               = "c5.xlarge"
  security_groups             = ["sg-39f23949", "sg-0ba31f5444e283d9b", "sg-01bcecb41607a46c4", "sg-09ad8fc2f6e838f55", "sg-060200d55e68865ee"]
  aws_region                  = "us-east-1"
  single_subnet_instance_count = 1
  subnet_id                   = "subnet-da41b882"
  user_data                   = "${file("userdata_east_prod")}"
  vpc_id                      = "vpc-08b9236c"
  comcast_application_name    = "taggingservice"
  comcast_application_role    = "tagui"
  comcast_application_env     = "prod"
  comcast_iop_appid           = "31921"
  comcast_service_name        = "tagui"
  domain                      = "appds.xcal.tv"
  key_pair                    = "coast-master-key-prod"
  data_center                 = "ae"
  role_id                     = "${var.role_id}"
  secret_id                   = "${var.secret_id}"
}

#For PROD, standard UI host count is 1.
#Workspace naming format is tagportal_(version)_ae_(iteration number)