terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform-prod"
    key    = "coast/tvx-appds/jumpProxy/us-east-1/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "prod-east-adsds" {
  source                      = "../../../../modules/jumpProxy"
  instance_type               = "m5.large"
  security_groups             = ["sg-39f23949", "sg-996f84e0", "sg-0e3d8c6cbfe22bfa5", "sg-021d7a7b"]
  aws_region                  = "us-east-1"
  single_subnet_instance_count = 1
  user_data                   = "${file("userdata_east")}"
  vpc_id                      = "vpc-08b9236c"
  subnet_id                   = "subnet-da41b882"
  domain                      = "appds.xcal.tv"
  key_pair                    = "coast-master-key-prod"
  data_center                 = "ae"
}
